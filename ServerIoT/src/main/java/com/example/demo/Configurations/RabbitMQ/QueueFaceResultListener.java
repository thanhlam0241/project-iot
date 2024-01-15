package com.example.demo.Configurations.RabbitMQ;
import com.example.demo.Entites.AttendanceLog;
import com.example.demo.Entites.AttendanceMachine;
import com.example.demo.Entites.Socket.Notification;
import com.example.demo.Enums.StatusLog;
import com.example.demo.Models.Response.AttendanceResult;
import com.example.demo.Models.Response.FaceIdResult;
import com.example.demo.Repository.AttendanceLogRepository;
import com.example.demo.Repository.AttendanceMachineRepository;
import com.example.demo.Repository.UserRepository;
import com.example.demo.Services.AttendanceManagerService;
import com.example.demo.Services.AttendanceService;
import com.example.demo.Utils.Resource.RedisResource;
import com.example.demo.Utils.ShiftUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Objects;

@Component
@RequiredArgsConstructor
public class QueueFaceResultListener {
    private static final Logger LOGGER = LoggerFactory.getLogger(QueueFaceResultListener.class);

    @Autowired
    private AmqpTemplate rabbitTemplate;
    @Autowired
    private RedisTemplate<String, String> template;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private AttendanceMachineRepository attendanceMachineRepository;
    @Autowired
    private AttendanceLogRepository attendanceLogRepository;
    @Autowired
    private AttendanceService attendanceService;
    @Autowired
    private AttendanceManagerService attendanceManagerService;
    @Autowired
    private final SimpMessagingTemplate wsTemplate;

    @Value("${rabbitmq.queue.exchange-machine-result}")
    private String nameExchangeMachineResult;

    @RabbitListener(queues = {"${rabbitmq.queue.queue-output-face}"})
    public void consumeJsonMessage(String content) throws IOException {
        LOGGER.info(String.format("Received from machine id: %s", 1));
        // Receive message from attendance machine
//        byte[] body = message.getBody();
//        String s = new String(body);
        String s = content;
        System.out.println("body: " + s);
        ObjectMapper objectMapper = new ObjectMapper();
        FaceIdResult faceIdResult = objectMapper.readValue(s, FaceIdResult.class);
        var redisContent = template.opsForValue().getAndDelete(
                RedisResource.STRING_KEY_PREFIX_DEVICE_TO_FACE + faceIdResult.getRequestId());
        if (redisContent == null) {
            System.out.println(faceIdResult.getRequestId() + ": redisContent is null");
            return;
        }
        var redisContentSplit = redisContent.split(",");
        var deviceId = redisContentSplit[0];
        var datetime = LocalDateTime.parse(redisContentSplit[1]);

        var user = userRepository.findById(faceIdResult.getLabel()).orElse(null);
        AttendanceResult attendanceResult = new AttendanceResult();
        attendanceResult.setDeviceId(deviceId);
        attendanceResult.setTime(datetime.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss")));

        String json = "";
        if (user == null) {
            System.out.println(faceIdResult.getLabel() + ": user is null");
            attendanceResult.setStatus("Người chấm công không tồn tại trong CSDL.");
            json = objectMapper.writeValueAsString(attendanceResult);
            rabbitTemplate.convertAndSend(nameExchangeMachineResult, deviceId, json);
            return;
        }

        var machine = attendanceMachineRepository.findById(deviceId).orElse(null);
        if(machine == null){
            System.out.println(deviceId + ": machine is null");
            attendanceResult.setStatus("Máy chấm công không tồn tại trong CSDL.");
            json = objectMapper.writeValueAsString(attendanceResult);
            rabbitTemplate.convertAndSend(nameExchangeMachineResult, deviceId, json);
            return;
        }

        var machineManagermentUnit = machine.getManagementUnit();
        var userManagementUnit = user.getManagementUnit();

        if(machineManagermentUnit == null || !machineManagermentUnit.getId().equals(userManagementUnit.getId())){
            System.out.println("machineManagermentUnit: " + machineManagermentUnit);
            System.out.println("userManagementUnit: " + userManagementUnit);
            attendanceResult.setStatus("Nhân viên không thuộc đơn vị quản lý của máy chấm công.");
            json = objectMapper.writeValueAsString(attendanceResult);
            rabbitTemplate.convertAndSend(nameExchangeMachineResult, deviceId, json);
            return;
        }

        var shift = ShiftUtil.getShift(datetime.getHour());
        var statusLog = ShiftUtil.getStatusLog(datetime.getHour(), datetime.getMinute());

        var attendanceLogInDb = attendanceLogRepository
                .findByUserIdAndYearAndMonthAndDayOfMonthAndShift(
                        user.getId(),
                        datetime.getYear(),
                        datetime.getMonthValue(),
                        datetime.getDayOfMonth(),
                        shift
                );

        if(attendanceLogInDb != null){
            System.out.println("attendanceLogInDb: " + attendanceLogInDb);
            attendanceResult.setStatus("duplicate");
            json = objectMapper.writeValueAsString(attendanceResult);
            rabbitTemplate.convertAndSend(nameExchangeMachineResult, deviceId, json);
            return;
        }

        AttendanceLog attendanceLog = new AttendanceLog();
        attendanceLog.setManagementUnit(machineManagermentUnit);
        attendanceLog.setAttendanceMachine(machine);
        attendanceLog.setUser(user);
        attendanceLog.setTime(datetime);
        attendanceLog.setDayOfMonth(datetime.getDayOfMonth());
        attendanceLog.setDayOfWeek(datetime.getDayOfWeek().getValue());
        attendanceLog.setHour(datetime.getHour());
        attendanceLog.setMinute(datetime.getMinute());
        attendanceLog.setMonth(datetime.getMonthValue());
        attendanceLog.setQuarter((datetime.getMonthValue() - 1) / 3 + 1);
        attendanceLog.setSecond(datetime.getSecond());
        attendanceLog.setYear(datetime.getYear());
        attendanceLog.setShift(shift);

        attendanceResult.setName(user.getFullName());
        attendanceResult.setEmployeeCode(user.getCode());

        if(statusLog == StatusLog.ABNORMAL){
            attendanceResult.setStatus("abnormal");
            attendanceLog.setAbnormal(true);
            attendanceLog.setOnTime(false);
            attendanceLog.setLate(false);
        }
        else if(statusLog == StatusLog.LATE){
            attendanceResult.setStatus("late");
            attendanceLog.setAbnormal(false);
            attendanceLog.setOnTime(false);
            attendanceLog.setLate(true);
        }
        else if(statusLog == StatusLog.ON_TIME){
            attendanceResult.setStatus("success");
            attendanceLog.setAbnormal(false);
            attendanceLog.setOnTime(true);
            attendanceLog.setLate(false);
        }

        attendanceLogRepository.save(attendanceLog);

        json = objectMapper.writeValueAsString(attendanceResult);
        rabbitTemplate.convertAndSend(nameExchangeMachineResult, deviceId, json);
        String channel = "/topic/message/" + user.getId();
        wsTemplate.convertAndSend(channel, new Notification("Bạn đã chấm công thành công"));
    }
}


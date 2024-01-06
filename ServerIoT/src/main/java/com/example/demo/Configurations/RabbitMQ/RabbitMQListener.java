package com.example.demo.Configurations.RabbitMQ;

import com.example.demo.DTO.AttendanceLog.AttendanceLogCreateDto;
import com.example.demo.Services.AttendanceLogService;
import lombok.RequiredArgsConstructor;
import netscape.javascript.JSObject;
import org.json.JSONObject;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.core.MessageListener;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

@Service
@RequiredArgsConstructor
public class RabbitMQListener implements MessageListener {
    private final AttendanceLogService attendanceLogService;
    private final ModelMapper modelMapper;

    private DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss.SSS Z");
    @Override
    public void onMessage(Message message) {
        try {
            var body = new String(message.getBody());
            System.out.println("Consuming Message - " + new String(message.getBody()));

            JSONObject jsonObject = new JSONObject(body);

//            String currentTime = ZonedDateTime.now().format(formatter);

//            System.out.println("Current Time: " + currentTime);

            String stringTime = jsonObject.getString("time");

            LocalDateTime time = LocalDateTime.parse(stringTime, formatter);
            String userId = jsonObject.getString("userId");
            String attendanceMachineId = jsonObject.getString("attendanceMachineId");
            String featureVector = jsonObject.getString("featureVector");

//            AttendanceLogCreateDto dto = new AttendanceLogCreateDto(time, featureVector, attendanceMachineId, userId);
//            attendanceLogService.insertAttendanceLog(dto);
        } catch (Exception e) {
            System.out.println("Error Consuming Message - " + e.getMessage());
        }
    }
}

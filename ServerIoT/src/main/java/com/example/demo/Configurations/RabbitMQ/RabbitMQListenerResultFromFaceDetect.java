package com.example.demo.Configurations.RabbitMQ;

import com.example.demo.DTO.AttendanceLog.AttendanceLogCreateDto;
import com.example.demo.Services.AttendanceLogService;
import lombok.RequiredArgsConstructor;
import org.json.JSONObject;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.core.MessageListener;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Service
@RequiredArgsConstructor
public class RabbitMQListenerResultFromFaceDetect implements MessageListener {
    private final AttendanceLogService attendanceLogService;
//    private final SimpMessagingTemplate template;

    private DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
    @Override
    public void onMessage(Message message) {
        try {
//            var body = new String(message.getBody());
//            System.out.println("Consuming Message - " + new String(message.getBody()));
//
//            JSONObject jsonObject = new JSONObject(body);
//
////            String currentTime = ZonedDateTime.now().format(formatter);
//
////            System.out.println("Current Time: " + currentTime);
//
//            String stringTime = jsonObject.getString("time");
//
//            LocalDateTime time = LocalDateTime.parse(stringTime, formatter);
//            String userId = jsonObject.getString("userId");
//            String attendanceMachineId = jsonObject.getString("attendanceMachineId");
//
//            AttendanceLogCreateDto dto = new AttendanceLogCreateDto(time, "", attendanceMachineId, userId);
//            var attendanceLog =attendanceLogService.insertAttendanceLog(dto);
//
//            template.convertAndSend("/topic/new-attendance-log", attendanceLog);
            var body = new String(message.getBody());
            System.out.println("Consuming Message - " + new String(message.getBody()));

            JSONObject jsonObject = new JSONObject(body);

//            String currentTime = ZonedDateTime.now().format(formatter);

//            System.out.println("Current Time: " + currentTime);

            // Get data from queue json
            String stringTime = jsonObject.getString("time");
            LocalDateTime time = LocalDateTime.parse(stringTime, formatter);
            String userId = jsonObject.getString("userId");
            String attendanceMachineId = jsonObject.getString("attendanceMachineId");

            // Insert data to database

//            AttendanceLogCreateDto dto = new AttendanceLogCreateDto(time, "", attendanceMachineId, userId);
//            var attendanceLog =attendanceLogService.insertAttendanceLog(dto);


            // Send data to topic websocket
//            template.convertAndSend("/topic/new-attendance-log", attendanceLog);

        } catch (Exception e) {
            System.out.println("Error Consuming Message - " + e.getMessage());
        }
    }
}

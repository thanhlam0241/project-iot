package com.example.demo.Controller;

import com.example.demo.Configurations.RabbitMQ.RabbitMQSender;
import com.example.demo.DTO.AttendanceLog.AttendanceLogCreateDto;
import com.example.demo.DTO.AttendanceLog.AttendanceLogRawDto;
import com.example.demo.Services.AttendanceLogService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@RestController
@RequestMapping("/api/v1/attendance-log")
@RequiredArgsConstructor
public class AttendanceLogController {
    private final Logger logger = LoggerFactory.getLogger(AttendanceLogController.class);

    private final AttendanceLogService attendanceLogService;

    @Autowired
    RabbitMQSender rabbitMQSender;

    @PostMapping()
    public ResponseEntity<String> insertLog(@RequestBody AttendanceLogRawDto body) {
        logger.info("Received request to insert attendance log");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss.SSS Z");
        String stringTime = body.getTime();
        LocalDateTime time = LocalDateTime.parse(stringTime, formatter);
        AttendanceLogCreateDto dto = new AttendanceLogCreateDto();
        dto.setTime(time);
        dto.setFeatureVector(body.getFeatureVector());
        dto.setAttendanceMachineId(body.getAttendanceMachineId());
        dto.setUserId(body.getUserId());
        attendanceLogService.insertAttendanceLog(dto);
        return ResponseEntity.ok("Insert attendance log successfully");
    }
}

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
    private final AttendanceLogService attendanceLogService;

    @PostMapping()
    public ResponseEntity<String> insertLog(@RequestBody AttendanceLogCreateDto body) {
//        attendanceLogService.insertAttendanceLog(body);
        return ResponseEntity.ok("Insert attendance log successfully");
    }
}

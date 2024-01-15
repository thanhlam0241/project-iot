package com.example.demo.Controller;

import com.example.demo.DTO.AttendanceLog.AttendanceLogCreateDto;
import com.example.demo.Services.AttendanceLogService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

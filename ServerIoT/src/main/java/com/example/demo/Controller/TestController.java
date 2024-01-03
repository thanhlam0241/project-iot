package com.example.demo.Controller;


import com.example.demo.Services.AttendanceLogService;
import com.example.demo.Services.AttendanceService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/test")
@RequiredArgsConstructor
public class TestController {
    private final AttendanceLogService service;

    @GetMapping
    public ResponseEntity<String> updateLogs(){
        service.testUpdate();
        return ResponseEntity.ok("Hello");
    }
}

package com.example.demo.Controller;


import com.example.demo.Models.Response.StatisticAttendance;
import com.example.demo.Models.Response.StatisticHuman;
import com.example.demo.Services.AdminService;
import com.example.demo.Services.AttendanceMachineService;
import com.example.demo.Services.ManagementUnitService;
import com.example.demo.Services.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/admin")
@RequiredArgsConstructor
@Slf4j
public class AdminController {
    private final AdminService adminService;

    @GetMapping("/statistic/human")
    public ResponseEntity<StatisticHuman> getStatisticHuman() {
        return ResponseEntity.ok(adminService.getStatisticHuman());
    }

    @GetMapping("/statistic/attendance")
    public ResponseEntity<StatisticAttendance> getStatisticAttendance(@RequestParam int year) {
        return ResponseEntity.ok(adminService.getStatisticAttendance(year));
    }

}

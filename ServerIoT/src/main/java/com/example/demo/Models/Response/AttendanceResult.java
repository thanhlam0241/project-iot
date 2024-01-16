package com.example.demo.Models.Response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AttendanceResult {
    private String deviceId;
    private String name;
    private String employeeCode;
    private String time;
    private String status;
}

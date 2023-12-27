package com.example.demo.DTO.AttendanceLog;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

import java.time.LocalDateTime;

@Data
@RequiredArgsConstructor
@AllArgsConstructor
public class AttendanceLogRawDto {
    private String time;
    private String featureVector;
    private String attendanceMachineId;
    private String userId;
}

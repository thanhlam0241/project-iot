package com.example.demo.DTO.AttendanceLog;

import com.example.demo.Entites.AttendanceMachine;
import com.example.demo.Entites.ManagementUnit;
import com.example.demo.Entites.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.DocumentReference;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class AttendanceLogCreateDto {
    private String featureVector;
    private String attendanceMachineCode;
    private String password;
}

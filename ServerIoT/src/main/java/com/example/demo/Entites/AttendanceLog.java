package com.example.demo.Entites;

import com.example.demo.Enums.Shift;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.DocumentReference;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Document
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AttendanceLog extends BaseEntity {
    private LocalDateTime time;
    private boolean isLate;
//    private boolean isAbsent;
    private boolean isOnTime;
    private boolean isAbnormal;
    private float minutesLate;
    private int year;
    private int month;
    private int quarter;
    private int dayOfMonth;
    private int dayOfWeek;
    private int hour;
    private int minute;
    private int second;
    private Shift shift;

    @DocumentReference
    private User user;

    @DocumentReference
    private ManagementUnit managementUnit;

    @DocumentReference
    private AttendanceMachine attendanceMachine;
}

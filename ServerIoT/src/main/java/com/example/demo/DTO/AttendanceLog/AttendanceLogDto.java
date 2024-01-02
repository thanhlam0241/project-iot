package com.example.demo.DTO.AttendanceLog;

import java.time.LocalDateTime;

public class AttendanceLogDto {
    private LocalDateTime time;
    private boolean isLate;
    private boolean isOnTime;

    public LocalDateTime getTime() {
        return time;
    }

    public void setTime(LocalDateTime time) {
        this.time = time;
    }

    public boolean isLate() {
        return isLate;
    }

    public void setLate(boolean late) {
        isLate = late;
    }

    public boolean isOnTime() {
        return isOnTime;
    }

    public void setOnTime(boolean onTime) {
        isOnTime = onTime;
    }

    public boolean isAbnormal() {
        return isAbnormal;
    }

    public void setAbnormal(boolean abnormal) {
        isAbnormal = abnormal;
    }

    public float getMinutesLate() {
        return minutesLate;
    }

    public void setMinutesLate(float minutesLate) {
        this.minutesLate = minutesLate;
    }

    public String getShift() {
        return shift;
    }

    public void setShift(String shift) {
        this.shift = shift;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getManagementUnitName() {
        return managementUnitName;
    }

    public void setManagementUnitName(String managementUnitName) {
        this.managementUnitName = managementUnitName;
    }

    public String getAttendanceMachineName() {
        return attendanceMachineName;
    }

    public void setAttendanceMachineName(String attendanceMachineName) {
        this.attendanceMachineName = attendanceMachineName;
    }

    private boolean isAbnormal;
    private float minutesLate;
//    private int year;
//    private int month;
//    private int quarter;
//    private int dayOfMonth;
//    private int dayOfWeek;
//    private int hour;
//    private int minute;
//    private int second;
    private String shift;
    private String name;
    private String managementUnitName;
    private String attendanceMachineName;
}

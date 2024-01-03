package com.example.demo.Models.Response;

public class StatisticInMonth {
    private int month;
    private int numberOfAttendance;
    private int numberOfLate;
    private int numberOfOnTime;

    private double percentOfLate;

    public StatisticInMonth() {
    }

    public StatisticInMonth(int month, int numberOfAttendance, int numberOfLate, int numberOfOnTime, float percentOfLate) {
        this.month = month;
        this.numberOfAttendance = numberOfAttendance;
        this.numberOfLate = numberOfLate;
        this.numberOfOnTime = numberOfOnTime;
        this.percentOfLate = percentOfLate;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getNumberOfAttendance() {
        return numberOfAttendance;
    }

    public void setNumberOfAttendance(int numberOfAttendance) {
        this.numberOfAttendance = numberOfAttendance;
    }

    public int getNumberOfLate() {
        return numberOfLate;
    }

    public void setNumberOfLate(int numberOfLate) {
        this.numberOfLate = numberOfLate;
    }

    public int getNumberOfOnTime() {
        return numberOfOnTime;
    }

    public void setNumberOfOnTime(int numberOfOnTime) {
        this.numberOfOnTime = numberOfOnTime;
    }

    public double getPercentOfLate() {
        return percentOfLate;
    }

    public void setPercentOfLate(double percentOfLate) {
        this.percentOfLate = percentOfLate;
    }

}

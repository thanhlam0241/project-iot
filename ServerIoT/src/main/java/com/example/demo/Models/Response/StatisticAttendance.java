package com.example.demo.Models.Response;

import java.util.List;

public class StatisticAttendance {
    int year;
    List<StatisticInMonth> statisticInMonths;

    public StatisticAttendance(int year, List<StatisticInMonth> statisticInMonths) {
        this.year = year;
        this.statisticInMonths = statisticInMonths;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public List<StatisticInMonth> getStatisticInMonths() {
        return statisticInMonths;
    }

    public void setStatisticInMonths(List<StatisticInMonth> statisticInMonths) {
        this.statisticInMonths = statisticInMonths;
    }
}

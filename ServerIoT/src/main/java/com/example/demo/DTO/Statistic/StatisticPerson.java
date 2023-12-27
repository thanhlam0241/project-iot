package com.example.demo.DTO.Statistic;

import com.example.demo.Entites.Statistic;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
@AllArgsConstructor
public class StatisticPerson {
    private String name;
    private String code;
    private String managementUnitName;
    private Statistic statistic;
    int numberOfMorning;
    int numberOfAfternoon;
}

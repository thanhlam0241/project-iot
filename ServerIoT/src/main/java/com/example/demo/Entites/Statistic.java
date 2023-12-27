package com.example.demo.Entites;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Statistic {
    private int numberOfShifts;
    private int numberOfOnTimeShifts;
    private int numberOfLateShifts;
    private int numberOfAbnormalShifts;
    private float numberMinutesLate;
}

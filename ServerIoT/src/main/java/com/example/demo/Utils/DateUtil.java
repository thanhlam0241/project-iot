package com.example.demo.Utils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.zip.DataFormatException;

public class DateUtil {
    public static String formatISODate(int year, int month, int day) throws DataFormatException {
        if(month <= 0 || month >= 13){
            throw new DataFormatException("Month must be between 1 and 12");
        }
        String monthFormat = month < 10 ? String.format("0%s",month) : String.valueOf(month);
        String dayFormat = day < 10 ? String.format("0%s",day) : String.valueOf(day);
        return String.format("%d-%s-%s",year,monthFormat,dayFormat);
    }

    public static LocalDate  stringToDate(String date){
        DateTimeFormatter dateformatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate time = LocalDate.parse(date, dateformatter);
        return time;
    }
}

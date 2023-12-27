package com.example.demo.Utils;

import com.example.demo.Enums.Shift;
import com.example.demo.Enums.StatusLog;

public class ShiftUtil {
    public static Shift getShift(int hour) {
        if(hour >= 7 && hour <= 8)
            return Shift.MORNING;
        else if(hour >= 13 && hour <= 14)
            return Shift.AFTERNOON;
        else return Shift.NONE;
    }

    public static StatusLog getStatusLog(int hour, int minute) {
        if(hour == 7 || hour == 13 || (hour == 8 && minute == 0) || (hour == 14 && minute == 0) ){
            return StatusLog.ON_TIME;
        }
        else if (hour == 8 || hour == 14) {
            return StatusLog.LATE;
        }
        else {
            return StatusLog.ABNORMAL;
        }
    }
}

package com.example.demo.Utils;

import com.example.demo.Enums.Shift;
import com.example.demo.Enums.StatusLog;

public class ShiftUtil {
    public static Shift getShift(int hour) {
        if(hour <= 12)
            return Shift.MORNING;
        else
            return Shift.AFTERNOON;
    }

    public static StatusLog getStatusLog(int hour, int minute) {
        if(hour == 7 || hour == 13 || (hour == 8 && minute == 0) || (hour == 14 && minute == 0) ){
            return StatusLog.ON_TIME;
        }
        else if (hour == 8 || hour == 14) {
            return StatusLog.ON_TIME;
//            return StatusLog.LATE;
        }
        else {
            return StatusLog.ON_TIME;
//            return StatusLog.ABNORMAL;
        }
    }
}

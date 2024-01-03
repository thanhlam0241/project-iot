package com.example.demo.Controller;

import com.example.demo.DTO.AttendanceLog.AttendanceLogDto;
import com.example.demo.Entites.AttendanceLog;
import com.example.demo.Entites.Statistic;
import com.example.demo.Services.AttendanceService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.zip.DataFormatException;

@RestController
@RequestMapping("/api/v1/attendance")
@RequiredArgsConstructor
public class AttendanceController {
    private final Logger logger = LoggerFactory.getLogger(AttendanceController.class);

    private final AttendanceService attendanceService;

    @GetMapping("log/{id}")
    public ResponseEntity<List<AttendanceLogDto>> getAllAttendanceLogsByUserId(
            @PathVariable String id,
            @RequestParam(required = false) String year,
            @RequestParam(required = false) String month,
            @RequestParam(required = false) String quarter
    ) {
        logger.info("Getting attendance logs by userId.");
        List<AttendanceLog> listAttendance = null;

        int yearInt = 0;
        int monthInt = 0;
        int quarterInt = 0;

        if (year != null) {
            yearInt = Integer.parseInt(year);
        }

        if (month != null) {
            monthInt = Integer.parseInt(month);
        }

        if (quarter != null) {
            quarterInt = Integer.parseInt(quarter);
        }

        if(yearInt != 0 && quarterInt != 0) {
            listAttendance = attendanceService.getAttendanceLogsByUserIdAndYearAndQuarter(id, yearInt, quarterInt);
        } else if (yearInt != 0 && monthInt != 0) {
            listAttendance = attendanceService.getAttendanceLogsByUserIdAndYearAndMonth(id, yearInt, monthInt);
        } else if (yearInt != 0) {
            listAttendance = attendanceService.getAttendanceLogsByUserIdAndYear(id, yearInt);
        } else {
            listAttendance = attendanceService.getAttendanceLogsByUserId(id);
        }

        return ResponseEntity.ok(attendanceService.MapToListDto(listAttendance));
    }

    @GetMapping("log/{id}/between")
    public ResponseEntity<List<AttendanceLogDto>>  getLogsBetweenDays(
            @PathVariable String id,
            @RequestParam(required = true) String start,
            @RequestParam(required = true) String end
    ) {
        var results = attendanceService.getAttendanceLogsByUserIdDatesBetween(id, start, end);
        return ResponseEntity.ok(attendanceService.MapToListDto(results));
    }

    @GetMapping("log/{id}/day-between")
    public ResponseEntity<List<AttendanceLogDto>>  getLogsBetweenDaysTime(
            @PathVariable String id,
            @RequestParam(required = true) int startDay,
            @RequestParam(required = true) int startMonth,
            @RequestParam(required = true) int startYear,
            @RequestParam(required = true) int endDay,
            @RequestParam(required = true) int endMonth,
            @RequestParam(required = true) int endYear

    ) throws DataFormatException {
        var results = attendanceService.getAttendanceLogsByUserIdDatesBetween(id,
                startYear, endYear, startMonth, endMonth, startDay, endDay);
        return ResponseEntity.ok(attendanceService.MapToListDto(results));
    }

    @GetMapping("/statistic/{id}/between")
    public ResponseEntity<Statistic> getStatisticByUserIdBetweenDates(
            @PathVariable String id,
            @RequestParam(required = true) String start,
            @RequestParam(required = true) String end
    ) {
        logger.info("Getting attendance logs by userId.");
        Statistic statistic = attendanceService.getStatisticByUserIdBetweenTwoDates(id,start,end);
        return ResponseEntity.ok(statistic);
    }


    @GetMapping("/statistic/{id}")
    public ResponseEntity<Statistic> getStatisticByUserId(
            @PathVariable String id,
            @RequestParam(required = true) String year,
            @RequestParam(required = false) String month,
            @RequestParam(required = false) String quarter
    ) {
        logger.info("Getting attendance logs by userId.");
        Statistic statistic = null;

        int yearInt = 0;
        int monthInt = 0;
        int quarterInt = 0;

        if (year != null) {
            yearInt = Integer.parseInt(year);
        }

        if (month != null) {
            monthInt = Integer.parseInt(month);
        }

        if (quarter != null) {
            quarterInt = Integer.parseInt(quarter);
        }

        if(yearInt != 0 && quarterInt != 0) {
            statistic = attendanceService.getStatisticByUserIdAndYearAndQuarter(id, yearInt, quarterInt);
        } else if (yearInt != 0 && monthInt != 0) {
            statistic = attendanceService.getStatisticByUserIdAndYearAndMonth(id, yearInt, monthInt);
        } else  {
            statistic = attendanceService.getStatisticByUserIdAndYear(id, yearInt);
        }

        return ResponseEntity.ok(statistic);
    }
}

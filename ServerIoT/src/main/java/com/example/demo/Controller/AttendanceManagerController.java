package com.example.demo.Controller;

import com.example.demo.DTO.Statistic.StatisticPerson;
import com.example.demo.Entites.AttendanceLog;
import com.example.demo.Entites.Statistic;
import com.example.demo.Services.AttendanceManagerService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/attendance-manager")
@RequiredArgsConstructor
public class AttendanceManagerController {
    private final Logger logger = LoggerFactory.getLogger(AttendanceManagerController.class);

    private final AttendanceManagerService attendanceManagerService;

    @GetMapping("/statistic/{id}")
    public ResponseEntity<Statistic> getStatisticByManagementUnitId(
            @PathVariable String id,
            @RequestParam(required = true) String year,
            @RequestParam(required = false) String month,
            @RequestParam(required = false) String quarter,
            @RequestParam(required = false) String dayOfMonth
    ){
        logger.info("Getting statistic by management unit id.");
        Statistic statistic = null;

        int yearInt = 0;
        int monthInt = 0;
        int quarterInt = 0;
        int dayOfMonthInt = 0;

        if (year != null) {
            yearInt = Integer.parseInt(year);
        }

        if (month != null) {
            monthInt = Integer.parseInt(month);
        }

        if (quarter != null) {
            quarterInt = Integer.parseInt(quarter);
        }

        if (dayOfMonth != null) {
            dayOfMonthInt = Integer.parseInt(dayOfMonth);
        }

        if(yearInt != 0 && quarterInt != 0) {
            statistic = attendanceManagerService.getStatisticByManagementUnitIdInQuarter(id, yearInt, quarterInt);
        } else if (yearInt != 0 && monthInt != 0 && dayOfMonthInt != 0) {
            statistic = attendanceManagerService.getStatisticByManagementUnitIdInDay(id, yearInt,monthInt, dayOfMonthInt);
        }
        else if (yearInt != 0 && monthInt != 0) {
            statistic = attendanceManagerService.getStatisticByManagementUnitIdInMonth(id, yearInt, monthInt);
        }  else {
            statistic = attendanceManagerService.getStatisticByManagementUnitIdInYear(id, yearInt);
        }

        return ResponseEntity.ok(statistic);
    }

    @GetMapping("/attendance-log/{id}")
    public ResponseEntity<List<AttendanceLog>> getAllAttendanceLogsByManagementUnitId(
            @PathVariable String id,
            @RequestParam(required = false) String year,
            @RequestParam(required = false) String month,
            @RequestParam(required = false) String quarter,
            @RequestParam(required = false) String dayOfMonth
    ) {
        logger.info("Getting attendance logs by management unit id.");
        List<AttendanceLog> listAttendance = null;

        int yearInt = 0;
        int monthInt = 0;
        int quarterInt = 0;
        int dayOfMonthInt = 0;

        if (year != null) {
            yearInt = Integer.parseInt(year);
        }

        if (month != null) {
            monthInt = Integer.parseInt(month);
        }

        if (quarter != null) {
            quarterInt = Integer.parseInt(quarter);
        }

        if (dayOfMonth != null) {
            dayOfMonthInt = Integer.parseInt(dayOfMonth);
        }

        if(yearInt != 0 && quarterInt != 0) {
            listAttendance = attendanceManagerService.getAllAttendanceLogsByManagementUnitIdAndYearAndQuarter(id, yearInt, quarterInt);
        } else if (yearInt != 0 && monthInt != 0 && dayOfMonthInt != 0) {
            listAttendance = attendanceManagerService.getAllAttendanceLogsByManagementUnitIdAndYearAndMonthAndDayOfMonth(id, yearInt, monthInt, dayOfMonthInt);
        } else if (yearInt != 0 && monthInt != 0) {
            listAttendance = attendanceManagerService.getAllAttendanceLogsByManagementUnitIdAndYearAndMonth(id, yearInt, monthInt);
        } else {
            listAttendance = attendanceManagerService.getAllAttendanceLogsByManagementUnitIdAndYear(id, yearInt);
        }

        return ResponseEntity.ok(listAttendance);
    }

    @GetMapping("/statistic/user/{id}")
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
        int dayOfMonthInt = 0;

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
            statistic = attendanceManagerService.getStatisticByUserIdInQuarter(id, yearInt, quarterInt);
        }
        else if (yearInt != 0 && monthInt != 0) {
            statistic = attendanceManagerService.getStatisticByUserIdInMonth(id, yearInt, monthInt);
        }  else {
            statistic = attendanceManagerService.getStatisticByUserIdInYear(id, yearInt);
        }

        return ResponseEntity.ok(statistic);
    }

    @GetMapping("/attendance-log/user/{id}")
    public ResponseEntity<List<AttendanceLog>> getAllAttendanceLogsByUserId(
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
        int dayOfMonthInt = 0;

        if (year != null) {
            yearInt = Integer.parseInt(year);
        }

        if (month != null) {
            monthInt = Integer.parseInt(month);
        }

        if (quarter != null) {
            quarterInt = Integer.parseInt(quarter);
        }

        if (yearInt != 0 && quarterInt != 0) {
            listAttendance = attendanceManagerService.getAllAttendanceLogsByUserIdAndYearAndQuarter(id, yearInt, quarterInt);
        } else if (yearInt != 0 && monthInt != 0) {
            listAttendance = attendanceManagerService.getAllAttendanceLogsByUserIdAndYearAndMonth(id, yearInt, monthInt);
        } else if (yearInt != 0) {
            listAttendance = attendanceManagerService.getAllAttendanceLogsByUserIdAndYear(id, yearInt);
        } else {
            listAttendance = attendanceManagerService.getAllAttendanceLogsByUserId(id);
        }

        return ResponseEntity.ok(listAttendance);
    }

    @GetMapping("/statistic/all")
    public ResponseEntity<Statistic> getAllStatistic(
            @RequestParam(required = false) String year,
            @RequestParam(required = false) String month,
            @RequestParam(required = false) String quarter,
            @RequestParam(required = false) String dayOfMonth
    ) {
        logger.info("Getting statistics of all employees.");
        Statistic statistic = null;

        int yearInt = 0;
        int monthInt = 0;
        int quarterInt = 0;
        int dayOfMonthInt = 0;

        if (year != null) {
            yearInt = Integer.parseInt(year);
        }

        if (month != null) {
            monthInt = Integer.parseInt(month);
        }

        if (quarter != null) {
            quarterInt = Integer.parseInt(quarter);
        }

        if (dayOfMonth != null) {
            dayOfMonthInt = Integer.parseInt(dayOfMonth);
        }

        if(yearInt != 0 && quarterInt != 0) {
            statistic = attendanceManagerService.getStatisticInQuarter(yearInt, quarterInt);
        } else if (yearInt != 0 && monthInt != 0 && dayOfMonthInt != 0) {
            statistic = attendanceManagerService.getStatisticInDay(yearInt, monthInt, dayOfMonthInt);
        } else if (yearInt != 0 && monthInt != 0) {
            statistic = attendanceManagerService.getStatisticInMonth(yearInt, monthInt);
        } else if(yearInt != 0) {
            statistic = attendanceManagerService.getStatisticInYear(yearInt);
        } else {
            statistic = attendanceManagerService.getStatisticInAllTime();
        }

        return ResponseEntity.ok(statistic);
    }

    @GetMapping("/attendance-log/all")
    public ResponseEntity<List<AttendanceLog>> getAllAttendanceLogs(
            @RequestParam(required = false) String year,
            @RequestParam(required = false) String month,
            @RequestParam(required = false) String quarter,
            @RequestParam(required = false) String dayOfMonth
    ) {
        logger.info("Getting attendance logs of all employees.");
        List<AttendanceLog> listAttendance = null;

        int yearInt = 0;
        int monthInt = 0;
        int quarterInt = 0;
        int dayOfMonthInt = 0;

        if (year != null) {
            yearInt = Integer.parseInt(year);
        }

        if (month != null) {
            monthInt = Integer.parseInt(month);
        }

        if (quarter != null) {
            quarterInt = Integer.parseInt(quarter);
        }

        if (dayOfMonth != null) {
            dayOfMonthInt = Integer.parseInt(dayOfMonth);
        }

        if(yearInt != 0 && quarterInt != 0) {
            listAttendance = attendanceManagerService.getAllAttendanceLogsByYearAndQuarter(yearInt, quarterInt);
        } else if (yearInt != 0 && monthInt != 0 && dayOfMonthInt != 0) {
            listAttendance = attendanceManagerService.getAllAttendanceLogsByYearAndMonthAndDayOfMonth(yearInt, monthInt, dayOfMonthInt);
        } else if (yearInt != 0 && monthInt != 0) {
            listAttendance = attendanceManagerService.getAllAttendanceLogsByYearAndMonth(yearInt, monthInt);
        } else if  (yearInt != 0) {
            listAttendance = attendanceManagerService.getAllAttendanceLogsByYear(yearInt);
        } else {
            listAttendance = attendanceManagerService.getAllAttendanceLogs();
        }

        return ResponseEntity.ok(listAttendance);
    }

    @GetMapping("/statistic/detail")
    public ResponseEntity<List<StatisticPerson>> getStatisticDetailAll(
            @RequestParam(required = true) String year,
            @RequestParam(required = false) String month
    ) {
        logger.info("Getting statistic detail of all employees.");
        List<StatisticPerson> listStatistic = null;

        int yearInt = 0;
        int monthInt = 0;

        if (year != null) {
            yearInt = Integer.parseInt(year);
        }

        if (month != null) {
            monthInt = Integer.parseInt(month);
        }

        if (yearInt != 0 && monthInt != 0) {
            listStatistic = attendanceManagerService.getStatisticPersonByMonth(yearInt, monthInt);
        } else if (yearInt != 0) {
            listStatistic = attendanceManagerService.getStatisticPersonByYear(yearInt);
        }

        return ResponseEntity.ok(listStatistic);
    }

}

package com.example.demo.Services;

import com.example.demo.Entites.AttendanceLog;
import com.example.demo.Entites.Statistic;
import com.example.demo.Exception.Model.NotFoundException;
import com.example.demo.Repository.AttendanceLogRepository;
import com.example.demo.Repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AttendanceService {
    private final AttendanceLogRepository attendanceLogRepository;
    private final UserRepository userRepository;

    private void checkExistByUserId(String id) {
        boolean exists = userRepository.existsById(id);
        if (!exists) {
            throw new NotFoundException("User with id " + id + " does not exist");
        }
    }

    public List<AttendanceLog> getAttendanceLogsByUserId(String id) {
        checkExistByUserId(id);
        return attendanceLogRepository.findAllByUserId(id);
    }

    public List<AttendanceLog> getAttendanceLogsByUserIdAndYear(String id, int year) {
        checkExistByUserId(id);
        return attendanceLogRepository.findAllByUserIdAndYear(id, year);
    }

    public List<AttendanceLog> getAttendanceLogsByUserIdAndYearAndMonth(String id, int year, int month) {
        checkExistByUserId(id);
        return attendanceLogRepository.findAllByUserIdAndYearAndMonth(id, year, month);
    }

    public List<AttendanceLog> getAttendanceLogsByUserIdAndYearAndQuarter(String id, int year, int quarter) {
        checkExistByUserId(id);
        return attendanceLogRepository.findAllByUserIdAndYearAndQuarter(id, year, quarter);
    }

    public Statistic getStatisticByUserIdAndYearAndMonth(String id, int year, int month) {
        checkExistByUserId(id);
        var logs = attendanceLogRepository.findAllByUserIdAndYearAndMonth(id, year, month);
        var statistic = new Statistic();
        int totalShifts = 0;
        int totalShiftsOnTime = 0;
        int totalShiftsLate = 0;
        int totalShiftsAbnormal = 0;
        float minLateTime = 0;

        for (AttendanceLog log : logs) {
            totalShifts++;
            if(log.isAbnormal()) {
                totalShiftsAbnormal++;
                continue;
            }
            if (log.isLate()) {
                totalShiftsLate++;
                minLateTime += log.getMinutesLate();
            } else {
                totalShiftsOnTime++;
            }
        }

        statistic.setNumberOfShifts(totalShifts);
        statistic.setNumberOfShifts(totalShiftsOnTime);
        statistic.setNumberOfLateShifts(totalShiftsLate);
        statistic.setNumberOfAbnormalShifts(totalShiftsAbnormal);
        statistic.setNumberMinutesLate(minLateTime);

        return statistic;
    }

    public Statistic getStatisticByUserIdAndYearAndQuarter(String id, int year, int quarter) {
        checkExistByUserId(id);
        var logs = attendanceLogRepository.findAllByUserIdAndYearAndQuarter(id, year, quarter);
        var statistic = new Statistic();
        int totalShifts = 0;
        int totalShiftsOnTime = 0;
        int totalShiftsLate = 0;
        int totalShiftsAbnormal = 0;
        float minLateTime = 0;

        for (AttendanceLog log : logs) {
            totalShifts++;
            if(log.isAbnormal()) {
                totalShiftsAbnormal++;
                continue;
            }
            if (log.isLate()) {
                totalShiftsLate++;
                minLateTime += log.getMinutesLate();
            } else {
                totalShiftsOnTime++;
            }
        }

        statistic.setNumberOfShifts(totalShifts);
        statistic.setNumberOfShifts(totalShiftsOnTime);
        statistic.setNumberOfLateShifts(totalShiftsLate);
        statistic.setNumberOfAbnormalShifts(totalShiftsAbnormal);
        statistic.setNumberMinutesLate(minLateTime);

        return statistic;
    }

    public Statistic getStatisticByUserIdAndYear(String id, int year) {
        checkExistByUserId(id);
        var logs = attendanceLogRepository.findAllByUserIdAndYear(id, year);
        var statistic = new Statistic();
        int totalShifts = 0;
        int totalShiftsOnTime = 0;
        int totalShiftsLate = 0;
        int totalShiftsAbnormal = 0;
        float minLateTime = 0;

        for (AttendanceLog log : logs) {
            totalShifts++;
            if(log.isAbnormal()) {
                totalShiftsAbnormal++;
                continue;
            }
            if (log.isLate()) {
                totalShiftsLate++;
                minLateTime += log.getMinutesLate();
            } else {
                totalShiftsOnTime++;
            }
        }

        statistic.setNumberOfShifts(totalShifts);
        statistic.setNumberOfShifts(totalShiftsOnTime);
        statistic.setNumberOfLateShifts(totalShiftsLate);
        statistic.setNumberOfAbnormalShifts(totalShiftsAbnormal);
        statistic.setNumberMinutesLate(minLateTime);

        return statistic;
    }
}

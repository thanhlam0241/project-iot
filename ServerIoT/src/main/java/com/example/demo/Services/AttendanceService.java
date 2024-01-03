package com.example.demo.Services;

import com.example.demo.DTO.AttendanceLog.AttendanceLogDto;
import com.example.demo.Entites.AttendanceLog;
import com.example.demo.Entites.Statistic;
import com.example.demo.Exception.Model.NotFoundException;
import com.example.demo.Repository.AttendanceLogRepository;
import com.example.demo.Repository.UserRepository;
import com.example.demo.Utils.DateUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.zip.DataFormatException;

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

    private AttendanceLogDto MapToDto(AttendanceLog attendanceLog) {
        var attendanceLogDto = new AttendanceLogDto();
        attendanceLogDto.setTime(attendanceLog.getTime());
        attendanceLogDto.setLate(attendanceLog.isLate());
        attendanceLogDto.setOnTime(attendanceLog.isOnTime());
        attendanceLogDto.setAbnormal(attendanceLog.isAbnormal());
        attendanceLogDto.setMinutesLate(attendanceLog.getMinutesLate());
        attendanceLogDto.setShift(attendanceLog.getShift().toString());
        attendanceLogDto.setName(attendanceLog.getUser().getFullName());
        attendanceLogDto.setManagementUnitName(attendanceLog.getUser().getManagementUnit().getName());
        attendanceLogDto.setAttendanceMachineName(attendanceLog.getAttendanceMachine().getName());
        return attendanceLogDto;
    }

    public List<AttendanceLogDto> MapToListDto(List<AttendanceLog> listAttendance) {
        return listAttendance.stream().map((attendanceLog) -> {
            return MapToDto(attendanceLog);
        }).toList();
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

    public List<AttendanceLog> getAttendanceLogsByUserIdDatesBetween(String id, int yearStart, int yearEnd,
         int monthStart, int monthEnd,int dayOfMonthStart, int dayOfMonthEnd) throws DataFormatException {
        checkExistByUserId(id);

        String iosDateStart = DateUtil.formatISODate(yearStart,monthStart,dayOfMonthStart);
        String iosDateEnd = DateUtil.formatISODate(yearEnd,monthEnd,dayOfMonthEnd);

        return getAttendanceLogsByUserIdDatesBetween(id, iosDateStart, iosDateEnd);
    }

    public List<AttendanceLog> getAttendanceLogsByUserIdDatesBetween(String id, String iosDateStart, String iosDateEnd) {
        checkExistByUserId(id);
        LocalDateTime startDateTime = DateUtil.stringToDate(iosDateStart).atStartOfDay();
        LocalDateTime endDateTime = DateUtil.stringToDate(iosDateEnd).atTime(23,59,59);
        return attendanceLogRepository.findAllByUserIdAndTimeBetween(id, startDateTime, endDateTime);
    }

    public Statistic getStatisticByUserIdBetweenTwoDates(String id, String iosDateStart, String iosDateEnd) {
        checkExistByUserId(id);
        LocalDateTime startDateTime = DateUtil.stringToDate(iosDateStart).atStartOfDay();
        LocalDateTime endDateTime = DateUtil.stringToDate(iosDateEnd).atTime(23,59,59);
        var logs = attendanceLogRepository.
                findAllByUserIdAndTimeBetween(id,
                        startDateTime,
                        endDateTime);
        var statistic = new Statistic();
        int totalShifts = 0;
        int totalShiftsOnTime = 0;
        int totalShiftsLate = 0;
        int totalShiftsAbnormal = 0;
        float minLateTime = 0;

        for (AttendanceLog log : logs) {
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
            totalShifts++;
        }

        statistic.setNumberOfShifts(totalShifts);
        statistic.setNumberOfOnTimeShifts(totalShiftsOnTime);
        statistic.setNumberOfLateShifts(totalShiftsLate);
        statistic.setNumberOfAbnormalShifts(totalShiftsAbnormal);
        statistic.setNumberMinutesLate(minLateTime);

        return statistic;
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
            totalShifts++;
        }

        statistic.setNumberOfShifts(totalShifts);
        statistic.setNumberOfOnTimeShifts(totalShiftsOnTime);
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
            totalShifts++;
        }

        statistic.setNumberOfShifts(totalShifts);
        statistic.setNumberOfOnTimeShifts(totalShiftsOnTime);
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
            totalShifts++;
        }

        statistic.setNumberOfShifts(totalShifts);
        statistic.setNumberOfOnTimeShifts(totalShiftsOnTime);
        statistic.setNumberOfLateShifts(totalShiftsLate);
        statistic.setNumberOfAbnormalShifts(totalShiftsAbnormal);
        statistic.setNumberMinutesLate(minLateTime);

        return statistic;
    }
}

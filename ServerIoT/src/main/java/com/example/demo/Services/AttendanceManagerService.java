package com.example.demo.Services;

import com.example.demo.DTO.Statistic.StatisticPerson;
import com.example.demo.Entites.AttendanceLog;
import com.example.demo.Entites.Statistic;
import com.example.demo.Entites.User;
import com.example.demo.Enums.Shift;
import com.example.demo.Exception.Model.NotFoundException;
import com.example.demo.Repository.AttendanceLogRepository;
import com.example.demo.Repository.ManagementUnitRepository;
import com.example.demo.Repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AttendanceManagerService {
    private final AttendanceLogRepository attendanceLogRepository;
    private final ManagementUnitRepository managementUnitRepository;
    private final UserRepository userRepository;

    private void checkExistByUserId(String id) {
        boolean exists = userRepository.existsById(id);
        if (!exists) {
            throw new NotFoundException("User with id " + id + " does not exist");
        }
    }

    private void checkExistByManagementUnitId(String id) {
        boolean exists = managementUnitRepository.existsById(id);
        if (!exists) {
            throw new NotFoundException("Management unit with id " + id + " does not exist");
        }
    }

    public List<AttendanceLog> getAllAttendanceLogsByManagementUnitId(String id) {
        checkExistByManagementUnitId(id);
        return attendanceLogRepository.findAllByManagementUnitId(id);
    }

    // Method for manager to get statistic, list logs by management unit id, year, quarter and month
    public Statistic getStatisticByManagementUnitIdInYear(String id, int year) {
        checkExistByManagementUnitId(id);
        List<AttendanceLog> attendanceLogs = attendanceLogRepository.findAllByManagementUnitIdAndYear(id, year);
        Statistic statistic = new Statistic();
        int totalShift = 0;
        int totalShiftOnTime = 0;
        int totalLate = 0;
        int totalAbnormal = 0;
        int totalMinutesLate = 0;

        for (AttendanceLog attendanceLog : attendanceLogs) {
            totalShift++;
            if(attendanceLog.isAbnormal()){
                totalAbnormal++;
                continue;
            }
            if (attendanceLog.isLate()) {
                totalLate++;
                totalMinutesLate += attendanceLog.getMinutesLate();
            }
            else {
                totalShiftOnTime++;
            }
        }

        statistic.setNumberOfShifts(totalShift);
        statistic.setNumberOfOnTimeShifts(totalShiftOnTime);
        statistic.setNumberOfLateShifts(totalLate);
        statistic.setNumberOfAbnormalShifts(totalAbnormal);
        statistic.setNumberMinutesLate(totalMinutesLate);

        return statistic;
    }

    public Statistic getStatisticByManagementUnitIdInMonth(String id, int year, int month) {
        checkExistByManagementUnitId(id);
        List<AttendanceLog> attendanceLogs = attendanceLogRepository.findAllByManagementUnitIdAndYearAndMonth(id, year, month);
        Statistic statistic = new Statistic();
        int totalShift = 0;
        int totalShiftOnTime = 0;
        int totalLate = 0;
        int totalAbnormal = 0;
        int totalMinutesLate = 0;

        for (AttendanceLog attendanceLog : attendanceLogs) {
            totalShift++;
            if(attendanceLog.isAbnormal()){
                totalAbnormal++;
                continue;
            }
            if (attendanceLog.isLate()) {
                totalLate++;
                totalMinutesLate += attendanceLog.getMinutesLate();
            }
            else {
                totalShiftOnTime++;
            }
        }

        statistic.setNumberOfShifts(totalShift);
        statistic.setNumberOfOnTimeShifts(totalShiftOnTime);
        statistic.setNumberOfLateShifts(totalLate);
        statistic.setNumberOfAbnormalShifts(totalAbnormal);
        statistic.setNumberMinutesLate(totalMinutesLate);

        return statistic;
    }

    public Statistic getStatisticByManagementUnitIdInQuarter(String id, int year, int quarter) {
        List<AttendanceLog> attendanceLogs = attendanceLogRepository.findAllByManagementUnitIdAndYearAndQuarter(id, year, quarter);
        Statistic statistic = new Statistic();
        int totalShift = 0;
        int totalShiftOnTime = 0;
        int totalLate = 0;
        int totalAbnormal = 0;
        int totalMinutesLate = 0;

        for (AttendanceLog attendanceLog : attendanceLogs) {
            totalShift++;
            if(attendanceLog.isAbnormal()){
                totalAbnormal++;
                continue;
            }
            if (attendanceLog.isLate()) {
                totalLate++;
                totalMinutesLate += attendanceLog.getMinutesLate();
            }
            else {
                totalShiftOnTime++;
            }
        }

        statistic.setNumberOfShifts(totalShift);
        statistic.setNumberOfOnTimeShifts(totalShiftOnTime);
        statistic.setNumberOfLateShifts(totalLate);
        statistic.setNumberOfAbnormalShifts(totalAbnormal);
        statistic.setNumberMinutesLate(totalMinutesLate);

        return statistic;
    }

    public Statistic getStatisticByManagementUnitIdInDay(String id, int year, int month, int dayOfMonth) {
        List<AttendanceLog> attendanceLogs = attendanceLogRepository.findAllByManagementUnitIdAndYearAndMonthAndDayOfMonth(id, year, month, dayOfMonth);
        Statistic statistic = new Statistic();
        int totalShift = 0;
        int totalShiftOnTime = 0;
        int totalLate = 0;
        int totalAbnormal = 0;
        int totalMinutesLate = 0;

        for (AttendanceLog attendanceLog : attendanceLogs) {
            totalShift++;
            if(attendanceLog.isAbnormal()){
                totalAbnormal++;
                continue;
            }
            if (attendanceLog.isLate()) {
                totalLate++;
                totalMinutesLate += attendanceLog.getMinutesLate();
            }
            else {
                totalShiftOnTime++;
            }
        }

        statistic.setNumberOfShifts(totalShift);
        statistic.setNumberOfOnTimeShifts(totalShiftOnTime);
        statistic.setNumberOfLateShifts(totalLate);
        statistic.setNumberOfAbnormalShifts(totalAbnormal);
        statistic.setNumberMinutesLate(totalMinutesLate);

        return statistic;
    }

    public List<AttendanceLog> getAllAttendanceLogsByManagementUnitIdAndYear(String id, int year) {
        return attendanceLogRepository.findAllByManagementUnitIdAndYear(id, year);
    }

    public List<AttendanceLog> getAllAttendanceLogsByManagementUnitIdAndYearAndMonth(String id, int year, int month) {
        return attendanceLogRepository.findAllByManagementUnitIdAndYearAndMonth(id, year, month);
    }

    public List<AttendanceLog> getAllAttendanceLogsByManagementUnitIdAndYearAndQuarter(String id, int year, int quarter) {
        return attendanceLogRepository.findAllByManagementUnitIdAndYearAndQuarter(id, year, quarter);
    }

    public List<AttendanceLog> getAllAttendanceLogsByManagementUnitIdAndYearAndMonthAndDayOfMonth(String id, int year, int month, int dayOfMonth) {
        return attendanceLogRepository.findAllByManagementUnitIdAndYearAndMonthAndDayOfMonth(id, year, month, dayOfMonth);
    }

    // Method for employee/manager/admin to get statistic, list logs by user id, year, quarter and month
    public List<AttendanceLog> getAllAttendanceLogsByUserId(String id) {
        return attendanceLogRepository.findAllByUserId(id);
    }

    public List<AttendanceLog> getAllAttendanceLogsByUserIdAndYear(String id, int year) {
        return attendanceLogRepository.findAllByUserIdAndYear(id, year);
    }

    public List<AttendanceLog> getAllAttendanceLogsByUserIdAndYearAndMonth(String id, int year, int month) {
        return attendanceLogRepository.findAllByUserIdAndYearAndMonth(id, year, month);
    }

    public List<AttendanceLog> getAllAttendanceLogsByUserIdAndYearAndQuarter(String id, int year, int quarter) {
        return attendanceLogRepository.findAllByUserIdAndYearAndQuarter(id, year, quarter);
    }

    public Statistic getStatisticByUserIdInYear(String id, int year) {
        List<AttendanceLog> attendanceLogs = attendanceLogRepository.findAllByUserIdAndYear(id, year);
        Statistic statistic = new Statistic();
        int totalShift = 0;
        int totalShiftOnTime = 0;
        int totalLate = 0;
        int totalAbnormal = 0;
        int totalMinutesLate = 0;

        for (AttendanceLog attendanceLog : attendanceLogs) {
            totalShift++;
            if(attendanceLog.isAbnormal()){
                totalAbnormal++;
                continue;
            }
            if (attendanceLog.isLate()) {
                totalLate++;
                totalMinutesLate += attendanceLog.getMinutesLate();
            }
            else {
                totalShiftOnTime++;
            }
        }

        statistic.setNumberOfShifts(totalShift);
        statistic.setNumberOfOnTimeShifts(totalShiftOnTime);
        statistic.setNumberOfLateShifts(totalLate);
        statistic.setNumberOfAbnormalShifts(totalAbnormal);
        statistic.setNumberMinutesLate(totalMinutesLate);

        return statistic;
    }

    public Statistic getStatisticByUserIdInMonth(String id, int year, int month) {
        List<AttendanceLog> attendanceLogs = attendanceLogRepository.findAllByUserIdAndYearAndMonth(id, year, month);
        Statistic statistic = new Statistic();
        int totalShift = 0;
        int totalShiftOnTime = 0;
        int totalLate = 0;
        int totalAbnormal = 0;
        int totalMinutesLate = 0;

        for (AttendanceLog attendanceLog : attendanceLogs) {
            totalShift++;
            if(attendanceLog.isAbnormal()){
                totalAbnormal++;
                continue;
            }
            if (attendanceLog.isLate()) {
                totalLate++;
                totalMinutesLate += attendanceLog.getMinutesLate();
            }
            else {
                totalShiftOnTime++;
            }
        }

        statistic.setNumberOfShifts(totalShift);
        statistic.setNumberOfOnTimeShifts(totalShiftOnTime);
        statistic.setNumberOfLateShifts(totalLate);
        statistic.setNumberOfAbnormalShifts(totalAbnormal);
        statistic.setNumberMinutesLate(totalMinutesLate);

        return statistic;
    }

    public Statistic getStatisticByUserIdInQuarter(String id, int year, int quarter) {
        List<AttendanceLog> attendanceLogs = attendanceLogRepository.findAllByUserIdAndYearAndQuarter(id, year, quarter);
        Statistic statistic = new Statistic();
        int totalShift = 0;
        int totalShiftOnTime = 0;
        int totalLate = 0;
        int totalAbnormal = 0;
        int totalMinutesLate = 0;

        for (AttendanceLog attendanceLog : attendanceLogs) {
            totalShift++;
            if(attendanceLog.isAbnormal()){
                totalAbnormal++;
                continue;
            }
            if (attendanceLog.isLate()) {
                totalLate++;
                totalMinutesLate += attendanceLog.getMinutesLate();
            }
            else {
                totalShiftOnTime++;
            }
        }

        statistic.setNumberOfShifts(totalShift);
        statistic.setNumberOfOnTimeShifts(totalShiftOnTime);
        statistic.setNumberOfLateShifts(totalLate);
        statistic.setNumberOfAbnormalShifts(totalAbnormal);
        statistic.setNumberMinutesLate(totalMinutesLate);

        return statistic;
    }

    // Method for admin to get statistic, list logs by year, quarter and month
    public List<AttendanceLog> getAllAttendanceLogsByYear(int year) {
        return attendanceLogRepository.findAllByYear(year);
    }

    public List<AttendanceLog> getAllAttendanceLogsByYearAndMonth(int year, int month) {
        return attendanceLogRepository.findAllByYearAndMonth(year, month);
    }

    public List<AttendanceLog> getAllAttendanceLogsByYearAndQuarter(int year, int quarter) {
        return attendanceLogRepository.findAllByYearAndQuarter(year, quarter);
    }

    public List<AttendanceLog> getAllAttendanceLogsByYearAndMonthAndDayOfMonth(int year, int month, int dayOfMonth) {
        return attendanceLogRepository.findAllByYearAndMonthAndDayOfMonth(year, month, dayOfMonth);
    }

    public List<AttendanceLog> getAllAttendanceLogs() {
        return attendanceLogRepository.findAll();
    }

    public Statistic getStatisticInYear(int year) {
        List<AttendanceLog> attendanceLogs = attendanceLogRepository.findAllByYear(year);
        Statistic statistic = new Statistic();
        int totalShift = 0;
        int totalShiftOnTime = 0;
        int totalLate = 0;
        int totalAbnormal = 0;
        int totalMinutesLate = 0;

        for (AttendanceLog attendanceLog : attendanceLogs) {
            totalShift++;
            if(attendanceLog.isAbnormal()){
                totalAbnormal++;
                continue;
            }
            if (attendanceLog.isLate()) {
                totalLate++;
                totalMinutesLate += attendanceLog.getMinutesLate();
            }
            else {
                totalShiftOnTime++;
            }
        }

        statistic.setNumberOfShifts(totalShift);
        statistic.setNumberOfOnTimeShifts(totalShiftOnTime);
        statistic.setNumberOfLateShifts(totalLate);
        statistic.setNumberOfAbnormalShifts(totalAbnormal);
        statistic.setNumberMinutesLate(totalMinutesLate);

        return statistic;
    }

    public Statistic getStatisticInMonth(int year, int month) {
        List<AttendanceLog> attendanceLogs = attendanceLogRepository.findAllByYearAndMonth(year, month);
        Statistic statistic = new Statistic();
        int totalShift = 0;
        int totalShiftOnTime = 0;
        int totalLate = 0;
        int totalAbnormal = 0;
        int totalMinutesLate = 0;

        for (AttendanceLog attendanceLog : attendanceLogs) {
            totalShift++;
            if(attendanceLog.isAbnormal()){
                totalAbnormal++;
                continue;
            }
            if (attendanceLog.isLate()) {
                totalLate++;
                totalMinutesLate += attendanceLog.getMinutesLate();
            }
            else {
                totalShiftOnTime++;
            }
        }

        statistic.setNumberOfShifts(totalShift);
        statistic.setNumberOfOnTimeShifts(totalShiftOnTime);
        statistic.setNumberOfLateShifts(totalLate);
        statistic.setNumberOfAbnormalShifts(totalAbnormal);
        statistic.setNumberMinutesLate(totalMinutesLate);

        return statistic;
    }

    public Statistic getStatisticInQuarter(int year, int quarter) {
        List<AttendanceLog> attendanceLogs = attendanceLogRepository.findAllByYearAndQuarter(year, quarter);
        Statistic statistic = new Statistic();
        int totalShift = 0;
        int totalShiftOnTime = 0;
        int totalLate = 0;
        int totalAbnormal = 0;
        int totalMinutesLate = 0;

        for (AttendanceLog attendanceLog : attendanceLogs) {
            totalShift++;
            if(attendanceLog.isAbnormal()){
                totalAbnormal++;
                continue;
            }
            if (attendanceLog.isLate()) {
                totalLate++;
                totalMinutesLate += attendanceLog.getMinutesLate();
            }
            else {
                totalShiftOnTime++;
            }
        }

        statistic.setNumberOfShifts(totalShift);
        statistic.setNumberOfOnTimeShifts(totalShiftOnTime);
        statistic.setNumberOfLateShifts(totalLate);
        statistic.setNumberOfAbnormalShifts(totalAbnormal);
        statistic.setNumberMinutesLate(totalMinutesLate);

        return statistic;
    }

    public Statistic getStatisticInDay(int year, int month, int dayOfMonth) {
        List<AttendanceLog> attendanceLogs = attendanceLogRepository.findAllByYearAndMonthAndDayOfMonth(year, month, dayOfMonth);
        Statistic statistic = new Statistic();
        int totalShift = 0;
        int totalShiftOnTime = 0;
        int totalLate = 0;
        int totalAbnormal = 0;
        int totalMinutesLate = 0;

        for (AttendanceLog attendanceLog : attendanceLogs) {
            totalShift++;
            if(attendanceLog.isAbnormal()){
                totalAbnormal++;
                continue;
            }
            if (attendanceLog.isLate()) {
                totalLate++;
                totalMinutesLate += attendanceLog.getMinutesLate();
            }
            else {
                totalShiftOnTime++;
            }
        }

        statistic.setNumberOfShifts(totalShift);
        statistic.setNumberOfOnTimeShifts(totalShiftOnTime);
        statistic.setNumberOfLateShifts(totalLate);
        statistic.setNumberOfAbnormalShifts(totalAbnormal);
        statistic.setNumberMinutesLate(totalMinutesLate);

        return statistic;
    }

    public Statistic getStatisticInAllTime(){
        List<AttendanceLog> attendanceLogs = attendanceLogRepository.findAll();
        Statistic statistic = new Statistic();
        int totalShift = 0;
        int totalShiftOnTime = 0;
        int totalAbnormal = 0;
        int totalLate = 0;
        int totalMinutesLate = 0;

        for (AttendanceLog attendanceLog : attendanceLogs) {
            totalShift++;
            if(attendanceLog.isAbnormal()){
                totalAbnormal++;
                continue;
            }
            if (attendanceLog.isLate()) {
                totalLate++;
                totalMinutesLate += attendanceLog.getMinutesLate();
            }
            else {
                totalShiftOnTime++;
            }
        }

        statistic.setNumberOfShifts(totalShift);
        statistic.setNumberOfOnTimeShifts(totalShiftOnTime);
        statistic.setNumberOfLateShifts(totalLate);
        statistic.setNumberOfAbnormalShifts(totalAbnormal);
        statistic.setNumberMinutesLate(totalMinutesLate);

        return statistic;
    }
    public List<StatisticPerson> getStatisticPersonByYear(int year) {
        List<AttendanceLog> attendanceLogs = attendanceLogRepository.findAllByYear(year);
        Map<String, StatisticPerson> statisticPersonMap = new HashMap<>();

        attendanceLogs.forEach(attendanceLog -> {
            User user = attendanceLog.getUser();
            String userCode = user.getCode();
            if (statisticPersonMap.containsKey(userCode)) {
                StatisticPerson statisticPerson = statisticPersonMap.get(userCode);
                Statistic statistic = statisticPerson.getStatistic();
                statistic.setNumberOfShifts(statistic.getNumberOfShifts() + 1);
                if (attendanceLog.isAbnormal()) {
                    statistic.setNumberOfAbnormalShifts(statistic.getNumberOfAbnormalShifts() + 1);
                }
                else if (attendanceLog.isLate()) {
                    statistic.setNumberOfLateShifts(statistic.getNumberOfLateShifts() + 1);
                    statistic.setNumberMinutesLate(statistic.getNumberMinutesLate() + attendanceLog.getMinutesLate());
                }
                else {
                    statistic.setNumberOfOnTimeShifts(statistic.getNumberOfOnTimeShifts() + 1);
                }
                if(attendanceLog.getShift() == Shift.MORNING){
                    statisticPerson.setNumberOfMorning(statisticPerson.getNumberOfMorning() + 1);
                }
                else {
                    statisticPerson.setNumberOfAfternoon(statisticPerson.getNumberOfAfternoon() + 1);
                }
            }
            else {
                StatisticPerson statisticPerson = new StatisticPerson();
                Statistic statistic = new Statistic();
                statistic.setNumberOfShifts(1);
                if (attendanceLog.isAbnormal()) {
                    statistic.setNumberOfAbnormalShifts(1);
                }
                else if (attendanceLog.isLate()) {
                    statistic.setNumberOfLateShifts(1);
                    statistic.setNumberMinutesLate(attendanceLog.getMinutesLate());
                }
                else {
                    statistic.setNumberOfOnTimeShifts(1);
                }
                if(attendanceLog.getShift()== Shift.MORNING){
                    statisticPerson.setNumberOfMorning(statisticPerson.getNumberOfMorning() + 1);
                }
                else {
                    statisticPerson.setNumberOfAfternoon(statisticPerson.getNumberOfAfternoon() + 1);
                }
                statisticPerson.setName(user.getFullName());
                statisticPerson.setCode(user.getCode());
                statisticPerson.setManagementUnitName(user.getManagementUnit().getName());
                statisticPerson.setStatistic(statistic);
                statisticPersonMap.put(userCode, statisticPerson);
            }
        });
        return new ArrayList<>(statisticPersonMap.values());
    }
    public List<StatisticPerson> getStatisticPersonByMonth(int year, int month) {
        List<AttendanceLog> attendanceLogs = attendanceLogRepository.findAllByYearAndMonth(year, month);
        Map<String, StatisticPerson> statisticPersonMap = new HashMap<>();

        attendanceLogs.forEach(attendanceLog -> {
            User user = attendanceLog.getUser();
            String userCode = user.getCode();
            if (statisticPersonMap.containsKey(userCode)) {
                StatisticPerson statisticPerson = statisticPersonMap.get(userCode);
                Statistic statistic = statisticPerson.getStatistic();
                statistic.setNumberOfShifts(statistic.getNumberOfShifts() + 1);
                if (attendanceLog.isAbnormal()) {
                    statistic.setNumberOfAbnormalShifts(statistic.getNumberOfAbnormalShifts() + 1);
                }
                else if (attendanceLog.isLate()) {
                    statistic.setNumberOfLateShifts(statistic.getNumberOfLateShifts() + 1);
                    statistic.setNumberMinutesLate(statistic.getNumberMinutesLate() + attendanceLog.getMinutesLate());
                }
                else {
                    statistic.setNumberOfOnTimeShifts(statistic.getNumberOfOnTimeShifts() + 1);
                }
                if(attendanceLog.getShift() == Shift.MORNING){
                    statisticPerson.setNumberOfMorning(statisticPerson.getNumberOfMorning() + 1);
                }
                else {
                    statisticPerson.setNumberOfAfternoon(statisticPerson.getNumberOfAfternoon() + 1);
                }
            }
            else {
                StatisticPerson statisticPerson = new StatisticPerson();
                Statistic statistic = new Statistic();
                statistic.setNumberOfShifts(1);
                if (attendanceLog.isAbnormal()) {
                    statistic.setNumberOfAbnormalShifts(1);
                }
                else if (attendanceLog.isLate()) {
                    statistic.setNumberOfLateShifts(1);
                    statistic.setNumberMinutesLate(attendanceLog.getMinutesLate());
                }
                else {
                    statistic.setNumberOfOnTimeShifts(1);
                }
                if(attendanceLog.getShift() == Shift.MORNING){
                    statisticPerson.setNumberOfMorning(statisticPerson.getNumberOfMorning() + 1);
                }
                else {
                    statisticPerson.setNumberOfAfternoon(statisticPerson.getNumberOfAfternoon() + 1);
                }
                statisticPerson.setName(user.getFullName());
                statisticPerson.setCode(user.getCode());
                statisticPerson.setManagementUnitName(user.getManagementUnit().getName());
                statisticPerson.setStatistic(statistic);
                statisticPersonMap.put(userCode, statisticPerson);
            }
        });
        return new ArrayList<>(statisticPersonMap.values());
    }

    // Method to CRUD attendance log
    public AttendanceLog getAttendanceLogById(String id) {
        return attendanceLogRepository.findById(id).orElse(null);
    }

    public AttendanceLog createAttendanceLog(AttendanceLog attendanceLog) {
        return attendanceLogRepository.save(attendanceLog);
    }

    public AttendanceLog updateAttendanceLog(AttendanceLog attendanceLog) {
        return attendanceLogRepository.save(attendanceLog);
    }

    public void deleteAttendanceLogById(String id) {
        attendanceLogRepository.deleteById(id);
    }

}

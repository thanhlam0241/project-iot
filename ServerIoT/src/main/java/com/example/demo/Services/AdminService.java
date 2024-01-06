package com.example.demo.Services;

import com.example.demo.Enums.Role;
import com.example.demo.Models.Response.StatisticAttendance;
import com.example.demo.Models.Response.StatisticHuman;
import com.example.demo.Models.Response.StatisticInMonth;
import com.example.demo.Repository.AttendanceLogRepository;
import com.example.demo.Repository.AttendanceMachineRepository;
import com.example.demo.Repository.ManagementUnitRepository;
import com.example.demo.Repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminService {
    private final UserRepository userRepository;
    private final ManagementUnitRepository managementUnitRepository;
    private final AttendanceMachineRepository attendanceMachineRepository;

    private final AttendanceLogRepository attendanceLogRepository;

    public StatisticHuman getStatisticHuman() {
        int numberOfAccount = (int) userRepository.count();
        int numberOfManagementUnit = (int) managementUnitRepository.count();
        int numberOfAttendanceMachine = (int) attendanceMachineRepository.count();
        int numberOfAdmin = userRepository.countByRole(Role.ADMIN.toString());
        int numberOfManager = userRepository.countByRole(Role.MANAGER.toString());
        int numberOfEmployee = userRepository.countByRole(Role.EMPLOYEE.toString());

        StatisticHuman statistic = new StatisticHuman();
        statistic.setNumberOfAccount(numberOfAccount);
        statistic.setNumberOfDepartment(numberOfManagementUnit);
        statistic.setNumberOfMachine(numberOfAttendanceMachine);
        statistic.setNumberOfAdminAccount(numberOfAdmin);
        statistic.setNumberOfManagerAccount(numberOfManager);
        statistic.setNumberOfEmployeeAccount(numberOfEmployee);

        return statistic;
    }

    public StatisticAttendance getStatisticAttendance(int year) {
        List<StatisticInMonth> statisticInMonths = new ArrayList<>();

        for(int i = 1; i <=12 ; i++){
            StatisticInMonth statisticInMonth = new StatisticInMonth();
            statisticInMonth.setMonth(i);
            int numberLate = attendanceLogRepository.countByYearAndMonthAndLate(year, i);
            int numberOnTime = attendanceLogRepository.countByYearAndMonthAndOnTime(year, i);
            int numberShift = numberLate + numberOnTime;

            DecimalFormat df = new DecimalFormat();
            df.setMaximumFractionDigits(2);

            double percentOfLate = numberShift > 0 ? Double.parseDouble(df.format((float) numberLate / numberShift * 100)) : 0;

            statisticInMonth.setNumberOfAttendance(numberShift);
            statisticInMonth.setNumberOfLate(numberLate);
            statisticInMonth.setNumberOfOnTime(numberOnTime);
            statisticInMonth.setPercentOfLate(percentOfLate);

            statisticInMonths.add(statisticInMonth);
        }

        StatisticAttendance statisticAttendance = new StatisticAttendance(year, statisticInMonths);

        return statisticAttendance;
    }

}

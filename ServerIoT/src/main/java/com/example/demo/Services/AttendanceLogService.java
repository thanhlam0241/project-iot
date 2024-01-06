package com.example.demo.Services;

import com.example.demo.DTO.AttendanceLog.AttendanceLogCreateDto;
import com.example.demo.Entites.AttendanceLog;
import com.example.demo.Entites.AttendanceMachine;
import com.example.demo.Enums.Shift;
import com.example.demo.Enums.StatusLog;
import com.example.demo.Exception.Model.BadRequestException;
import com.example.demo.Exception.Model.NotFoundException;
import com.example.demo.Repository.AttendanceLogRepository;
import com.example.demo.Repository.AttendanceMachineRepository;
import com.example.demo.Repository.ManagementUnitRepository;
import com.example.demo.Repository.UserRepository;
import com.example.demo.Utils.ShiftUtil;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AttendanceLogService {
    private final AttendanceLogRepository attendanceLogRepository;
    private final UserRepository userRepository;
    private final AttendanceMachineRepository attendanceMachineRepository;
    private final ManagementUnitRepository managementUnitRepository;
    private final ModelMapper modelMapper;

    public List<AttendanceLog> findAllByUserId(String id) {
        if(!userRepository.existsById(id))
            throw new NotFoundException("User with id " + id + " does not exist");
        return attendanceLogRepository.findAllByUserId(id);
    }

    public AttendanceMachine findAttendanceMachineById(String id) {
        var attendanceMachine = attendanceMachineRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("AttendanceMachine with id " + id + " does not exist"));
        return attendanceMachine;
    }
    public boolean insertMachine(String managementUnitId, AttendanceMachine attendanceMachine) {
        var managementUnit = managementUnitRepository.findById(managementUnitId)
                .orElseThrow(() -> new NotFoundException("ManagementUnit with id " + managementUnitId + " does not exist"));
        attendanceMachine.setManagementUnit(managementUnit);
        attendanceMachineRepository.save(attendanceMachine);
        return true;
    }
    public boolean updateMachine(String id, AttendanceMachine attendanceMachine) {
        var attendanceMachine1 = attendanceMachineRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("AttendanceMachine with id " + id + " does not exist"));
        attendanceMachine1.setManagementUnit(attendanceMachine.getManagementUnit());
        attendanceMachineRepository.save(attendanceMachine1);
        return true;
    }
    public boolean updateMany(List<AttendanceLog> logs) {
        attendanceLogRepository.saveAll(logs);
        return true;
    }
    public void testUpdate(){
        List<AttendanceLog> list = attendanceLogRepository.findAll();
        for (AttendanceLog a : list){
            a.setManagementUnit(a.getAttendanceMachine().getManagementUnit());
        }

        attendanceLogRepository.saveAll(list);
    }
    public boolean deleteMachine(String id) {
        var attendanceMachine = attendanceMachineRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("AttendanceMachine with id " + id + " does not exist"));
        attendanceMachineRepository.delete(attendanceMachine);
        return true;
    }
    public AttendanceLog insertAttendanceLog(AttendanceLogCreateDto attendanceLogCreateDto) {
        var attendanceMachine = attendanceMachineRepository.findById(attendanceLogCreateDto.getAttendanceMachineId())
                .orElseThrow(() -> new IllegalArgumentException("AttendanceMachine with id " + attendanceLogCreateDto.getAttendanceMachineId() + " does not exist"));
        var user = userRepository.findById(attendanceLogCreateDto.getUserId())
                .orElseThrow(() -> new IllegalArgumentException("User with id " + attendanceLogCreateDto.getUserId() + " does not exist"));
        AttendanceLog attendanceLog = modelMapper.map(attendanceLogCreateDto, AttendanceLog.class);
        attendanceLog.setAttendanceMachine(attendanceMachine);
        attendanceLog.setManagementUnit(attendanceMachine.getManagementUnit());
        //attendanceLog.setUser(user);

        LocalDateTime logTime = LocalDateTime.now();
        int year = logTime.getYear();
        int month = logTime.getMonthValue();
        int quarter = (month - 1) / 3 + 1;
        int dayOfMonth = logTime.getDayOfMonth();
        int dayOfWeek = logTime.getDayOfWeek().getValue();
        int hour = logTime.getHour();
        int minute = logTime.getMinute();

        attendanceLog.setYear(year);
        attendanceLog.setMonth(month);
        attendanceLog.setQuarter(quarter);
        attendanceLog.setDayOfMonth(dayOfMonth);
        attendanceLog.setDayOfWeek(dayOfWeek);
        attendanceLog.setHour(hour);
        attendanceLog.setMinute(minute);
        attendanceLog.setManagementUnit(attendanceMachine.getManagementUnit());

        StatusLog statusLog = ShiftUtil.getStatusLog(hour, minute);
        if(statusLog == StatusLog.ON_TIME) {
            attendanceLog.setOnTime(true);
            attendanceLog.setLate(false);
            attendanceLog.setAbnormal(false);
        }
        else if(statusLog == StatusLog.LATE) {
            attendanceLog.setOnTime(false);
            attendanceLog.setLate(true);
            attendanceLog.setAbnormal(false);
            attendanceLog.setMinutesLate(minute);
        }
        else {
            attendanceLog.setOnTime(false);
            attendanceLog.setLate(false);
            attendanceLog.setAbnormal(true);
        }

        Shift shift = ShiftUtil.getShift(hour);
        attendanceLog.setShift(shift);

        var result = attendanceLogRepository.save(attendanceLog);
        return result;
    }
}

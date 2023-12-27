package com.example.demo.Services;

import com.example.demo.DTO.AttendanceMachine.AttendanceMachineCreateDto;
import com.example.demo.DTO.AttendanceMachine.AttendanceUpdateDto;
import com.example.demo.Entites.AttendanceMachine;
import com.example.demo.Exception.Model.NotFoundException;
import com.example.demo.Repository.AttendanceMachineRepository;
import com.example.demo.Repository.ManagementUnitRepository;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AttendanceMachineService {
    private final AttendanceMachineRepository attendanceMachineRepository;
    private final ManagementUnitRepository managementUnitRepository;

    private final ModelMapper modelMapper;

    public void insertAttendanceMachine(AttendanceMachineCreateDto attendanceMachineCreateDto) {
        var managementUnit = managementUnitRepository
                .findById(attendanceMachineCreateDto.getManagementUnitId()).orElseThrow(() -> new NotFoundException("Management Unit not found"));
        AttendanceMachine machine = modelMapper.map(attendanceMachineCreateDto, AttendanceMachine.class);
        machine.setManagementUnit(managementUnit);
        attendanceMachineRepository.save(machine);
    }

    public void deleteAttendanceMachine(String id) {
        attendanceMachineRepository.deleteById(id);
    }

    public void updateAttendanceMachine(String id, AttendanceUpdateDto attendanceMachineUpdateDto) {
        var attendanceMachine = attendanceMachineRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Attendance Machine not found"));
        attendanceMachine.setCode(attendanceMachineUpdateDto.getCode());
        attendanceMachine.setName(attendanceMachineUpdateDto.getName());
        if(!attendanceMachine.getManagementUnit().getId().equals(attendanceMachineUpdateDto.getManagementUnitId())) {
            var managementUnit = managementUnitRepository.findById(attendanceMachineUpdateDto.getManagementUnitId())
                    .orElseThrow(() -> new NotFoundException("Management Unit not found"));
            attendanceMachine.setManagementUnit(managementUnit);
        }
        attendanceMachineRepository.save(attendanceMachine);
    }

    public AttendanceMachine getAttendanceMachineById(String id) {
        return attendanceMachineRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Attendance Machine not found"));
    }

    public List<AttendanceMachine> getAllAttendanceMachines() {
        return attendanceMachineRepository.findAll();
    }
}

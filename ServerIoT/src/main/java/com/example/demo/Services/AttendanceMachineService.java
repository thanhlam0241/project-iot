package com.example.demo.Services;

import com.example.demo.DTO.AttendanceMachine.AttendanceMachineCreateDto;
import com.example.demo.DTO.AttendanceMachine.AttendanceMachineDto;
import com.example.demo.DTO.AttendanceMachine.AttendanceMachineInsertOrReplaceDto;
import com.example.demo.DTO.AttendanceMachine.AttendanceMachineUpdateDto;
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

    public void updateAttendanceMachine(String id, AttendanceMachineUpdateDto attendanceMachineUpdateDto) {
        var attendanceMachine = attendanceMachineRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Attendance Machine not found"));
        attendanceMachine.setCode(attendanceMachineUpdateDto.getCode());
        attendanceMachine.setName(attendanceMachineUpdateDto.getName());
        if(attendanceMachine.getManagementUnit() == null
                && attendanceMachineUpdateDto.getManagementUnitId() != null
                && !attendanceMachineUpdateDto.getManagementUnitId().isEmpty()
                ||
                attendanceMachine.getManagementUnit() != null &&
                !attendanceMachine.getManagementUnit().getId().equals(attendanceMachineUpdateDto.getManagementUnitId())) {
            var managementUnitOptional = managementUnitRepository.findById(attendanceMachineUpdateDto.getManagementUnitId());
            if(managementUnitOptional.isEmpty()) {
                attendanceMachine.setManagementUnit(null);
            }
            else {
                attendanceMachine.setManagementUnit(managementUnitOptional.get());
            }
        }
        attendanceMachineRepository.save(attendanceMachine);
    }

    public AttendanceMachineDto getAttendanceMachineById(String id) {
        var machine = attendanceMachineRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Attendance Machine not found"));
        var dto = modelMapper.map(machine, AttendanceMachineDto.class);
        var managementUnit = machine.getManagementUnit();
        if (managementUnit != null) {
            dto.setManagementUnitName(managementUnit.getName());
            dto.setManagementUnitId(managementUnit.getId());
        }
        return dto;
    }

    public List<AttendanceMachineDto> getAllAttendanceMachines(String managementUnitId) {
        if(managementUnitId == null || managementUnitId.isEmpty()) {
            return attendanceMachineRepository.findAll().stream().map(attendanceMachine -> {
                var dto = modelMapper.map(attendanceMachine, AttendanceMachineDto.class);
                var managementUnit = attendanceMachine.getManagementUnit();
                if (managementUnit != null) {
                    dto.setManagementUnitName(managementUnit.getName());
                    dto.setManagementUnitId(managementUnit.getId());
                }
                return dto;
            }).toList();
        }
        return attendanceMachineRepository.findAllByManagementUnitId(managementUnitId).stream().map(attendanceMachine -> {
            var dto = modelMapper.map(attendanceMachine, AttendanceMachineDto.class);
            var managementUnit = attendanceMachine.getManagementUnit();
            if (managementUnit != null) {
                dto.setManagementUnitName(managementUnit.getName());
                dto.setManagementUnitId(managementUnit.getId());
            }
            return dto;
        }).toList();
    }

    public AttendanceMachine insertOrUpdateAttendanceMachine(AttendanceMachineInsertOrReplaceDto dto) {
        var device = attendanceMachineRepository.findByCode(dto.getCode());
        if(device == null){
            var machine = new AttendanceMachine();
            machine.setCode(dto.getCode());
            machine.setName(dto.getCode());
            return attendanceMachineRepository.save(machine);
        }

        return device;
    }
}

package com.example.demo.Controller;

import com.example.demo.DTO.AttendanceMachine.AttendanceMachineCreateDto;
import com.example.demo.DTO.AttendanceMachine.AttendanceMachineDto;
import com.example.demo.DTO.AttendanceMachine.AttendanceMachineInsertOrReplaceDto;
import com.example.demo.DTO.AttendanceMachine.AttendanceMachineUpdateDto;
import com.example.demo.Entites.AttendanceMachine;
import com.example.demo.Services.AttendanceMachineService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/attendance-machine")
@RequiredArgsConstructor
public class AttendanceMachineController {
    private final Logger logger = LoggerFactory.getLogger(AttendanceMachineController.class);

    private final AttendanceMachineService attendanceMachineService;

    @GetMapping
    public ResponseEntity<List<AttendanceMachineDto>> getAllAttendanceMachines(
            @RequestParam(required = false, defaultValue = "") String managementUnitId
    ) {
        logger.info("getAttendanceMachine");
        var attendanceMachines = attendanceMachineService.getAllAttendanceMachines(managementUnitId);
        return ResponseEntity.ok(attendanceMachines);
    }

    @GetMapping("{id}")
    public ResponseEntity<AttendanceMachineDto> getAttendanceMachineById(@PathVariable String id) {
        logger.info("getAttendanceMachineById");
        var attendanceMachine = attendanceMachineService.getAttendanceMachineById(id);
        return ResponseEntity.ok(attendanceMachine);
    }

    @PostMapping
    public ResponseEntity createAttendanceMachine(@RequestBody AttendanceMachineCreateDto attendanceMachine) {
        logger.info("createAttendanceMachine");
        attendanceMachineService.insertAttendanceMachine(attendanceMachine);
        return ResponseEntity.ok("AttendanceMachine created successfully");
    }

    @PutMapping("{id}")
    public ResponseEntity updateAttendanceMachine(@PathVariable String id, @RequestBody AttendanceMachineUpdateDto attendanceMachine) {
        logger.info("updateAttendanceMachine");
        attendanceMachineService.updateAttendanceMachine(id, attendanceMachine);
        return ResponseEntity.ok("AttendanceMachine updated successfully");
    }

    @DeleteMapping("{id}")
    public ResponseEntity deleteAttendanceMachine(@PathVariable String id) {
        logger.info("deleteAttendanceMachine");
        attendanceMachineService.deleteAttendanceMachine(id);
        return ResponseEntity.ok("AttendanceMachine deleted successfully");
    }

    @PatchMapping()
    public ResponseEntity insertOrUpdateAttendanceMachine(@RequestBody AttendanceMachineInsertOrReplaceDto attendanceMachine) {
        logger.info("updateAttendanceMachine");
        var result = attendanceMachineService.insertOrUpdateAttendanceMachine(attendanceMachine);
        return ResponseEntity.ok(result);
    }
}

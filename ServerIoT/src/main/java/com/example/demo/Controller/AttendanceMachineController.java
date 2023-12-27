package com.example.demo.Controller;

import com.example.demo.DTO.AttendanceMachine.AttendanceMachineCreateDto;
import com.example.demo.DTO.AttendanceMachine.AttendanceUpdateDto;
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
    public ResponseEntity<List<AttendanceMachine>> getAttendanceMachine() {
        logger.info("getAttendanceMachine");
        var attendanceMachines = attendanceMachineService.getAllAttendanceMachines();
        return ResponseEntity.ok(attendanceMachines);
    }

    @GetMapping("{id}")
    public ResponseEntity<AttendanceMachine> getAttendanceMachineById(@PathVariable String id) {
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
    public ResponseEntity updateAttendanceMachine(@PathVariable String id, @RequestBody AttendanceUpdateDto attendanceMachine) {
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
}

package com.example.demo.Controller;

import com.example.demo.DTO.User.UserCreateDto;
import com.example.demo.Entites.ManagementUnit;
import com.example.demo.Entites.User;
import com.example.demo.Services.ManagementUnitService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/management-unit")
@RequiredArgsConstructor
public class ManagementUnitController {
    private final Logger logger = LoggerFactory.getLogger(ManagementUnitController.class);
    private final ManagementUnitService managementUnitService;

    @GetMapping
    public ResponseEntity<List<ManagementUnit>> getAllManagementUnit() {
        logger.info("Getting all management unit.");
        var listManagementUnit = managementUnitService.getAllManagementUnit();
        return ResponseEntity.ok(listManagementUnit);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ManagementUnit> getManagementUnitById(@PathVariable String id) {
        logger.info("Getting management unit with ID: {}.", id);
        var managementUnit = managementUnitService.getManagementUnitById(id);
        return ResponseEntity.ok(managementUnit);
    }
    @PostMapping
    public ResponseEntity<String> InsertManagementUnit(@RequestBody ManagementUnit managementUnit) {
        logger.info("Insert management unit.");
        managementUnitService.InsertManagementUnit(managementUnit);
        return ResponseEntity.ok("Insert management unit successfully.");
    }

    @PatchMapping("/{id}")
    public ResponseEntity<String> UpdateManagementUnit(@PathVariable String id, @RequestBody ManagementUnit managementUnit) {
        logger.info("Update management unit.");
        managementUnitService.UpdateManagementUnit(id, managementUnit);
        return ResponseEntity.ok("Update management unit successfully.");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> DeleteManagementUnit(@PathVariable String id) {
        logger.info("Delete management unit.");
        managementUnitService.DeleteManagementUnit(id);
        return ResponseEntity.ok("Delete management unit successfully.");
    }

    @PostMapping("/{id}/user")
    public ResponseEntity<String>
    InsertUserToManagementUnit(@PathVariable String id, @RequestBody UserCreateDto user) {
        logger.info("Insert user to management unit.");
        managementUnitService.InsertUserToManagementUnit(id, user);
        return ResponseEntity.ok("Insert user to management unit successfully.");
    }

    @PatchMapping("/user/disable/{userId}")
    public ResponseEntity<String> DisableUserFromManagementUnit(@PathVariable String userId) {
        logger.info("Disabled user from management unit.");
        managementUnitService.DisableUser(userId);
        return ResponseEntity.ok("Disabled user with ID: " + userId  + " successfully.");
    }

    @PatchMapping("/user/active/{userId}")
    public ResponseEntity<String> ActiveUserFromManagementUnit(@PathVariable String userId) {
        logger.info("Disabled user from management unit.");
        var result = managementUnitService.ActivateUser(userId);
        return ResponseEntity.ok("Disabled user with ID: " + userId  + " successfully.");
    }

//    @PostMapping("/user")
//    public ResponseEntity<String> CreateNewUser(@PathVariable String id,@RequestBody UserCreateDto user) {
//        logger.info("Create new user.");
//        var result = managementUnitService.InsertUserToManagementUnit(id, user);
//        if(!result) {
//            return ResponseEntity.badRequest().body("Create new user failed.");
//        }
//        return ResponseEntity.ok("Create new user successfully.");
//    }
}

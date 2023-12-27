package com.example.demo.Controller;

import com.example.demo.DTO.User.UserCreateDto;
import com.example.demo.DTO.User.UserDto;
import com.example.demo.DTO.User.UserUpdateDto;
import com.example.demo.Entites.User;
import com.example.demo.Enums.Role;
import com.example.demo.Models.Request.ChangeProfileRequest;
import com.example.demo.Models.Response.FilterData;
import com.example.demo.Repository.UserRepository;
import com.example.demo.Services.UserService;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/api/v1/user")
@RequiredArgsConstructor
public class UserController {
    private final Logger logger = LoggerFactory.getLogger(UserController.class);

    private final UserService userService;

    @RequestMapping(value = "/all",method = RequestMethod.GET)
    public ResponseEntity<List<UserDto>> getAllUsers() {
        logger.info("Getting all users.");
        var listUsers = userService.getAllUsers();
        return ResponseEntity.ok(listUsers);
    }

    @GetMapping
    public ResponseEntity<FilterData<UserDto>> FilterUser(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "5") int size
    ){
        logger.info("Getting filter users.");
        if(page < 1) page = 1;
        Pageable paging = Pageable.ofSize(size).withPage(page-1);
        var filterData = userService.getFilterUsers(paging);
        return ResponseEntity.ok(filterData);
    }

    @GetMapping("/{id}")
    public ResponseEntity getUser(@PathVariable String id) {
        logger.info("Getting user with ID: {}.", id);
        var user = userService.getUserById(id);
        return ResponseEntity.ok(user);
    }

    @GetMapping("/id")
    public ResponseEntity<List<String>> getAllEmployeeIds() {
        logger.info("Getting all user employee ids.");
        var listUsersIds = userService.getAllEmployeeIds();
        return ResponseEntity.ok(listUsersIds);
    }

    @GetMapping("/employee")
    public ResponseEntity<List<User>> getAllEmployees() {
        logger.info("Getting all users by role employee.");
        var listUsers = userService.getAllEmployee();
        return ResponseEntity.ok(listUsers);
    }
    @GetMapping("/admin")
    public ResponseEntity<List<User>> getAllAdmins() {
        logger.info("Getting all users by role admin.");
        var listUsers = userService.getAllAdmin();
        return ResponseEntity.ok(listUsers);
    }

    @GetMapping("/manager")
    public ResponseEntity<List<User>> getAllManagers() {
        logger.info("Getting all users by role manage.");
        var listUsers = userService.getAllManager();
        return ResponseEntity.ok(listUsers);
    }

    @PostMapping("{id}/profile")
    public ResponseEntity<String> ChangeProfile(@PathVariable String id,@RequestBody ChangeProfileRequest request) {
        logger.info("Change profile.");
        userService.UpdateProfile(id,request);
        return ResponseEntity.ok("Change profile successfully.");
    }

    @PostMapping("/{id}")
    public ResponseEntity<String> UpdateUser(@PathVariable String id, @RequestBody UserUpdateDto userDto) {
        logger.info("Insert user.");
        userService.UpdateUser(id,userDto);
        return ResponseEntity.ok("Update user successfully.");
    }

    @PostMapping
    public ResponseEntity<String> InsertUser(@RequestBody UserCreateDto user) {
        logger.info("Insert user.");
        var result = userService.InsertUser(user);
        return ResponseEntity.ok("Insert user successfully.");
    }
}

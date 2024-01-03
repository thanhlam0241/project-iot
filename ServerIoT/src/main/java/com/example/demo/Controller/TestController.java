package com.example.demo.Controller;


import com.example.demo.Entites.User;
import com.example.demo.Repository.UserRepository;
import com.example.demo.Services.AttendanceLogService;
import com.example.demo.Services.AttendanceService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/test")
@RequiredArgsConstructor
public class TestController {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    @GetMapping
    public ResponseEntity<String> updateLogs(){
        List<User> users = userRepository.findAll();

        for(User user : users){
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            userRepository.save(user);
        }

        return ResponseEntity.ok("Hello");
    }
}

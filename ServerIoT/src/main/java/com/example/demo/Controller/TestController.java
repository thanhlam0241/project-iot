package com.example.demo.Controller;


import com.example.demo.Entites.User;
import com.example.demo.Repository.UserRepository;
import com.example.demo.Services.AttendanceLogService;
import com.example.demo.Services.AttendanceService;
import com.example.demo.Services.FileStorageService;
import com.example.demo.Utils.FileUploadUtil;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1/test")
@RequiredArgsConstructor
public class TestController {
    private static final Logger logger = LoggerFactory.getLogger(TestController.class);
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    private FileStorageService fileStorageService;



    @GetMapping
    public ResponseEntity<String> updateLogs(){
        List<User> users = userRepository.findAll();

        for(User user : users){
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            userRepository.save(user);
        }

        return ResponseEntity.ok("Hello");
    }

    @PostMapping("/upload")
    public ResponseEntity<String> uploadFile(@RequestParam("file") MultipartFile files) throws Exception {
        String fileName = fileStorageService.storeFile(files);

        String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/downloadFile/")
                .path(fileName)
                .toUriString();

        return ResponseEntity.ok(fileDownloadUri);
    }

    @PostMapping("/uploadMultipleFiles")
    public ResponseEntity<String> uploadMultipleFiles(@RequestParam("files") MultipartFile[] files) {
        Arrays.asList(files)
                .stream()
                .map(file -> {
                    try {
                        return uploadFile(file);
                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                });
        return ResponseEntity.ok("Hello");
    }

}

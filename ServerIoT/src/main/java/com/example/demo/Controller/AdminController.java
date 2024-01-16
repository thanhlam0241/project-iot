package com.example.demo.Controller;


import com.example.demo.Exception.Model.BadRequestException;
import com.example.demo.Models.Response.StatisticAttendance;
import com.example.demo.Models.Response.StatisticHuman;
import com.example.demo.Repository.AttendanceMachineRepository;
import com.example.demo.Services.AdminService;
import com.example.demo.Services.AttendanceMachineService;
import com.example.demo.Services.ManagementUnitService;
import com.example.demo.Services.UserService;
import com.example.demo.Utils.BinaryHelper;
import com.example.demo.Utils.Resource.RedisResource;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/admin")
@RequiredArgsConstructor
@Slf4j
public class AdminController {
    @Autowired
    private AmqpTemplate rabbitTemplate;
    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    @Value("${rabbitmq.queue.queue-input-face}")
    private String nameFaceInputQueue;

    private final AdminService adminService;
    private final UserService userService;

    @GetMapping("/statistic/human")
    public ResponseEntity<StatisticHuman> getStatisticHuman() {
        return ResponseEntity.ok(adminService.getStatisticHuman());
    }

    @GetMapping("/statistic/attendance")
    public ResponseEntity<StatisticAttendance> getStatisticAttendance(@RequestParam int year) {
        return ResponseEntity.ok(adminService.getStatisticAttendance(year));
    }

    @PostMapping("/registerFace")
    public ResponseEntity registerAccountWithFace(
            @RequestParam("model") String model,
            @RequestParam("images") MultipartFile[] images) throws Exception {
        // insert user
        ObjectMapper objectMapper = new ObjectMapper();
        var userDto = objectMapper.readValue(model, com.example.demo.DTO.User.UserCreateDto.class);
        var user = userService.InsertUser(userDto);

        // prepare data for rabbitmq
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        baos.write(0x01);
        String uuid = UUID.randomUUID().toString().replace("-", "");
        baos.write(BinaryHelper.hexToBytes(uuid));
        baos.write(BinaryHelper.hexToBytes(user.getId()));
        byte n = (byte) images.length;
        baos.write(n);
        for(var image : images){
            if(image.getSize() > 0x7FFFFFFF){
                throw new BadRequestException("File too large");
            }
            int size = (int) image.getSize();
            baos.write(size & 0xFF);
            baos.write((size >> 8) & 0xFF);
            baos.write((size >> 16) & 0xFF);
            baos.write((size >> 24) & 0xFF);
        }
        for(var image : images){
            baos.write(image.getBytes());
        }

        // Save request to redis
        var redisKey = RedisResource.STRING_KEY_PREFIX_DEVICE_TO_FACE + uuid;
        var redisContent = "register," + user.getId();
        redisTemplate.opsForValue().set(redisKey, redisContent);

        // Send message to face detect system
        rabbitTemplate.convertAndSend(nameFaceInputQueue, baos.toByteArray());

        return ResponseEntity.ok(user);
    }

}

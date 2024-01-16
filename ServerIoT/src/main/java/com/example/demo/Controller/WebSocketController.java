package com.example.demo.Controller;

import com.example.demo.Entites.Socket.Greeting;
import com.example.demo.Entites.Socket.MessageSocket;
import com.example.demo.Entites.Socket.Notification;
import com.example.demo.Services.UserService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
public class WebSocketController {
    private final UserService userService;
    @Autowired
    private final SimpMessagingTemplate template;

    @PostMapping("api/v1/send")
    public ResponseEntity<Void> sendMessage(@RequestBody MessageSocket message) {
        template.convertAndSend("/topic/message", message);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("api/v1/send-to-user")
    public ResponseEntity<Void> sendMessageToUser(@RequestParam(
            required = true
    ) String id, @RequestBody MessageSocket message) {
        userService.getUserById(id);
        String channel = "/topic/message/" + id;
        template.convertAndSend(channel, new Notification("Bạn đã chấm công thành công", true));
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @MessageMapping("/sendMessage")
    public void receiveMessage(@Payload MessageSocket message) {
        // receive message from client
        System.out.println("Get message "+message.getName());
        template.convertAndSend("/topic/message", new MessageSocket("Server receive message success "));
    }

    @MessageMapping("")
    public void send(@Payload String ms){
        template.convertAndSend("/", new MessageSocket("Server receive message success "));
    }

    @SendTo("/topic/message")
    public MessageSocket broadcastMessage(@Payload MessageSocket message) {
        return message;
    }
}

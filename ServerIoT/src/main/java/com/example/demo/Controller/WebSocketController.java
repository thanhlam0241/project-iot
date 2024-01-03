package com.example.demo.Controller;

import com.example.demo.Entites.Socket.Greeting;
import com.example.demo.Entites.Socket.MessageSocket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.HtmlUtils;

@RestController
public class WebSocketController {

    @Autowired
    private SimpMessagingTemplate template;

    @PostMapping("api/v1/send")
    public ResponseEntity<Void> sendMessage(@RequestBody MessageSocket message) {
        template.convertAndSend("/topic/message", message);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @MessageMapping("/sendMessage")
    public void receiveMessage(@Payload MessageSocket message) {
        // receive message from client
        System.out.println("Get message "+message.getName());
        template.convertAndSend("/topic/message", new MessageSocket("Server receive message success "));
    }

    @SendTo("/topic/message")
    public MessageSocket broadcastMessage(@Payload MessageSocket message) {
        return message;
    }
}

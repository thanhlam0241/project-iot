//package com.example.demo.Configurations.RabbitMQ;
//
//import com.example.demo.Entites.AttendanceLog;
//import org.springframework.amqp.core.AmqpTemplate;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.stereotype.Service;
//
//@Service
//public class RabbitMQSender {
//    @Autowired
//    private AmqpTemplate rabbitTemplate;
//
//    @Value("${rabbitmq.exchange.direct}")
//    private String exchange;
//
//    @Value("${rabbitmq.routing-key.key-detect}")
//    private String routingKey;
//
//
//    public void send(AttendanceLog log) {
//        rabbitTemplate.convertAndSend(exchange, routingKey, log);
//        System.out.println("Send msg = " + log.getId());
//
//    }
//}

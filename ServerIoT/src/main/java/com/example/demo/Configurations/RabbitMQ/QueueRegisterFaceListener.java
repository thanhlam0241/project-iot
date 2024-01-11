package com.example.demo.Configurations.RabbitMQ;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
@RequiredArgsConstructor
public class QueueRegisterFaceListener {
    private static final Logger LOGGER = LoggerFactory.getLogger(QueueRegisterFaceListener.class);

    @Autowired
    private AmqpTemplate rabbitTemplate;

    @Autowired
    private RedisTemplate<String, String> template;

    @Value("${rabbitmq.exchange.direct}")
    private String exchange;

    @RabbitListener(queues = {"${rabbitmq.queue.queue-register-face}"})
    public void consumeMessage(Message message) throws IOException {
        LOGGER.info(String.format("Received from machine id: %s", 1));
        // Receive message from attendance machine
        byte[] body = message.getBody();
        System.out.println("body: " + body.length);
    }
}

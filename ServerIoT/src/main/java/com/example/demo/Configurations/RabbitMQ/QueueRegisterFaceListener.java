package com.example.demo.Configurations.RabbitMQ;

import com.example.demo.Utils.Resource.RedisResource;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.ArrayUtils;
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
import java.util.Arrays;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class QueueRegisterFaceListener {
    private static final Logger LOGGER = LoggerFactory.getLogger(QueueRegisterFaceListener.class);

    @Autowired
    private AmqpTemplate rabbitTemplate;

    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    @Value("${rabbitmq.exchange.direct}")
    private String exchange;

    @Value("${rabbitmq.routing-key.key-register-face}")
    private String routingKey;

    @RabbitListener(queues = {"${rabbitmq.queue.queue-register-face}"})
    public void consumeMessage(Message message) throws IOException {
        LOGGER.info(String.format("Received from machine id: %s", 1));
        // Receive message from attendance machine
        byte[] body = message.getBody();
        System.out.println("body: " + body.length);

//        byte[] dataVideo = Arrays.copyOfRange(body, 24, body.length);
//        String typeData = "R";
//        String uuid = UUID.randomUUID().toString().replace("-", "");
//        String label = "0000000000000000";
//
//        byte[] data = ArrayUtils.addAll(typeData.getBytes(), uuid.getBytes());
//        data = ArrayUtils.addAll(data, label.getBytes());
//        data = ArrayUtils.addAll(data, dataVideo);
//
//        // Send message to face detect system, save request to redis
//        redisTemplate.opsForValue().set(RedisResource.STRING_KEY_PREFIX_REQUEST + uuid, "Waiting for result from face detect system");
//        rabbitTemplate.convertAndSend(exchange, routingKey, data);


    }
}

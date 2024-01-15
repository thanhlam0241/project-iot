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
import java.io.*;
import java.util.Arrays;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class QueueMachineListener {
    private static final Logger LOGGER = LoggerFactory.getLogger(QueueMachineListener.class);

    @Autowired
    private AmqpTemplate rabbitTemplate;

    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    @Value("${rabbitmq.exchange.direct}")
    private String exchange;

    @Value("${rabbitmq.routing-key.key-machine}")
    private String routingKey;

    @RabbitListener(queues = {"${rabbitmq.queue.queue-machine}"})
    public void consumeJsonMessage(Message message) throws IOException {
        LOGGER.info(String.format("Received from machine id: %s", 1));
        // Receive message from attendance machine
        byte[] body = message.getBody();

        // get id through  bytes first
        System.out.println("body: " + body.length);
        String idMachine = new String(Arrays.copyOf(body, 24));
        byte[] dataVideo = Arrays.copyOfRange(body, 24, body.length);

        System.out.println("idString: " + idMachine);

        String typeData = "R";
        String uuid = UUID.randomUUID().toString().replace("-", "");
        String label = "0000000000000000";

        byte[] data = ArrayUtils.addAll(typeData.getBytes(), uuid.getBytes());
        data = ArrayUtils.addAll(data, label.getBytes());
        data = ArrayUtils.addAll(data, dataVideo);

        // Send message to face detect system, save request to redis
        redisTemplate.opsForValue().set(RedisResource.STRING_KEY_PREFIX_REQUEST + uuid, "Waiting for result from face detect system");
        rabbitTemplate.convertAndSend(exchange, routingKey, data);

//        String stringMessage = new String(body);
//        System.out.println(stringMessage);
//        String[] strings = stringMessage.split(",");
//        String extension;
//        switch (strings[0]) {//check image's extension
//            case "data:image/jpeg;base64":
//                extension = "jpeg";
//                break;
//            case "data:image/png;base64":
//                extension = "png";
//                break;
//            default://should write cases for more images types
//                extension = "jpg";
//                break;
//        }
//
//        String path = "src/main/resources/uploads";
//        byte[] data = DatatypeConverter.parseBase64Binary(strings[1]);
//        File file = new File(path + "/1."+ extension);
//        try (OutputStream outputStream = new BufferedOutputStream(new FileOutputStream(file))) {
//            outputStream.write(data);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }

    }
}

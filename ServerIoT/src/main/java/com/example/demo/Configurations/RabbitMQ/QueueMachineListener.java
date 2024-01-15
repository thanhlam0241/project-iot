package com.example.demo.Configurations.RabbitMQ;

import com.example.demo.Utils.BinaryHelper;
import com.example.demo.Utils.Resource.RedisResource;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.ArrayUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.amqp.core.Exchange;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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

    @Value("${rabbitmq.queue.queue-input-face}")
    private String nameFaceInputQueue;

    @RabbitListener(queues = {"${rabbitmq.queue.queue-machine-log}"})
    public void consumeJsonMessage(Message message) throws IOException {
        LOGGER.info(String.format("Received from machine id: %s", 1));
        // Receive message from attendance machine
        byte[] body = message.getBody();

        // get id through  bytes first
        var deviceId = BinaryHelper.bytesToHex(body, 0, 12);
        int dataVideoLength = body.length - 12;

        System.out.println("body: " + body.length);
        System.out.println("idString: " + deviceId);
        System.out.println("dataVideoLength: " + dataVideoLength);

        String uuid = UUID.randomUUID().toString().replace("-", "");
        System.out.println("uuid: " + uuid);

        byte[] data = new byte[1 + 16 + 12 + dataVideoLength];
        data[0] = 0x00;
        BinaryHelper.hexToBytes(uuid, data, 1);
        System.arraycopy(body, 12, data, 29, dataVideoLength);

        var now = LocalDateTime.now();
        var datetime = now.toString();

        String redisContent = deviceId + "," + datetime;

        // Send message to face detect system, save request to redis
        redisTemplate.opsForValue().set(
                RedisResource.STRING_KEY_PREFIX_DEVICE_TO_FACE + uuid,
                redisContent);
        rabbitTemplate.convertAndSend(nameFaceInputQueue, data);

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

package com.example.demo.Configurations.RabbitMQ;

import com.example.demo.Models.Request.LogMachine;
import jakarta.xml.bind.DatatypeConverter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;
import java.io.*;
@Component
public class RabbitMQListenerResultFromMachine {
    private static final Logger LOGGER = LoggerFactory.getLogger(RabbitMQListenerResultFromMachine.class);

    @RabbitListener(queues = {"${rabbitmq.queue.queue-detect}"})
    public void consumeJsonMessage(Message message) throws IOException {
        LOGGER.info(String.format("Received from machine id: %s", 1));
        byte[] body = message.getBody();
        String stringMessage = new String(body);
        System.out.println(stringMessage);

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

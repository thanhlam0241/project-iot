package com.example.demo.Configurations.RabbitMQ;

import com.example.demo.Models.Request.LogMachine;
import jakarta.xml.bind.DatatypeConverter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.io.*;

@Component
public class RabbitMQListenerResultFromMachine {
    private static final Logger LOGGER = LoggerFactory.getLogger(RabbitMQListenerResultFromMachine.class);

    @RabbitListener(queues = {"${rabbitmq.queue.queue-detect}"})
    public void consumeJsonMessage(String log) throws IOException {
        LOGGER.info(String.format("Received from machine id: %s", log));
    }
}

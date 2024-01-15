package com.example.demo.Configurations.RabbitMQ;

import com.example.demo.Services.AttendanceLogService;
import org.modelmapper.ModelMapper;
import org.springframework.amqp.core.*;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.amqp.RabbitProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMQConfig {
    @Value("${rabbitmq.queue.queue-machine-log}")
    String nameQueueMachineLog;
    @Value("${rabbitmq.queue.exchange-machine-result}")
    String nameExchangeMachineResult;
    @Value("${rabbitmq.queue.queue-output-face}")
    String nameQueueFaceOutput;
    @Value("${rabbitmq.queue.queue-input-face}")
    String nameQueueFaceInput;

    @Value("${rabbitmq.exchange.direct}")
    String exchangeTypeDirect;

    @Value("${rabbitmq.username}")
    String username;

    @Value("${rabbitmq.password}")
    private String password;

    @Value("${rabbitmq.host}")
    private String host;

    @Autowired
    private AttendanceLogService attendanceLogService;

    @Autowired
    private ModelMapper modelMapper;

    @Bean
    Queue queueMachineLog(){
        return new Queue(nameQueueMachineLog, false);
    }
    @Bean
    Exchange exchangeMachineResult(){
        return ExchangeBuilder.directExchange(nameExchangeMachineResult).durable(false).build();
    }

    @Bean
    Queue queueFaceInput(){
        return new Queue(nameQueueFaceInput, false);
    }
    @Bean
    Queue queueFaceOutput(){
        return new Queue(nameQueueFaceOutput, false);
    }

    @Bean
    public CachingConnectionFactory rabbitConnectionFactory(RabbitProperties config)
            throws Exception {
        CachingConnectionFactory connectionFactory = new CachingConnectionFactory();
        connectionFactory.getRabbitConnectionFactory()
                .setUri(host);
        return connectionFactory;
    }
}

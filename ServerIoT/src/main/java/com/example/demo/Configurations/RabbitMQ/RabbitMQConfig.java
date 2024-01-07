package com.example.demo.Configurations.RabbitMQ;

import com.example.demo.Services.AttendanceLogService;
import org.modelmapper.ModelMapper;
import org.springframework.amqp.core.*;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.amqp.RabbitProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.amqp.rabbit.listener.MessageListenerContainer;
import org.springframework.amqp.rabbit.listener.SimpleMessageListenerContainer;

@Configuration
public class RabbitMQConfig {
    @Value("${rabbitmq.queue.queue-machine}")
    String nameQueueReceiveLogFromMachine;

    @Value("${rabbitmq.queue.queue-detect}")
    String nameQueueSendDataToFaceDetect;

    @Value("${rabbitmq.queue.queue-face}")
    String nameQueueResultDetect;

    @Value("${rabbitmq.exchange.direct}")
    String exchange;

    @Value("${rabbitmq.routing-key.key-machine}")
    private String routingKeyMachine;

    @Value("${rabbitmq.routing-key.key-detect}")
    private String routingKeyDetect;

    @Value("${rabbitmq.routing-key.key-result}")
    private String routingKeyFace;

    @Value("${rabbitmq.username}")
    String username;

    @Value("${rabbitmq.password}")
    private String password;

    @Value("${rabbitmq.host}")
    private String host;

    @Autowired
    private AttendanceLogService attendanceLogService;

    @Autowired
    private RabbitMQListenerResultFromFaceDetect rabbitMQListener;

    @Autowired
    private ModelMapper modelMapper;

    @Bean
    Queue queueResult() {
        return new Queue(nameQueueResultDetect, false);
    }

    @Bean
    Queue queueMachine(){
        return new Queue(nameQueueReceiveLogFromMachine, false);
    }

    @Bean
    Queue queueFaceDetect(){
        return new Queue(nameQueueSendDataToFaceDetect, false);
    }

    @Bean
    DirectExchange exchange() {
        return new DirectExchange(exchange);
    }

    @Bean
    Binding machineBinding(Queue queueMachine, DirectExchange exchange) {
        return BindingBuilder.bind(queueMachine).to(exchange).with(routingKeyMachine);
    }
    @Bean
    Binding faceBinding(Queue queueResult, DirectExchange exchange) {
        return BindingBuilder.bind(queueResult).to(exchange).with(routingKeyFace);
    }
    @Bean
    Binding detectBinding(Queue queueFaceDetect, DirectExchange exchange) {
        return BindingBuilder.bind(queueFaceDetect).to(exchange).with(routingKeyDetect);
    }

//    @Bean
//    public MessageConverter jsonMessageConverter() {
//        return new Jackson2JsonMessageConverter();
//    }


//    @Bean
//    public AmqpTemplate rabbitTemplate(ConnectionFactory connectionFactory) {
//        final RabbitTemplate rabbitTemplate = new RabbitTemplate(connectionFactory);
//        rabbitTemplate.setMessageConverter(jsonMessageConverter());
//        return rabbitTemplate;
//    }


    @Bean
    public CachingConnectionFactory rabbitConnectionFactory(RabbitProperties config)
            throws Exception {
        CachingConnectionFactory connectionFactory = new CachingConnectionFactory();
        connectionFactory.getRabbitConnectionFactory()
                .setUri(host);
        return connectionFactory;
    }

    //create MessageListenerContainer using default connection factory
    @Bean
    MessageListenerContainer messageListenerContainer(ConnectionFactory connectionFactory ) {
        SimpleMessageListenerContainer simpleMessageListenerContainer = new SimpleMessageListenerContainer();
        simpleMessageListenerContainer.setConnectionFactory(connectionFactory);
        simpleMessageListenerContainer.setQueues(queueResult());
        simpleMessageListenerContainer.setMessageListener(rabbitMQListener);
        return simpleMessageListenerContainer;
    }

}

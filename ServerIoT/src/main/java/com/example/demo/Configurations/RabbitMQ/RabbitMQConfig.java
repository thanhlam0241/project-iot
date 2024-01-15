package com.example.demo.Configurations.RabbitMQ;

import com.example.demo.Services.AttendanceLogService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.amqp.core.*;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.amqp.RabbitProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.amqp.rabbit.listener.MessageListenerContainer;
import org.springframework.amqp.rabbit.listener.SimpleMessageListenerContainer;

@Configuration
public class RabbitMQConfig {
    @Value("${rabbitmq.queue.queue-machine}")
    String nameQueueMachine;
    @Value("${rabbitmq.queue.queue-register-face}")
    String nameQueueRegisterFace;
    @Value("${rabbitmq.queue.queue-output-face}")
    String nameQueueOutputFace;
    @Value("${rabbitmq.queue.queue-input-face}")
    String nameQueueInputFace;

    @Value("${rabbitmq.exchange.direct}")
    String exchange;

    @Value("${rabbitmq.routing-key.key-machine}")
    private String routingKeyMachine;

    @Value("${rabbitmq.routing-key.key-input-face}")
    private String routingKeyInputFace;

    @Value("${rabbitmq.routing-key.key-register-face}")
    private String routingKeyRegisterFace;

    @Value("${rabbitmq.routing-key.key-output-face}")
    private String routingKeyOutputFace;


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
    Queue queueMachine(){
        return new Queue(nameQueueMachine, false);
    }
    @Bean
    Queue queueRegisterFace(){return new Queue(nameQueueRegisterFace, false);}
    @Bean
    Queue queueInput(){
        return new Queue(nameQueueInputFace, false);
    }
    @Bean
    Queue queueOutput(){
        return new Queue(nameQueueOutputFace, false);
    }


    @Bean
    DirectExchange exchange() {
        return new DirectExchange(exchange);
    }

    @Bean
    Binding machineBinding(@Qualifier("queueMachine") Queue queueMachine, DirectExchange exchange) {
        return BindingBuilder.bind(queueMachine).to(exchange).with(routingKeyMachine);
    }
    @Bean
    Binding faceInputBinding(@Qualifier("queueInput") Queue queueInput, DirectExchange exchange) {
        return BindingBuilder.bind(queueInput).to(exchange).with(routingKeyInputFace);
    }
    @Bean
    Binding faceOutputBinding(@Qualifier("queueOutput") Queue queueOutput, DirectExchange exchange) {
        return BindingBuilder.bind(queueOutput).to(exchange).with(routingKeyOutputFace);
    }
    @Bean
    Binding registerFaceBinding(@Qualifier("queueRegisterFace") Queue queueRegister, DirectExchange exchange) {
        return BindingBuilder.bind(queueRegister).to(exchange).with(routingKeyRegisterFace);
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
//    @Bean
//    MessageListenerContainer messageListenerContainer(ConnectionFactory connectionFactory ) {
//        SimpleMessageListenerContainer simpleMessageListenerContainer = new SimpleMessageListenerContainer();
//        simpleMessageListenerContainer.setConnectionFactory(connectionFactory);
//        simpleMessageListenerContainer.setQueues(queueResult());
//        simpleMessageListenerContainer.setMessageListener(rabbitMQListener);
//        return simpleMessageListenerContainer;
//    }

}

//package com.example.demo.Configurations.WebSocket;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.messaging.simp.config.MessageBrokerRegistry;
//import org.springframework.web.socket.config.annotation.*;
//
//@Configuration
////@EnableWebSocket
//@EnableWebSocketMessageBroker
//public class WebSocketBrokerConfig implements WebSocketMessageBrokerConfigurer
//{
//    @Override
//    public void configureMessageBroker(MessageBrokerRegistry config) {
//        config.enableSimpleBroker("/topic","/queue");
//        config.setApplicationDestinationPrefixes("/app");
//    }
//
//    @Override
//    public void registerStompEndpoints(StompEndpointRegistry registry) {
//        registry.addEndpoint("/websocket").setAllowedOriginPatterns("*");
//        registry.addEndpoint("/ws").setAllowedOriginPatterns("*").withSockJS();
//    }
//}

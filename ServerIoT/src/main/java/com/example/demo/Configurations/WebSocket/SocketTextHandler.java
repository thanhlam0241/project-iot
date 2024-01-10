//package com.example.demo.Configurations.WebSocket;
//
//import org.json.JSONObject;
//import org.springframework.stereotype.Component;
//import org.springframework.web.socket.CloseStatus;
//import org.springframework.web.socket.TextMessage;
//import org.springframework.web.socket.WebSocketMessage;
//import org.springframework.web.socket.WebSocketSession;
//import org.springframework.web.socket.handler.TextWebSocketHandler;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.Collections;
//import java.util.List;
//
//@Component
//public class SocketTextHandler extends TextWebSocketHandler {
//    List<WebSocketSession> webSocketSessions = Collections.synchronizedList(new ArrayList<>());
//    @Override
//    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//        super.afterConnectionEstablished(session);
//        webSocketSessions.add(session);
//    }
//
//    @Override
//    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//        super.afterConnectionClosed(session, status);
//        webSocketSessions.remove(session);
//    }
//
//    @Override
//    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
//
//        super.handleMessage(session, message);
//        for (WebSocketSession webSocketSession : webSocketSessions) {
//            webSocketSession.sendMessage(message);
//        }
//    }
//}

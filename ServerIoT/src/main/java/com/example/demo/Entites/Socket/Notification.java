package com.example.demo.Entites.Socket;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
@AllArgsConstructor
public class Notification {
    private String msg;
    private boolean success;
}

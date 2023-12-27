package com.example.demo.Exception.Model;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class AppException extends RuntimeException {
    private int code;
    private String message;

    @Override
    public int hashCode() {
        return code;
    }
}

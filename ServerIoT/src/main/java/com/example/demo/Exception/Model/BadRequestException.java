package com.example.demo.Exception.Model;

public class BadRequestException extends RuntimeException {

    public BadRequestException(String message) {
        super(message);
    }

    @Override
    public int hashCode() {
        return 400;
    }
}

package com.example.demo.Exception.Model;

public class ConflictException extends RuntimeException {

    public ConflictException(String message) {
        super(message);
    }

    @Override
    public int hashCode() {
        return 409;
    }
}

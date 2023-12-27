package com.example.demo.Exception.Model;

public class NotFoundException extends RuntimeException {

    public NotFoundException(int errorCode, String message) {
        super(message);
    }

    public NotFoundException(String message) {
        super(message);
    }

    @Override
    public int hashCode() {
        return 404;
    }
}

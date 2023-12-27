package com.example.demo.Exception.Model;

public class UnauthorizedException extends RuntimeException {

    public UnauthorizedException(int errorCode, String message) {
        super(message);
    }

    public UnauthorizedException(String message) {
        super(message);
    }

    @Override
    public int hashCode() {
        return 401;
    }
}

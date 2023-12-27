package com.example.demo.Exception.Model;

public class ForbiddenException extends RuntimeException {

        public ForbiddenException(int errorCode, String message) {
            super(message);
        }

        public ForbiddenException(String message) {
            super(message);
        }

        @Override
        public int hashCode() {
            return 403;
        }
}

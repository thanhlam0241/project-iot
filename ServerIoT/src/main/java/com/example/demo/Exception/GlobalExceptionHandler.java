package com.example.demo.Exception;

import com.example.demo.Exception.Model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

    // Logger để log lỗi ra
    private final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    // Exception handler cho AppException
    @ExceptionHandler(
            {
                    AppException.class,
                    NotFoundException.class,
                    BadRequestException.class ,
                    ForbiddenException.class,
                    UnauthorizedException.class,
                    ConflictException.class,
            })
    public ResponseEntity<String> handleExceptionA(Exception e) {
        return ResponseEntity.status(e.hashCode()).body(e.getMessage());
    }

    // Other exception handler

    @ExceptionHandler(Exception.class)
    public ResponseEntity<String> handleUnwantedException(Exception e) {
        // Log lỗi ra và ẩn đi message thực sự
        logger.error("Error: ", e);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
    }
}
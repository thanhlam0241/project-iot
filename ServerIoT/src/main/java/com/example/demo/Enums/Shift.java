package com.example.demo.Enums;

public enum Shift {
    MORNING(1),
    AFTERNOON(2),
    NONE(0);

    protected int shiftCode;

    Shift(int code) {
        this.shiftCode = code;
    }
}

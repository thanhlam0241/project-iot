package com.example.demo.Models.Request;

public class LogMachine {
    private String machineId;
    private byte[] imageBase64;

    public LogMachine(){}

    public LogMachine(String m, byte[] img){
        this.machineId = m;
        this.imageBase64 = img;
    }

    public String getMachineId() {
        return machineId;
    }

    public void setMachineId(String machineId) {
        this.machineId = machineId;
    }

    public byte[] getImageBase64() {
        return imageBase64;
    }

    public void setImageBase64(byte[] imageBase64) {
        this.imageBase64 = imageBase64;
    }
}

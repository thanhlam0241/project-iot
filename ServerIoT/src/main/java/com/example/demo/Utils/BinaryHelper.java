package com.example.demo.Utils;

public class BinaryHelper {
    public static String bytesToHex(byte[] bytes) {
        StringBuilder result = new StringBuilder();
        for (byte aByte : bytes) {
            result.append(Integer.toString((aByte & 0xff) + 0x100, 16).substring(1));
        }
        return result.toString();
    }
    public static String bytesToHex(byte[] bytes, int from, int to) {
        StringBuilder result = new StringBuilder();
        for (int i = from; i < to; i++) {
            result.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
        }
        return result.toString();
    }
    public static byte[] hexToBytes(String hex) {
        int len = hex.length();
        if(len % 2 != 0){
            return null;
        }
        byte[] data = new byte[len / 2];
        for(int i = 0; i < len; i+=2){
            data[i/2] = (byte) ((Character.digit(hex.charAt(i), 16) << 4) + Character.digit(hex.charAt(i+1), 16));
        }
        return data;
    }
    public static byte[] hexToBytes(String hex, byte[] dest, int from) {
        int len = hex.length();
        if(len % 2 != 0){
            return null;
        }
        for(int i = 0; i < len; i+=2){
            dest[from + i/2] = (byte) ((Character.digit(hex.charAt(i), 16) << 4) + Character.digit(hex.charAt(i+1), 16));
        }
        return dest;
    }
}

package com.example.demo.Models.Request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@Data
@AllArgsConstructor
@RequiredArgsConstructor
public class ChangeProfileRequest {
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private String identityCard;
}

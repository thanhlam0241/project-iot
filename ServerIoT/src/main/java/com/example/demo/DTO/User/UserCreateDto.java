package com.example.demo.DTO.User;

import com.example.demo.Enums.Gender;
import com.example.demo.Enums.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserCreateDto {
    private String username;
    private String code;
    private String fullName;
    private String password;
    private String email;
    private String phone;
    private String address;
    private String identityCard;
    private String managementUnitId;
    private Gender gender;
    private Role role = Role.EMPLOYEE;
    private boolean active = true;
}

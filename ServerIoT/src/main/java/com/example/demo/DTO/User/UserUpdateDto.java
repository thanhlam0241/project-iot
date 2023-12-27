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
public class UserUpdateDto {
    private String username;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private String identityCard;
    private Role role;
    private Gender gender;
    private boolean active = true;
}

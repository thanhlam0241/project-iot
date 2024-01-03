package com.example.demo.DTO.User;

import com.example.demo.Entites.ManagementUnit;
import com.example.demo.Enums.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserDto {
    private String id;
    private String username;
    private String fullName;
    private Role role;
    private boolean active;
}

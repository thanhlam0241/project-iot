package com.example.demo.DTO.AttendanceMachine;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import org.springframework.data.mongodb.core.index.Indexed;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class AttendanceMachineCreateDto {
    private String managementUnitId;
    @Indexed(unique = true)
    private String code;
    @NonNull
    private String name;
}

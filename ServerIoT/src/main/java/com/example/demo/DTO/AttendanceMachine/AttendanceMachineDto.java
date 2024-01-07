package com.example.demo.DTO.AttendanceMachine;

import com.example.demo.Entites.ManagementUnit;
import jakarta.validation.constraints.Null;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.DocumentReference;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AttendanceMachineDto {
    @Null
    private String managementUnitId;
    @Null
    private String managementUnitName;

    private String code;
    private String name;
    private String id;
}

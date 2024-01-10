package com.example.demo.Entites;

import jakarta.validation.constraints.Null;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.DocumentReference;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AttendanceMachine extends BaseEntity {
    @DocumentReference
    @Null
    private ManagementUnit managementUnit;

    private String code;
    private String name;
}

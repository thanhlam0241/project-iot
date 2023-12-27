package com.example.demo.Entites;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.DocumentReference;

@Document
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AttendanceMachine extends BaseEntity {
    @DocumentReference
    private ManagementUnit managementUnit;

    private String code;
    private String name;
}

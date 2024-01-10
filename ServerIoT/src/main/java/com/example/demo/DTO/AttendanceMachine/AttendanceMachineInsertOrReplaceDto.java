package com.example.demo.DTO.AttendanceMachine;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import org.springframework.data.mongodb.core.index.Indexed;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AttendanceMachineInsertOrReplaceDto {
    @Indexed(unique = true)
    private String code;

}

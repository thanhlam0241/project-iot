package com.example.demo.Entites;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public abstract class BaseEntity {
    @org.springframework.data.annotation.Id
    private String id;
//    public Date createdAt;
//    public Date updatedAt;
//    public String createdBy;
//    public String updatedBy;
}

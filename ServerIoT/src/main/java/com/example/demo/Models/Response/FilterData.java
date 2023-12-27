package com.example.demo.Models.Response;

import com.example.demo.Entites.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FilterData<T> {
    private int page;
    private int size;
    private int totalPage;
    private int totalElement;
    private List<T> data;
}

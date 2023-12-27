package com.example.demo.Repository;

import com.example.demo.Entites.ManagementUnit;

import java.util.Optional;

public interface ManagementUnitRepository extends BaseRepository<ManagementUnit,String>{
    boolean existsById(String id);
}

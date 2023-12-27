package com.example.demo.Repository;

import com.example.demo.Entites.AttendanceMachine;

import java.util.List;

public interface AttendanceMachineRepository extends BaseRepository<AttendanceMachine,String> {
    List<AttendanceMachine> findAllByManagementUnitId(String id);
}

package com.example.demo.Repository;

import com.example.demo.Entites.AttendanceLog;

import java.util.List;

public interface AttendanceLogRepository extends BaseRepository<AttendanceLog,String> {
    // For manager to find all attendance logs by management unit id, year, quarter and month
    List<AttendanceLog> findAllByManagementUnitId(String id);
    List<AttendanceLog> findAllByManagementUnitIdAndYear(String id, int year);
    List<AttendanceLog> findAllByManagementUnitIdAndYearAndMonth(String id, int year, int month);
    List<AttendanceLog> findAllByManagementUnitIdAndYearAndQuarter(String id, int year, int quarter);

    List<AttendanceLog> findAllByManagementUnitIdAndYearAndMonthAndDayOfMonth(String id, int year, int month, int dayOfMonth);

    // For employee/manager/admin to find all attendance logs by user id, year, quarter and month
    List<AttendanceLog> findAllByUserId(String id);
    List<AttendanceLog> findAllByUserIdAndYear(String id, int year);
    List<AttendanceLog> findAllByUserIdAndYearAndMonth(String id, int year, int month);
    List<AttendanceLog> findAllByUserIdAndYearAndQuarter(String id, int year, int quarter);

    // For admin to find all by year, quarter, month and day of month
    List<AttendanceLog> findAllByYear(int year);
    List<AttendanceLog> findAllByYearAndMonth(int year, int month);
    List<AttendanceLog> findAllByYearAndQuarter(int year, int quarter);
    List<AttendanceLog> findAllByYearAndMonthAndDayOfMonth(int year, int month, int dayOfMonth);


}

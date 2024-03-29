package com.example.demo.Repository;

import com.example.demo.Entites.AttendanceLog;
import com.example.demo.Enums.Shift;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
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

    List<AttendanceLog> findAllByUserIdAndTimeBetween(String id, LocalDateTime isoDayStart, LocalDateTime isoDayEnd);

    @Query(value = "{ year: ?0, month: ?1, isLate: true }", count = true)
    int countByYearAndMonthAndLate(int year, int month);

    @Query(value = "{ year: ?0, month: ?1, isOnTime: true }", count = true)
    int countByYearAndMonthAndOnTime(int year, int month);


    // For admin to find all by year, quarter, month and day of month
    List<AttendanceLog> findAllByYear(int year);
    List<AttendanceLog> findAllByYearAndMonth(int year, int month);
    List<AttendanceLog> findAllByYearAndQuarter(int year, int quarter);
    List<AttendanceLog> findAllByYearAndMonthAndDayOfMonth(int year, int month, int dayOfMonth);

    AttendanceLog findByUserIdAndYearAndMonthAndDayOfMonthAndShift(String id, int year, int month, int dayOfMonth, Shift shift);

}

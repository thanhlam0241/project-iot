package com.example.demo.Services;

import com.example.demo.DTO.User.UserCreateDto;
import com.example.demo.Entites.ManagementUnit;
import com.example.demo.Entites.User;
import com.example.demo.Exception.Model.NotFoundException;
import com.example.demo.Repository.AttendanceMachineRepository;
import com.example.demo.Repository.ManagementUnitRepository;
import com.example.demo.Repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ManagementUnitService {
    private final ModelMapper modelMapper;
    private final ManagementUnitRepository managementUnitRepository;
    private final UserRepository userRepository;

    private final AttendanceMachineRepository attendanceMachineRepository;

    private final PasswordEncoder passwordEncoder;

    public List<ManagementUnit> getAllManagementUnit() {
        var listManagementUnit = managementUnitRepository.findAll();
        return listManagementUnit;
    }

    public ManagementUnit getManagementUnitById(String id) {
        var managementUnit = managementUnitRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Management Unit not found"));
        return managementUnit;
    }

    public void InsertManagementUnit(ManagementUnit managementUnit) {
            managementUnitRepository.save(managementUnit);
    }

    public void UpdateManagementUnit(String id, ManagementUnit managementUnit) {
            var managementUnitUpdate = managementUnitRepository.findById(id)
                    .orElseThrow(() -> new NotFoundException(404, "Management Unit not found"));
            managementUnitUpdate.setName(managementUnit.getName());
            managementUnitRepository.save(managementUnitUpdate);
    }

    public void DeleteManagementUnit(String id) {
            var managementUnit = managementUnitRepository.findById(id)
                    .orElseThrow(() -> new NotFoundException(404, "Management Unit not found"));
            managementUnitRepository.deleteById(id);
    }

    public List<User> getAllUserByManagementUnitId(String id) {
        var managementUnit = managementUnitRepository.findById(id)
                .orElseThrow(() -> new NotFoundException(404, "Management Unit not found"));
        var users = userRepository.findAllByManagementUnitId(id);
        return users;
    }

    public void InsertUserToManagementUnit(String id, UserCreateDto user) {
        var managementUnit = managementUnitRepository.findById(id)
                .orElseThrow(() -> new NotFoundException(404, "Management Unit not found"));
        User userInsert = modelMapper.map(user, User.class);
        userInsert.setManagementUnit(managementUnit);
        userInsert.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(userInsert);
    }
    public void DisableUser(String userId) {
        var user = userRepository.findById(userId)
                .orElseThrow(() -> new NotFoundException(404, "User not found"));
        user.setActive(false);
        userRepository.save(user);
    }

    public boolean ActivateUser(String userId) {
        var user = userRepository.findById(userId)
                .orElseThrow(() -> new NotFoundException(404, "User not found"));
        user.setActive(true);
        userRepository.save(user);
        return true;
    }
}

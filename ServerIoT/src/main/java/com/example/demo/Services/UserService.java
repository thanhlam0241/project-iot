package com.example.demo.Services;

import com.example.demo.DTO.User.UserCreateDto;
import com.example.demo.DTO.User.UserDto;
import com.example.demo.DTO.User.UserUpdateDto;
import com.example.demo.Entites.User;
import com.example.demo.Enums.Role;
import com.example.demo.Exception.Model.NotFoundException;
import com.example.demo.Models.Request.ChangeProfileRequest;
import com.example.demo.Models.Response.FilterData;
import com.example.demo.Repository.ManagementUnitRepository;
import com.example.demo.Repository.UserRepository;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {
    private final ModelMapper modelMapper;
    private final UserRepository userRepository;
    private final ManagementUnitRepository managementUnitRepository;

    private final PasswordEncoder passwordEncoder;

    public List<String> getAllUserIds() {
        return userRepository.findAll().stream()
                .map(User::getId)
                .toList();
    }

    public UserDto getUserById(String id) {
        var user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
        return modelMapper.map(user, UserDto.class);
    }

    public List<User> getAllEmployee(){
        return userRepository.findAllByRole(Role.EMPLOYEE.toString());
    }

    public List<User> getAllManager(){
        return userRepository.findAllByRole(Role.MANAGER.toString());
    }

    public List<User> getAllAdmin(){
        return userRepository.findAllByRole(Role.ADMIN.toString());
    }

    public List<String> getAllEmployeeIds(){
        return userRepository.findAllByRole(Role.EMPLOYEE.toString())
                .stream()
                .map(User::getId)
                .toList();
    }

    public UserDto getUserByUsername(String username) {
        var user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));
        return modelMapper.map(user, UserDto.class);
    }

    public List<UserDto> getAllUsers() {
        var listUsers = userRepository.findAll();
        if(listUsers.isEmpty()) {
            throw new RuntimeException("No users found.");
        }
        return listUsers.stream()
                .map(user -> modelMapper.map(user, UserDto.class))
                .toList();
    }

    public FilterData<UserDto> getFilterUsers(Pageable pageable){
        var pageUsers = userRepository.findAll(pageable);
        var users = pageUsers.getContent().stream()
                .map(user -> modelMapper.map(user, UserDto.class))
                .toList();
        FilterData<UserDto> filterData = new FilterData<>();
        filterData.setData(users);
        filterData.setPage(pageUsers.getNumber());
        filterData.setSize(pageUsers.getSize());
        filterData.setTotalElement((int) pageUsers.getTotalElements());
        filterData.setTotalPage(pageUsers.getTotalPages());
        return filterData;
    }

    public Boolean InsertUser(UserCreateDto userDto) {
        var user = modelMapper.map(userDto, User.class);
        if(userDto.getManagementUnitId() != null){
            var managementUnit = managementUnitRepository.findById(userDto.getManagementUnitId())
                    .orElseThrow(() -> new NotFoundException("Management unit not found"));
            user.setManagementUnit(managementUnit);
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);
        return true;
    }

    public Boolean UpdateProfile(String id, ChangeProfileRequest profile) {
        var user = userRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("User not found"));
        user.setFullName(profile.getFullName());
        user.setEmail(profile.getEmail());
        user.setPhone(profile.getPhone());
        user.setAddress(profile.getAddress());
        user.setIdentityCard(profile.getIdentityCard());
        userRepository.save(user);
        return true;
    }

    public void UpdateUser(String id, UserUpdateDto userDto) {
        var user = userRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("User not found"));
        user.setFullName(userDto.getFullName());
        user.setEmail(userDto.getEmail());
        user.setPhone(userDto.getPhone());
        user.setAddress(userDto.getAddress());
        user.setIdentityCard(userDto.getIdentityCard());
        userRepository.save(user);
    }
}

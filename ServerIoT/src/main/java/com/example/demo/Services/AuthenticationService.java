package com.example.demo.Services;

import com.example.demo.DTO.User.UserDto;
import com.example.demo.Entites.User;
import com.example.demo.Enums.Role;
import com.example.demo.Exception.Model.AppException;
import com.example.demo.Exception.Model.ConflictException;
import com.example.demo.Models.Request.AuthenticateRequest;
import com.example.demo.Models.Request.RegisterRequest;
import com.example.demo.Models.Response.AuthenticationResponse;
import com.example.demo.Repository.UserRepository;
import com.example.demo.Configurations.Security.JwtService;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class AuthenticationService {
    private final UserRepository userAccountRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final ModelMapper modelMapper;
    public AuthenticationResponse register(RegisterRequest request) {
        var userExists = userAccountRepository.findByUsername(request.getUsername()).isPresent();
        if(userExists) {
            throw new AppException(401, "User already exists");
        }
        var user = User.builder()
                .username(request.getUsername())
                .password(passwordEncoder.encode(request.getPassword()))
                .fullName(request.getFullName())
                .role(Role.EMPLOYEE)
                .build();
        userAccountRepository.save(user);
        var jwtToken = jwtService.generateToken(user);
        return AuthenticationResponse.builder()
                .token(jwtToken)
                .build();
    }
    public AuthenticationResponse authenticate(AuthenticateRequest request) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getUsername(),
                        request.getPassword()
                )
        );
        SecurityContextHolder.getContext().setAuthentication(authentication);
        var user = userAccountRepository.findByUsername(authentication.getName())
                .orElseThrow(() -> new AppException(404, "User not found"));
        if(!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new AppException(409, "Invalid password");
        }
        var jwtToken = jwtService.generateToken(user);
        return AuthenticationResponse.builder()
                .token(jwtToken)
                .user(modelMapper.map(user, UserDto.class))
                .build();
    }

    public AuthenticationResponse authenticateAdmin(AuthenticateRequest request) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getUsername(),
                        request.getPassword()
                )
        );
        SecurityContextHolder.getContext().setAuthentication(authentication);
        var user = userAccountRepository.findByUsername(authentication.getName())
                .orElseThrow(() -> new AppException(404, "User not found"));
        if(user.getRole() != Role.ADMIN) {
            throw new AppException(403, "Not authorized");
        }
        if(!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new AppException(409, "Invalid password");
        }
        var jwtToken = jwtService.generateToken(user);
        return AuthenticationResponse.builder()
                .token(jwtToken)
                .user(modelMapper.map(user, UserDto.class))
                .build();
    }

    public void ChangePassword(String username, String oldPassword, String newPassword) {
        var user = userAccountRepository.findByUsername(username)
                .orElseThrow(() -> new AppException(404, "User not found"));
        if(!passwordEncoder.matches(oldPassword, user.getPassword())) {
            throw new ConflictException("Mật khẩu cũ không đúng");
        }
        user.setPassword(passwordEncoder.encode(newPassword));
        userAccountRepository.save(user);
    }
}

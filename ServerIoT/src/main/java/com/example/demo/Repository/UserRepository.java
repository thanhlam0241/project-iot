package com.example.demo.Repository;

import com.example.demo.Entites.User;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends BaseRepository<User,String> {
    Optional<User> findByUsername(String username);

    List<User> findAllByManagementUnitId(String id);

    List<User> findAllByRole(String role);

    int countByRole(String role);

    boolean existsByUsername(String username);

    boolean existsById(String id);

    Optional<User> findByUsernameAndRole(String username, String role);
}

package com.example.demo.Repository;

import com.example.demo.Entites.BaseEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

public interface BaseRepository<T extends BaseEntity,K> extends MongoRepository<T,K> {
    // Find by id
    Optional<T> findById(K key);
    // Paging and Sorting
    Page<T> findAll(Pageable pageable);
}

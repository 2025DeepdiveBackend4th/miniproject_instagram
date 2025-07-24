package com.project.instagram.domain.user.repository;

import com.project.instagram.domain.user.entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<Users, Long> {
    Users findUserByEmail(String email);
}

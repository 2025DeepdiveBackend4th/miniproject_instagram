package com.project.instagram.domain.user.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
@Entity
public class Users {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long user_id;

    @Column(length = 100, nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(length = 100, nullable = true)
    private String name;

    @Column(nullable = true)
    private String phone;

    @Column(nullable = true)
    private String profile_photo;

    @Column(nullable = true)
    private String email_cert_code;

    @Column(nullable = true)
    private String email_cert_date;

    @Column(nullable = true)
    private LocalDateTime created_at;

    @Column(nullable = true)
    private LocalDateTime updated_at;


    //@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    //@JsonIgnoreProperties({"user"})
    //private List<Post> postList;

}

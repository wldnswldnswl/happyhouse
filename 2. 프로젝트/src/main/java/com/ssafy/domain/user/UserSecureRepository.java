package com.ssafy.domain.user;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserSecureRepository extends JpaRepository<UserSecure, Long> {

	Optional<UserSecure> findByEmail(String email);
}

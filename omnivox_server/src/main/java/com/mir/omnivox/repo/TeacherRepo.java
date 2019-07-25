package com.mir.omnivox.repo;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mir.omnivox.model.Teacher;

@Repository
public interface TeacherRepo extends JpaRepository<Teacher, Long> {

	Optional<Teacher> findOneByTeacherID(String teacherID);
}

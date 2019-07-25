package com.mir.omnivox.repo;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mir.omnivox.model.Student;

@Repository
public interface StudentRepo extends JpaRepository<Student, Long>{
	
	Optional<Student> findOneByStudentID(String studentID);
}

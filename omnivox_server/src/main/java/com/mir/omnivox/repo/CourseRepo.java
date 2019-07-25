package com.mir.omnivox.repo;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mir.omnivox.model.Course;

@Repository
public interface CourseRepo extends JpaRepository<Course, Long>{
	
	Optional<Course> findOneByCourseID(String courseID);
}

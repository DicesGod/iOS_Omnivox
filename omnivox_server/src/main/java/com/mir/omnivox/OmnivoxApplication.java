package com.mir.omnivox;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import com.mir.omnivox.model.Course;
import com.mir.omnivox.model.Student;
import com.mir.omnivox.model.Teacher;
import com.mir.omnivox.repo.CourseRepo;
import com.mir.omnivox.repo.StudentRepo;
import com.mir.omnivox.repo.TeacherRepo;

@SpringBootApplication
public class OmnivoxApplication {

	public static void main(String[] args) {
		SpringApplication.run(OmnivoxApplication.class, args);
	}
	
	//To test
	@Bean
	CommandLineRunner runner (StudentRepo studentRepo, TeacherRepo teacherRepo, CourseRepo courseRepo) {
		return args -> {
			Student student = new Student();
			student.setStudentID("1");
			student.setName("Mir");
			studentRepo.save(student);
			
			Teacher teacher = new Teacher();
			teacher.setTeacherID("1");
			teacher.setName("Mir");
			teacherRepo.save(teacher);
			
			Course course = new Course();
			course.setCourseID("1");
			course.setCourseTitle("Android");
			course.setCredits(3);
			courseRepo.save(course);
		};
	}

}

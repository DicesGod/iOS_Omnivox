package com.mir.omnivox.controller;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.mir.omnivox.controller.form.StudentForm;
import com.mir.omnivox.model.Course;
import com.mir.omnivox.model.Student;
import com.mir.omnivox.repo.StudentRepo;

@RestController
public class StudentController {
	
	private final StudentRepo studentRepo;
	
	@Autowired
	public StudentController(StudentRepo studentRepo) {
		this.studentRepo = studentRepo;
	}

	@RequestMapping(value = "/students", method = RequestMethod.GET)
	public Collection<Student> findAll() {
		return studentRepo.findAll();
	}
	
	@RequestMapping(value = "/student/create", method = RequestMethod.POST)
	public Student create(@RequestBody StudentForm studentForm) {
		Student student = new Student();
		student.setStudentID(studentForm.getStudentID());
		student.setName(studentForm.getName());
		student.setCourses(new HashSet<Course>());
		return this.studentRepo.save(student);
	}
	
	@RequestMapping(value = "/student/{studentID}/courses", method = RequestMethod.GET)
	public Set<Course> getCoursesForStudent(@PathVariable String studentID) {
		try {
			return this.studentRepo.findOneByStudentID(studentID).orElseThrow().getCourses();
		} catch (Exception e) {
			e.printStackTrace();
			return new HashSet<Course>();
		}
	}
}

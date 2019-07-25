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

import com.mir.omnivox.controller.form.CourseForm;
import com.mir.omnivox.model.Course;
import com.mir.omnivox.model.Student;
import com.mir.omnivox.repo.CourseRepo;

@RestController
public class CourseController {
	
	private final CourseRepo courseRepo;
	
	@Autowired
	public CourseController(CourseRepo courseRepo) {
		this.courseRepo = courseRepo;
	}

	@RequestMapping(value = "/courses", method = RequestMethod.GET)
	public Collection<Course> findAll() {
		return this.courseRepo.findAll();
	}

	@RequestMapping(value = "/course/create", method = RequestMethod.POST)
	public Course create(@RequestBody CourseForm courseForm) {
		Course course = new Course();
		course.setCourseID(courseForm.getCourseID());
		course.setCourseTitle(courseForm.getCourseTitle());
		course.setCredits(courseForm.getCredits());
		course.setStudents(new HashSet<>());
		return this.courseRepo.save(course);
	}
	
	@RequestMapping(value = "/course/{courseID}/students", method = RequestMethod.GET)
	public Set<Student> getStudentsForCourse(@PathVariable String courseID) {
		try {
			return this.courseRepo.findOneByCourseID(courseID).orElseThrow().getStudents();
		} catch (Exception e) {
			e.printStackTrace();
			return new HashSet<Student>();
		}
	}
}

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

import com.mir.omnivox.controller.form.TeacherForm;
import com.mir.omnivox.model.Course;
import com.mir.omnivox.model.Teacher;
import com.mir.omnivox.repo.TeacherRepo;

@RestController
public class TeacherController {
	
	private final TeacherRepo teacherRepo;
	
	@Autowired
	public TeacherController(TeacherRepo teacherRepo) {
		this.teacherRepo = teacherRepo;
	}

	@RequestMapping(value = "/teachers", method = RequestMethod.GET)
	public Collection<Teacher> findAll() {
		return this.teacherRepo.findAll();
	}

	@RequestMapping(value = "/teacher/create", method = RequestMethod.POST)
	public Teacher create(@RequestBody TeacherForm teacherForm) {
		Teacher teacher = new Teacher();
		teacher.setTeacherID(teacherForm.getTeacherID());
		teacher.setName(teacherForm.getName());
		teacher.setCourses(new HashSet<>());
		return this.teacherRepo.save(teacher);
	}

	@RequestMapping(value = "/teacher/{teacherID}/courses", method = RequestMethod.GET)
	public Set<Course> getCoursesForTeacher(@PathVariable String teacherID) {
		try {
			return this.teacherRepo.findOneByTeacherID(teacherID).orElseThrow().getCourses();
		} catch (Exception e) {
			e.printStackTrace();
			return new HashSet<Course>();
		}
	}
}

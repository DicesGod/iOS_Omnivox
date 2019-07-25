package com.mir.omnivox.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mir.omnivox.controller.form.AssignStudentForm;
import com.mir.omnivox.controller.form.AssignTeacherForm;
import com.mir.omnivox.model.Course;
import com.mir.omnivox.model.Student;
import com.mir.omnivox.model.Teacher;
import com.mir.omnivox.repo.CourseRepo;
import com.mir.omnivox.repo.StudentRepo;
import com.mir.omnivox.repo.TeacherRepo;

@RestController
public class RelationController {
	
	private final StudentRepo studentRepo;
	private final CourseRepo courseRepo;
	private final TeacherRepo teacherRepo;
	
	@Autowired
	public RelationController(StudentRepo studentRepo, CourseRepo courseRepo, TeacherRepo teacherRepo) { 
		this.studentRepo = studentRepo;
		this.courseRepo = courseRepo;
		this.teacherRepo = teacherRepo;
	}
	
	private String assignCourseToStudent(String studentID, String courseID) {
		try {
			Student student = studentRepo.findOneByStudentID(studentID).orElseThrow();
			Course course = courseRepo.findOneByCourseID(courseID).orElseThrow();
			student.getCourses().add(course);
			course.getStudents().add(student);
			this.studentRepo.save(student);
			this.courseRepo.save(course);
			return "Success!";
		} catch (Exception e) {
			e.printStackTrace();
			return "Cannot find course or student";
		}
	}
	
	@RequestMapping(value = "/assign/student", method = RequestMethod.POST, consumes = "application/json")
	public AssignStudentForm assignCourseToStudent_JSON(@RequestBody AssignStudentForm assignStudentForm) {
		if(assignCourseToStudent(assignStudentForm.getStudentID(), assignStudentForm.getCourseID()) == "Success!") {
			return assignStudentForm;
		} else {
			return null;
		}	
	}
	
	@RequestMapping(value = "/assign/student", method = RequestMethod.POST, consumes = "multipart/form-data")
	public String assignCourseToStudent_FORM(@RequestParam String studentID, @RequestParam String courseID) {
		return assignCourseToStudent(studentID, courseID);
	}
	
	private String assignCourseToTeacher(String teacherID, String courseID) {
		try {
			Teacher teacher = teacherRepo.findOneByTeacherID(teacherID).orElseThrow();
			Course course = courseRepo.findOneByCourseID(courseID).orElseThrow();
			teacher.getCourses().add(course);
			course.setTeacher(teacher);
			this.courseRepo.save(course);
			this.teacherRepo.save(teacher);
			return "Success!";
		} catch (Exception e) {
			e.printStackTrace();
			return "Cannot find course or teacher";
		}
	}
	
	@RequestMapping(value = "/assign/teacher", method = RequestMethod.POST, consumes = "application/json")
	public AssignTeacherForm assignCourseToTeacher_JSON(@RequestBody AssignTeacherForm assignTeacherForm) {
		if(assignCourseToTeacher(assignTeacherForm.getTeacherID(), assignTeacherForm.getCourseID()) == "Success!") {
			return assignTeacherForm;
		} else {
			return null;
		}
	}
	
	@RequestMapping(value = "/assign/teacher", method = RequestMethod.POST, consumes = "multipart/form-data")
	public String assignCourseToTeacher_FORM(@RequestParam String teacherID, @RequestParam String courseID) {
		return assignCourseToTeacher(teacherID, courseID);
	}
}

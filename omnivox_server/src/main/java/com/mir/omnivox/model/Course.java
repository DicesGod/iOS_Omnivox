package com.mir.omnivox.model;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Data
@EqualsAndHashCode(exclude = "students")
public class Course {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@JsonIgnore
	private long id;

	@Column(unique = true, nullable = false)
	private String courseID;

	@Column(nullable = false)
	private String courseTitle;

	@Column(nullable = false)
	private int credits;

	@ManyToMany
	@JsonIgnore
	Set<Student> students;

	@ManyToOne
	@JsonIgnore
	private Teacher teacher;
}

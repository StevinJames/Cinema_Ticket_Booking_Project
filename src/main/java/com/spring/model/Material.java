package com.spring.model;

import java.sql.Timestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="material")
@Data
public class Material {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="course_id" , nullable = false)
	private Course course;
	
	@Column(name="title" , nullable = false)
	private String title;
	
	@Column(name="resource_file", nullable = false)
	private String resourceFile;
	
	@Column(name="description" , nullable = false)
	private String description;
	
	@Column(name="status" , nullable = false , columnDefinition = "int default 0")
	private int status;
	
	@Column(name = "created_date", nullable = false, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP" , updatable = false)
	private Timestamp createdDate;

	@Column(name = "updated_date", nullable = true, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
	private Timestamp updatedDate;
}

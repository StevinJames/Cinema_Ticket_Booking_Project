package com.spring.model;

import java.sql.Date;
import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Assignment {

	private int id;
	private String title;
	private String description;
	private String grade;
	
	private byte[] resourceFile;
	private MultipartFile file;
	
	private int studentId;
	
	private Date dueDate;
	
	private Timestamp createdDate;
	private Timestamp updatedDate;
	
	private int status;
	private int courseId;
	
}

package com.spring.model;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Upload {

	private int id;
	
	private byte[] uploadFile;
	private MultipartFile file;
	
	private int assignmentId;
	
	private Timestamp createdDate;
	
}

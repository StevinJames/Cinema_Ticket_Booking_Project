package com.spring.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.Data;

@Entity
@Table(name="admin")
@Data
public class Admin {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="username" , nullable = false , length = 50)
	private String userName;
	
	@Column(name="email" , nullable = false , length = 50)
	private String email;
	
	@Column(name="password" , nullable = false , length = 50)
	private String password;
	
	@Transient
	private String confirmPassword;
	
}

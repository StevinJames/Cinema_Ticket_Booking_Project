package com.spring.model;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Entity
@Table(name="teacher")
@Data
public class Teacher {

		@Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private int id;

	    @NotBlank(message = "Username is required")
	    @Size(max = 45, message = "Username must not exceed 45 characters")
	    @Column(name = "username", nullable = false, length = 45)
	    private String userName;

	    @NotBlank(message = "Email is required")
	    @Email(message = "Invalid email format")
	    @Column(name = "email", nullable = false, length = 45, unique = true)
	    private String email;

	    @NotBlank(message = "Password is required")
	    @Size(min = 6, max = 45, message = "Password must be between 6 and 45 characters")
	    @Column(name = "password", nullable = false, length = 45)
	    private String password;

	    @Transient
	    @NotBlank(message = "Confirm password is required")
	    private String confirmPassword;

	    @Column(name = "profile_photo")
	    private byte[] profilePhoto;

	    @Transient
	    private MultipartFile file;

	    @NotBlank(message = "Subject is required")
	    @Size(max = 45, message = "Subject must not exceed 45 characters")
	    @Column(name = "subject", nullable = false, length = 45)
	    private String subject;

	    @NotBlank(message = "Bio is required")
	    @Size(max = 1000, message = "Bio must not exceed 1000 characters")
	    @Column(name = "bio", nullable = false, length = 1000)
	    private String bio;

	    @NotBlank(message = "Gender is required")
	    @Column(name = "gender", nullable = false)
	    private String gender;

	    @NotBlank(message = "City is required")
	    @Size(max = 45, message = "City must not exceed 45 characters")
	    @Column(name = "city", nullable = false, length = 45)
	    private String city;

	    @NotBlank(message = "Phone number is required")
	    @Pattern(regexp = "^\\d{11}$", message = "Phone number must be exactly 11 digits")
	    @Column(name = "phone_number", nullable = false, length = 11)
	    private String phoneNumber;

	    @Column(name = "created_date", nullable = false, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP" , updatable = false)
	    private Timestamp createdDate;

	    @Column(name = "updated_date", nullable = true, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
	    private Timestamp updatedDate;

	    
	
}

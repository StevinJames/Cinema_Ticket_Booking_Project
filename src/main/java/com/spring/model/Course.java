package com.spring.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Null;
import lombok.Data;

@Entity
@Table(name="course")
@Data
public class Course {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="Teacher_id" , nullable = false)
	private Teacher teacher;
	
	
	@NotNull(message = "Please Enter a title.")
	@Column(name="title" , nullable = false)
	private String title;
	
	@Column(name="description" , nullable = false)
	private String description;
	
	@Column(name="is_deleted" , nullable = false , columnDefinition = "int default 0")
	private int isDeleted;
	
	@Column(name="is_approved" , nullable = false , columnDefinition = "int default 0")
	private int isApproved;
	
	
	@NotNull(message = "Please select a Photo.")
	@Column(name = "course_photo")
	private byte[] coursePhoto; 
	
	@Transient
	private MultipartFile file;
	
	@Column(name = "created_date", nullable = false, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP" , updatable = false)
	private Timestamp createdDate;

	@Column(name = "updated_date", nullable = true, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
	private Timestamp updatedDate;
	
	@ManyToMany(cascade = CascadeType.PERSIST )
    @JoinTable(
        name = "course_student",
        joinColumns = @JoinColumn(name = "student_id"),
        inverseJoinColumns = @JoinColumn(name = "course_id")
    )
    private List<Student> students;
	
	@Transient
    public String getStatus() {
        switch (isApproved) {
            case 0:
                return "Pending";
            case 1:
                return "Approved";
            case 2:
                return "Rejected";
            default:
                return "Unknown";
        }
	}
}

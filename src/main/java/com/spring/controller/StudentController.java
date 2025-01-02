package com.spring.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.model.Course;
import com.spring.model.Student;
import com.spring.repository.CourseRepository;
import com.spring.repository.StudentRepository;

@Controller
@RequestMapping("/student")
public class StudentController {

	@Autowired
	StudentRepository studentRepo;
	
	@Autowired
	CourseRepository courseRepo;
	
	@GetMapping("/enroll")
	public String enrollCourse(
	        @RequestParam("studentId") int studentId, 
	        @RequestParam("courseId") int courseId, 
	        HttpSession session, 
	        RedirectAttributes ra) {

	    // Check if student is logged in
	    Student student = (Student) session.getAttribute("student");
	    if (student == null) {
	        ra.addFlashAttribute("errorMessage", "You need to log in first.");
	        return "redirect:/student/login";
	    }

	    // Validate if the student exists
	    student = studentRepo.findStudentbyId(studentId);
	    if (student == null) {
	        ra.addFlashAttribute("errorMessage", "Student not found.");
	        return "redirect:/student/courseList";
	    }

	    // Validate if the course exists
	    Course course = courseRepo.findCoursebyId(courseId);
	    if (course == null) {
	        ra.addFlashAttribute("errorMessage", "Course not found.");
	        return "redirect:/student/courseList";
	    }

	    // Attempt to enroll the student in the course
	    try {
	        int result = courseRepo.enrollByStudentId(studentId, courseId);
	        if (result > 0) {
	            ra.addFlashAttribute("successMessage", "Successfully enrolled in the course!");
	        } else {
	            ra.addFlashAttribute("errorMessage", "Enrollment failed. Please try again.");
	        }
	    } catch (Exception e) {
	        ra.addFlashAttribute("errorMessage", "An error occurred during enrollment: " + e.getMessage());
	    }

	    return "redirect:/student/courseList";
	}

	
	@GetMapping("/courseList")
	public String courseList(HttpSession session , Model model) {
		Student student = (Student) session.getAttribute("student");
		
		if(student == null) {
			return "redirect:/student/login";
		}
		
		List<Course> course = courseRepo.approvedCourseList();
		model.addAttribute("courses" , course);
		model.addAttribute("student" , student);
		return "courseListStudent";
	}
	
//	@GetMapping("/updateProfilePhoto/{id}")
//	public String updateProfilePhotoPage(@PathVariable("id") int id, HttpSession session, Model model) {
//	    Student sessionStudent = (Student) session.getAttribute("student");
//
//	    if (sessionStudent == null) {
//	        return "redirect:/student/login";
//	    }
//
//	    Student student = studentRepo.findStudentbyId(id);
//	    if (student == null) {
//	        model.addAttribute("errorMessage", "Student not found.");
//	        return "redirect:/student/profile";
//	    }
//
//	    model.addAttribute("student", student);
//	    return "updateStudentProfilePhoto";
//	}

//	@PostMapping("/updatePfPhoto")
//	public String updateProfilePhoto(@ModelAttribute("student") @Validated Student student, 
//	                                 @RequestParam("file") MultipartFile profilePhoto, 
//	                                 Model model, HttpSession session) {
//	    Student sessionStudent = (Student) session.getAttribute("student");
//
//	    if (sessionStudent == null) {
//	        return "redirect:/student/login";
//	    }
//
//	    try {
//	        if (!profilePhoto.isEmpty()) {
//	            // Validate file type and size (optional)
//	            byte[] photoBytes = student.getFile().getBytes();
//	            student.setProfilePhoto(photoBytes);
//
//	            // Update profile photo in the database
//	            int result = studentRepo.updateProfilePhoto(student.getId(), student.getProfilePhoto());
//
//	            if (result == 1) {
//	                model.addAttribute("successMessage", "Profile photo updated successfully!");
//
//	                // Re-fetch the updated student object
//	                Student updatedStudent = studentRepo.findStudentbyId(student.getId());
//	                session.setAttribute("student", updatedStudent);
//
//	                return "redirect:/student/profile/" + student.getId();
//	            } else {
//	                model.addAttribute("errorMessage", "Error updating profile photo.");
//	            }
//	        } else {
//	            model.addAttribute("errorMessage", "Please upload a valid photo.");
//	        }
//	    } catch (Exception e) {
//	        model.addAttribute("errorMessage", "An error occurred while uploading the photo: " + e.getMessage());
//	        e.printStackTrace();
//	    }
//
//	    return "updateStudentProfilePhoto";
//	}

	
	@GetMapping("/editProfile/{id}")
	public String editProfile(@PathVariable("id")int id , HttpSession session , Model model) {
		Student student = (Student) session.getAttribute("student");
		
		if(student == null) {
			return "redirect:/student/login";
		}
		
		student = studentRepo.findStudentbyId(id);
		model.addAttribute("student" , student);
		return "updateStudent";
	}
	
	@PostMapping("/updateProfile")
	public String updateProfile(@ModelAttribute("student")@Validated Student student , @RequestParam("file") MultipartFile file , HttpSession session , Model model , RedirectAttributes redirectAttribute) {
		student = (Student) session.getAttribute("student");
		
		if(student == null) {
			return "redirect:/student/login";
		}
		
		// Handle the new poster file if uploaded
        if (!file.isEmpty()) {
            try {
                byte[] photoBytes = file.getBytes();  // Convert to byte[]
                student.setProfilePhoto(photoBytes);
            } catch (IOException e) {
                e.printStackTrace();
                redirectAttribute.addFlashAttribute("error", "Failed to upload poster!");
                return "redirect:/student/editProfile/" + student.getId();
            }
        }
		
		int i = studentRepo.updateProfile(student);
		
		if(i > 0) {
			redirectAttribute.addFlashAttribute("successMessage", "Profile Updated Successfully!"); 
			return "studentProfile";
		}
		else {
			model.addAttribute("errorMessage", "Course approving Failed , Please Try again!!");
			return "updateStudent";
		}
		
	}


	
	@GetMapping("/profile/{id}") 
	public String showProfile(HttpSession session , Model model) {
		Student student = (Student) session.getAttribute("student");
		
		if(student == null) {
			return "redirect:/student/login";
		}
		model.addAttribute("student" , student);
		return "studentProfile";
	}
	
	
	
	@GetMapping("/profilePhoto/{id}")
	public void getProfilephoto(@PathVariable("id")int id , HttpServletResponse response , HttpSession session) throws IOException {
		Student student = (Student) session.getAttribute("student");
		student = studentRepo.findStudentbyId(id);
		byte[] profilePhoto = student.getProfilePhoto();
		
		if (profilePhoto != null) {
            response.setContentType("image/png");
           try (ServletOutputStream out = response.getOutputStream()) {
                out.write(profilePhoto);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
        	System.out.println("Poster upload Error.");
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
		
	}
	
	@GetMapping("/registration")
	public ModelAndView registrationPage() {
		return new ModelAndView("studentRegistration", "studentRegisteration", new Student());
	}
	
	@PostMapping("/addStudent")
	public String addStudent(@ModelAttribute("studentRegisteration")@Validated Student student , @RequestParam("file")MultipartFile file , BindingResult br , Model model , RedirectAttributes redirectAttribute) throws IOException {
		if(student == null) {
			System.out.println("student is null");
		}
		
		
		if(student.getUserName() == null || student.getUserName().isEmpty()) {
			model.addAttribute("userNameError" , "userName is required!");
			System.out.println("not username");
			return "studentRegistration";
		}
		
		if(studentRepo.checkEmail(student.getEmail())) {
			model.addAttribute("emailExistsError" , "This email is already exists!");
			System.out.println("not emailexit");
			return "studentRegistration";
		}
		
		if(!student.getPassword().equals(student.getConfirmPassword())) {
			model.addAttribute("passwordError", "Passwords do not match.");
			System.out.println("not pasword no math");
			return"studentRegistration";
		}
		
		student.setCreatedDate(new Timestamp(System.currentTimeMillis()));
		student.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
		
		byte[] profilePhoto = student.getFile().getBytes();
		student.setProfilePhoto(profilePhoto);
		
		int i = studentRepo.addStudent(student);
		
		if(i > 0) {
			redirectAttribute.addFlashAttribute("successMessage", "Your account was registered successfully!"); 
			return "redirect:/student/login";
		}
		else {
			model.addAttribute("errorMessage", "Registration Failed , Please Tryagain!!");
			System.out.println("not success");
			return "studentRegistration";
		}	
		
		
	}
	
	@GetMapping("/login")
	public ModelAndView loginPage() {
		return new ModelAndView("studentLogin", "studentLogin", new Student());
	}
	
	@PostMapping("/loginStudent")
	public String loginStudent(@ModelAttribute("studentLogin")@Validated Student student , Model model , BindingResult br , HttpSession session) {
		
		if(br.hasErrors()) {
			System.out.println("Syntax Error");
			return "studentLogin";
		}
		
		
		
		if(!studentRepo.checkEmail(student.getEmail())) {
			model.addAttribute("emailNotRegisteredError" , "This email is not Registered!");
			return "studentLogin";
		}
		
		student = studentRepo.getStudentbyEmailandPassword(student.getEmail(), student.getPassword());
		
		if(student != null) {
			session.setAttribute("student", student);
			return "redirect:/student/courseList";
		}else {
			model.addAttribute("errorMessage" , "Invalid Email or Password.");
			return "studentLogin";
		}
		
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/student/login";
	}
	
	
}

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
import com.spring.model.Teacher;
import com.spring.repository.CourseRepository;
import com.spring.repository.TeacherRepository;

@Controller
@RequestMapping("/teacher")
public class TeacherController {
	
	@Autowired
	TeacherRepository teacherRepo;
	
	@Autowired
	CourseRepository courseRepo;
	
	@GetMapping("/RequestedcourseList")
	public String requestedCourselist(HttpSession session , Model model) {
		Teacher teacher = (Teacher) session.getAttribute("teacher");
		
		if(teacher == null) {
			return "redirect:/teacher/login";
		}
		
		List<Course> courses = courseRepo.showRequestedCoursebyTeacherId(teacher.getId());
		model.addAttribute("courses" , courses);
		return "requestedCourselistTeacher";
	}
	
	@GetMapping("/editProfile/{id}")
	public String editProfile(@PathVariable("id")int id , HttpSession session , Model model) {
		Teacher teacher = (Teacher) session.getAttribute("teacher");
		
		if(teacher == null) {
			return "redirect:/teacher/login";
		}
		model.addAttribute("teacher" , teacher);
		return "updateTeacher";
	}
	
	@PostMapping("/updateTeacher")
	public String updateTeacher(@ModelAttribute("teacher") @Validated Teacher teacher, 
	                            @RequestParam("file") MultipartFile file, 
	                            HttpSession session, 
	                            Model model, 
	                            RedirectAttributes redirectAttributes) {
	    Teacher loggedInTeacher = (Teacher) session.getAttribute("teacher");

	    if (loggedInTeacher == null) {
	        return "redirect:/teacher/login";
	    }

	    // Preserve the teacher ID and other unchanged fields
	    teacher.setId(loggedInTeacher.getId());

	    // Handle the new profile photo file if uploaded
	    if (!file.isEmpty()) {
	        try {
	            byte[] photoBytes = file.getBytes(); // Convert file to byte[]
	            teacher.setProfilePhoto(photoBytes);
	        } catch (IOException e) {
	            e.printStackTrace();
	            redirectAttributes.addFlashAttribute("error", "Failed to upload profile photo!");
	            return "redirect:/teacher/editProfile/" + loggedInTeacher.getId();
	        }
	    } else {
	        // Keep the existing profile photo if no new file is uploaded
	        teacher.setProfilePhoto(loggedInTeacher.getProfilePhoto());
	    }
	   

	    // Update the teacher'ss profile in the repository
	    int updateResult = teacherRepo.updateProfile(teacher);

	    if (updateResult > 0) {
	        redirectAttributes.addFlashAttribute("successMessage", "Profile updated successfully!");
	        return "redirect:/teacher/profile";
	    } else {
	        model.addAttribute("errorMessage", "Profile update failed. Please try again.");
	        return "updateTeacher";
	    }
	}

	
	@GetMapping("/profile/{id}") 
	public String showProfile(HttpSession session , Model model) {
		Teacher teacher = (Teacher) session.getAttribute("teacher");
		
		if(teacher == null) {
			return "redirect:/teacher/login";
		}
		model.addAttribute("teacher" , teacher);
		return "teacherProfile";
	}
	
	@GetMapping("/profilePhoto/{id}")
	public void getProfilephoto(@PathVariable("id")int id , HttpServletResponse response) throws IOException {
		Teacher teacher = teacherRepo.findTeacherbyId(id);
		byte[] profilePhoto = teacher.getProfilePhoto();
		
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
	
	@GetMapping("/courseList")
	public String courseList(HttpSession session , Model model) {
		Teacher teacher = (Teacher) session.getAttribute("teacher");
		
		if(teacher == null) {
			
			return"redirect:/teacher/login";
		}
		
		List<Course> course = courseRepo.approvedCourseList();
		model.addAttribute("courses" , course);
		model.addAttribute("teacher" , teacher);
		return "courseListTeacher";
	}
	

	
	@GetMapping("/registration")
	public ModelAndView registerationPage() {
		return new ModelAndView("teacherRegistration" , "teacherRegister" , new Teacher());
	}
	
	@PostMapping("/addTeacher")
	public String addTeacher(@ModelAttribute("teacherRegister") @Validated Teacher teacher , @RequestParam("file")MultipartFile file , BindingResult br , Model model , RedirectAttributes redirectAttribute) throws IOException {
		
		if(br.hasErrors()) {
			System.out.println("Error at Adding Teacher.");
			return "teacherRegistration";
		}
		
		if(teacherRepo.checkEmail(teacher.getEmail())) {
			model.addAttribute("emailExistsError" , "This email is already exists!");
			return "teacherRegistration";
		}
		
		if (!teacher.getPassword().equals(teacher.getConfirmPassword())) {
            model.addAttribute("passwordError", "Passwords do not match.");
            return "teacherRegistration";
        }
		
		teacher.setCreatedDate(new Timestamp(System.currentTimeMillis()));
		teacher.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
		
		byte[] profilePhoto = teacher.getFile().getBytes();
		teacher.setProfilePhoto(profilePhoto);
		
		try {
	        teacherRepo.addTeacher(teacher);  
	        redirectAttribute.addFlashAttribute("successMessage", "Your account was registered successfully!");  
	    } catch (Exception e) {
	        model.addAttribute("errorMessage", "Registration Failed , Please Tryagain!!");
	        System.out.println("errror : " + e.getMessage());
	        return "teacherRegistration";
	    }
		return "redirect:/teacher/login";
		      		
	}
	
	@GetMapping("/login")
	public ModelAndView loginPage() {
		return new ModelAndView("teacherLogin" , "teacherLogin" , new Teacher());
	}
	
	@PostMapping("/loginTeacher")
	public String loginTeacher(@ModelAttribute("teacherLogin") @Validated Teacher teacher, BindingResult br ,HttpSession session , Model model) {
		
		if(br.hasErrors()) {
			System.out.println("Syntax Error!");
			return "teacherLogin";
		}
		
		
		if(!teacherRepo.checkEmail(teacher.getEmail())) {
			model.addAttribute("emailNotRegisteredError" , "This email is not Registered!");
			return "teacherLogin";
		}
		
		teacher = teacherRepo.getTeacherbyEmailandPassword(teacher.getEmail(), teacher.getPassword());
		
		 if (teacher != null) {
            
         	 session.setAttribute("teacher", teacher);
         	 return "redirect:/teacher/courseList";

         } else {
             
             model.addAttribute("errorMessage", "Invalid email or password.");
            return "teacherLogin";
         }
     }
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/teacher/login";
	}
	
	
	
	
	
}

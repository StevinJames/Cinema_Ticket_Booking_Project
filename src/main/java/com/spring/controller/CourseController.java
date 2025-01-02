package com.spring.controller;

import java.io.IOException;
import java.sql.Timestamp;

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
import com.spring.model.Teacher;
import com.spring.repository.CourseRepository;

@Controller
@RequestMapping("/course")
public class CourseController {

	@Autowired
	CourseRepository courseRepo;
	
	@GetMapping("/approveCourse/{id}")
	public String approveCourse(@PathVariable("id")int id , Model model , HttpSession session , RedirectAttributes redirectAttribute) {
		Course course = (Course) session.getAttribute("course");
		course = courseRepo.findCoursebyId(id);
		int i = courseRepo.approveCourse(course);
		
		if(i > 0) {
			redirectAttribute.addFlashAttribute("successMessage", "Course Approved Successfully!"); 
			return "redirect:/admin/dashboard";
		}
		else {
			redirectAttribute.addFlashAttribute("errorMessage", "Course approving Failed , Please Try again!!");
			return "redirect:/admin/dashboard";
		}
		
	}
	
	@GetMapping("/rejectCourse/{id}")
	public String rejectCourse(@PathVariable("id")int id , Model model , HttpSession session , RedirectAttributes redirectAttribute) {
		Course course = (Course) session.getAttribute("course");
		course = courseRepo.findCoursebyId(id);
		int i = courseRepo.rejectCourse(course);
		
		if(i > 0) {
			redirectAttribute.addFlashAttribute("successMessage", "Course Rejected Successfully!"); 
			return "redirect:/admin/dashboard";
		}
		else {
			redirectAttribute.addFlashAttribute("errorMessage", "Course rejecting Failed , Please Try again!!");
			return "redirect:/admin/dashboard";
		}
	}
	
	
	
	
	@GetMapping("/Photo/{id}")
	public void getPhoto(@PathVariable("id")int id , HttpServletResponse response) throws IOException {
		Course course = courseRepo.findCoursebyId(id);
		byte[] coursePhoto = course.getCoursePhoto();
		
		if (coursePhoto != null) {
            response.setContentType("image/png");
           try (ServletOutputStream out = response.getOutputStream()) {
                out.write(coursePhoto);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
        	System.out.println("Course Photo upload Error.");
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
		
	}
	
	@GetMapping("/createCourse")
	public ModelAndView createCourse() {
		return new ModelAndView("addCourse" , "courseRegister" , new Course());
	}
	
	@PostMapping("/addCourse")
	public String addCourse(@ModelAttribute("courseRegister")@Validated Course course , HttpSession session , Model model , @RequestParam("file")MultipartFile file , BindingResult br , RedirectAttributes redirectAttribute) throws IOException {
		
		Teacher teacher = (Teacher) session.getAttribute("teacher");
		
		if(teacher == null) {
			return "redirect:/teacher/login";
		}
		
		if(br.hasErrors()) {
			System.out.println("Syntax Error at Adding Course!");
			return "addCourse";
		}
		
		course.setTeacher(teacher);
		
		byte[] coursePhoto = course.getFile().getBytes();
		course.setCoursePhoto(coursePhoto);
		
		course.setCreatedDate(new Timestamp(System.currentTimeMillis()));
		course.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
		
		
		int i = courseRepo.addCourse(course);
		
		if(i > 0) {
			model.addAttribute("successMessage", "Course Registered Successfully!"); 
			return "addCourse";
		}
		else {
			model.addAttribute("errorMessage", "Registration Failed , Please Tryagain!!");
			return "addCourse";
		}
		
	}
	
	 
	 
	 @GetMapping("/editCourse/{id}")
	 public String editCourse(@PathVariable("id") int id, Model model, HttpSession session) {
	     Teacher teacher = (Teacher) session.getAttribute("teacher");

	     // Check if teacher is logged in
	     if (teacher == null) {
	         return "redirect:/teacher/login";
	     }

	     // Retrieve course by id
	     Course course = courseRepo.findCoursebyId(id);
	     
	     if (course == null) {
	         model.addAttribute("errorMessage", "Course not found!");
	         return "redirect:/teacher/courseList";
	     }

	     model.addAttribute("course", course);
	     return "editCourse";
	 }

	 @PostMapping("/updateCourse")
	 public String updateCourse(@ModelAttribute("course") Course updatedCourse,
	                            @RequestParam("file") MultipartFile file,
	                            Model model,
	                            HttpSession session) {
	     Teacher teacher = (Teacher) session.getAttribute("teacher");

	     // Check if teacher is logged in
	     if (teacher == null) {
	         return "redirect:/teacher/login";
	     }

	     try {
	         // Retrieve the existing course by ID
	         Course existingCourse = courseRepo.findCoursebyId(updatedCourse.getId());

	         if (existingCourse == null) {
	             model.addAttribute("errorMessage", "Course not found for update.");
	             return "redirect:/teacher/courseList";
	         }

	         // Update course details
	         existingCourse.setTitle(updatedCourse.getTitle());
	         existingCourse.setDescription(updatedCourse.getDescription());

	         // Handle file upload if provided
	         if (!file.isEmpty()) {
	             existingCourse.setCoursePhoto(file.getBytes());
	         }

	         // Save the updated course
	         courseRepo.updateCourse(existingCourse);

	         session.setAttribute("course", existingCourse);
	         model.addAttribute("successMessage", "Course updated successfully.");
	         return "redirect:/teacher/courseList";
	     } catch (Exception e) {
	         model.addAttribute("errorMessage", "Error updating course: " + e.getMessage());
	         return "editCourse";
	     }
	 }


	 
	 
	
	@GetMapping("/cancelCourse/{id}")
	public String cancelCourse(@PathVariable("id")int id , HttpSession session , Model model , RedirectAttributes ra) {
		
		Teacher teacher = (Teacher) session.getAttribute("teacher");
		
		if(teacher == null) {
			return "redirect:/teacher/login";
		}
		
		Course course = (Course) session.getAttribute("course");
		course = courseRepo.findCoursebyId(id);
		
		int i = courseRepo.cancelCourse(course);
		
		if(i > 0) {
			ra.addFlashAttribute("successMessage", "Course Deleted Successfully!"); 
			return "redirect:/teacher/RequestedcourseList";
		}
		else {
			ra.addFlashAttribute("errorMessage", "Course deleting Failed , Please Tryagain!!");
			return "redirect:/teacher/RequestedcourseList";
		}
		
		
	}
	
	@GetMapping("/deleteCourse/{id}")
	public String deleteCourse(@PathVariable("id")int id , HttpSession session , Model model , RedirectAttributes ra) {
		
		Teacher teacher = (Teacher) session.getAttribute("teacher");
		
		if(teacher == null) {
			return "redirect:/teacher/login";
		}
		
		Course course = (Course) session.getAttribute("course");
		course = courseRepo.findCoursebyId(id);
		
		int i = courseRepo.cancelCourse(course);
		
		if(i > 0) {
			ra.addFlashAttribute("successMessage", "Course Deleted Successfully!"); 
			return "redirect:/teacher/courseList";
		}
		else {
			ra.addFlashAttribute("errorMessage", "Course deleting Failed , Please Tryagain!!");
			return "redirect:/teacher/courseList";
		}
		
	}
	
	
	
}

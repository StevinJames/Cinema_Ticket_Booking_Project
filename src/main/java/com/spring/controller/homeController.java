package com.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.spring.model.Course;
import com.spring.repository.CourseRepository;

@Controller
public class homeController {

	@Autowired
	CourseRepository courseRepo;
	
	@GetMapping("/")
	public String homePage(Model model) {
		
		List<Course> course = courseRepo.approvedCourseList();
		model.addAttribute("courses" , course);
		return "home";
	}
	
	@GetMapping("/defineRole") 
	public String defineRole() {
		return "defineRole";
	}
	
}

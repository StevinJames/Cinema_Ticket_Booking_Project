package com.spring.controller;

import java.util.List;

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
import org.springframework.web.servlet.ModelAndView;

import com.spring.model.Admin;
import com.spring.model.Course;
import com.spring.repository.AdminRepository;
import com.spring.repository.CourseRepository;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminRepository adminRepo;
	
	@Autowired
	CourseRepository courseRepo;
	
	@GetMapping("/dashboard")
	public String adminDashboard(HttpSession session , Model model) {
		Admin admin = (Admin) session.getAttribute("admin");
		
		if(admin == null) {
			return "redirect:/admin/login";
		}
		
		List<Course> course = courseRepo.showRequestedCourseListforAdmin();
		model.addAttribute("course" , course);
		return "adminDashboard";
		
	}
	
	@GetMapping("approvedCourselist")
	public String approvedCourses(HttpSession session , Model model) {
		Admin admin = (Admin) session.getAttribute("admin");
		
		if(admin == null) {
			return "redirect:/admin/login";
		}
		
		List<Course> course = courseRepo.approvedCourseList();
		model.addAttribute("approvedCourses" , course);
		return "approvedCourselist";
		
	}
	
	@GetMapping("/registration")
	public ModelAndView registrationPage() {
		return new ModelAndView("adminRegistration", "adminRegistration", new Admin());
	}
	
	@PostMapping("/addAdmin") 
	public String addAdmin(@ModelAttribute("adminRegistration")@Validated Admin admin , Model model , BindingResult br) {
		
		if(br.hasErrors()) {
			System.out.println("Syntax Error at Adding Admin.");
			return "adminRegistration";
		}
		
		if(!admin.getPassword().equals(admin.getConfirmPassword())) {
			model.addAttribute("passwordError", "Passwords do not match.");
			return "adminRegistration";
		}
		
		int i = adminRepo.addAdmin(admin);
		
		if(i > 0) {
			model.addAttribute("successMessage", "Your account was registered successfully!"); 
			return "redirect:/admin/login";
		}
		else {
			model.addAttribute("errorMessage", "Registration Failed , Please Tryagain!!");
			return "adminRegistration";
		}
		
	}
	
	@GetMapping("/login")
	public ModelAndView loginPage() {
		return new ModelAndView("adminLogin" , "adminLogin" , new Admin());
	}
	
	@PostMapping("/loginAdmin") 
	public String loginAdmin(@ModelAttribute("adminLogin")@Validated Admin admin , BindingResult br , HttpSession session , Model model ) {
		
		if(br.hasErrors()) {
			System.out.println("Syntax Error.");
			return "adminLogin";
		}
		
		if(!adminRepo.checkEmail(admin.getEmail())) {
			model.addAttribute("emailNotRegisteredError" , "This email is not Registered!");
			return "adminLogin";
		}
		
		admin = adminRepo.getAdminbyEmailandPassword(admin.getEmail(), admin.getPassword());
		
		if(admin != null) {
			session.setAttribute("admin", admin);
			return "redirect:/admin/dashboard";
		}else {
			model.addAttribute("errorMessage" , "Invalid Email or Password.");
			return "adminLogin";
		}
		
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/admin/login";
	}
	
}

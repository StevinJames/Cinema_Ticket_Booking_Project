package com.spring.controller;

import java.sql.Timestamp;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.model.Course;
import com.spring.model.Material;
import com.spring.model.Teacher;
import com.spring.repository.CourseRepository;
import com.spring.repository.MaterialRepository;

@Controller
@RequestMapping("/material")
public class MaterialController {
	
	@Autowired
	CourseRepository courseRepo;
	
	@Autowired
	MaterialRepository materialRepo;

	@GetMapping("/createMaterial/{id}")
	public String createMeterial(@PathVariable("id")int id , HttpSession session , Model model) {
		
		Teacher teacher = (Teacher) session.getAttribute("teacher");
		
		if(teacher == null) {
			return "redirect:/teacher/login";
		}
		
		Course course = (Course) session.getAttribute("course");
		course = courseRepo.findCoursebyId(id);
		System.out.println(course.getId());
		model.addAttribute("course", course);
	    model.addAttribute("teacher", teacher);
	    
	    Material material = new Material();
	    material.setCourse(course); 
	    model.addAttribute("material", material);
	    
	    return "addMaterial";
	}
	
	@PostMapping("/addMaterial")
	public String addMaterial(@ModelAttribute("material")@Validated Material material  , BindingResult br , Model model , HttpSession session , RedirectAttributes ra) {
		Teacher teacher = (Teacher) session.getAttribute("teacher");
		Course course = (Course) session.getAttribute("course");
		if(teacher == null) {
			return "redirect:/teacher/login";
		}
		
		if(br.hasErrors()) {
			System.out.println("Syntax Error at Adding Material!");
			return "addMaterial";
		}
		
		material.setCourse(course);
		
		material.setCreatedDate(new Timestamp(System.currentTimeMillis()));
		material.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
		
		int i = materialRepo.addMaterial(material);
		
		if(i > 0) {
			ra.addFlashAttribute("successMessage", "Material Added Successfully!"); 
			return "redirect:/teacher/courseList";
		}
		else {
			model.addAttribute("errorMessage", "Adding Material Failed , Please Tryagain!!");
			return "addMaterial";
		}
		
	}
	
}

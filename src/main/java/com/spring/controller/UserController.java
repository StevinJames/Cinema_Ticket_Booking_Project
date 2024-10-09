package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.spring.model.UserBean;
import com.spring.repository.UserRepository;

@Controller
@RequestMapping(value="/user")
public class UserController {

	@Autowired
	private UserRepository userRepo;
	
	@RequestMapping(value="/registerPage")
	public ModelAndView showRegister() {
		return new ModelAndView("register" , "userObj" , new UserBean());
	}
	@PostMapping(value = "/insertUser")
	public String insertUser(@ModelAttribute("userObj")UserBean user , Model model) {
		
		int i = userRepo.insertUser(user);
		
		if(i>0) {
			return "redirect:/";
		}
		else {
			model.addAttribute("error" , "An error occurred while creating the account. Please try again.");
			return "register";
		}
	}
	
	
	
}

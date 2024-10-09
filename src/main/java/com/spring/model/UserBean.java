package com.spring.model;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class UserBean {

	@NotNull
	private Integer id;
	@NotEmpty
	private String name;
	
	private String email;
	
	private String password;
	
	private String retypePassword;
	
}

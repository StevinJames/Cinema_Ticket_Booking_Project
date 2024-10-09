package com.spring.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.spring.model.UserBean;

public class UserRepository {

	public int insertUser(UserBean user) {
		
		int i = 0;
		
		Connection con = UserConnection.getConnection();
		
		try {
			PreparedStatement ps = con.prepareStatement("insert into user(name,email,password) values(?,?,?)");
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());
			
			i = ps.executeUpdate();
			System.out.println("User inserted successfully.");
			
		} catch (SQLException e) {
			System.out.println("User Insert Error : " + e.getMessage());
		}
		return i;
	}
	
}

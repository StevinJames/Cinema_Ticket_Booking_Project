package com.spring.repository;

import org.springframework.stereotype.Repository;

import com.spring.model.Admin;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

@Repository
public class AdminRepository {
	
	public int addAdmin(Admin admin) {
		int i = 0;
		EntityManager em = JPAUtil.getEntityManager();
		em.getTransaction().begin();
		em.persist(admin);
		em.getTransaction().commit();
		
		if(admin.getId() != 0) {
			i = 1;
		}
		else {
			System.out.println("Error at Adding Admin!");
			i = 0;
		}
		return i;
	}
	
	
	
	public boolean checkEmail(String email) {
		EntityManager em = JPAUtil.getEntityManager();
		Long count = (Long) em.createQuery("SELECT COUNT(a) FROM Admin a WHERE a.email = :email")
				.setParameter("email", email).getSingleResult();
		return count > 0;
	}
	
	public Admin getAdminbyEmailandPassword(String email , String password) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
		return em.createQuery("SELECT a FROM Admin a WHERE a.email = :email AND a.password = :password" , Admin.class)
				.setParameter("email", email).setParameter("password", password).getSingleResult();
		} catch (NoResultException e) {
			System.out.println("No Result Found!");
			return null;
		}
	}
	
}

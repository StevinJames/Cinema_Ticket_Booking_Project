package com.spring.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {

	static EntityManager em = null;
	
	public static EntityManager getEntityManager() {
		
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("M_Learning");
		
		em = emf.createEntityManager();
		
		return em;
		
	}
	
}

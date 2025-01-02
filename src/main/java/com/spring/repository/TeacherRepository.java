package com.spring.repository;


import org.springframework.stereotype.Repository;

import com.spring.model.Teacher;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

@Repository
public class TeacherRepository {

	
	public Teacher findTeacherbyId(int id) {
		EntityManager em = JPAUtil.getEntityManager();
		return em.find(Teacher.class, id);
	}
	
	public int addTeacher(Teacher teacher) {
		
		 int i = 0;
		 EntityManager em = JPAUtil.getEntityManager();
		 em.getTransaction().begin();
		 
		em.persist(teacher);
		
		em.getTransaction().commit();
		
		if (teacher.getId() != 0) {
             i = 1;
		}
		return i;
	}
	
	public boolean checkEmail(String email) {
		EntityManager em = JPAUtil.getEntityManager();
		Long count = (Long) em.createQuery("SELECT COUNT(t) FROM Teacher t where t.email = :email").setParameter("email", email).getSingleResult();
		return count > 0;
	}
	
	public Teacher getTeacherbyEmailandPassword(String email , String password) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
		return em.createQuery("SELECT t FROM Teacher t WHERE t.email =:email AND t.password =:password" , Teacher.class)
				.setParameter("email", email)
				.setParameter("password", password)
				.getSingleResult();
		} catch (NoResultException e) {
			System.out.println("No result Found!");
			return null;
		}
		
	}
	
	public int updateProfile(Teacher teacher) {
		int i = 0;
		EntityManager em = JPAUtil.getEntityManager();
		em.getTransaction().begin();
		try {
			
			em.merge(teacher);
			em.getTransaction().commit();
			i = 1;
		} catch (Exception e) {
            em.getTransaction().rollback();
            System.out.println("Updating Profile Error : " + e.getMessage());
            i = 0;
		}
		return i;
	}
	
}

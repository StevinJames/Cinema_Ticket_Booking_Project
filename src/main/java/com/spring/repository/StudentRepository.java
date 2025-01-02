package com.spring.repository;

import org.springframework.stereotype.Repository;

import com.spring.model.Student;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

@Repository
public class StudentRepository {

	public Student findStudentbyId(int id) {
		EntityManager em = JPAUtil.getEntityManager();
		return em.find(Student.class, id);
	}
	
	public int updateProfile(Student student) {
		int i = 0;
		EntityManager em = JPAUtil.getEntityManager();
		
		try {
			em.getTransaction().begin();
			em.merge(student);
			em.getTransaction().commit();
			i = 1;
		} catch (Exception e) {
            em.getTransaction().rollback();
            System.out.println("Updating Profile Error : " + e.getMessage());
            i = 0;
		}
		return i;
	}
	
	
	public int addStudent(Student student) {
		int i = 0;
		EntityManager em = JPAUtil.getEntityManager();
		em.getTransaction().begin();
		
		em.persist(student);
		 em.flush();
		em.getTransaction().commit();
		
		if(student.getId() != 0) {
			i = 1;
		} else {
			System.out.println("Error at Adding Student!");
			i = 0;
		}
		System.out.println(student);
		return i;
	}
	public boolean checkEmail(String email) {
		EntityManager em = JPAUtil.getEntityManager();
		Long count = (Long) em.createQuery("SELECT COUNT(s) FROM Student s WHERE s.email = :email").setParameter("email", email).getSingleResult();
		return count > 0;
	}
	
	public Student getStudentbyEmailandPassword(String email , String password) {
		EntityManager em = JPAUtil.getEntityManager();
		try {
		return em.createQuery("SELECT s FROM Student s WHERE s.email = :email AND s.password = :password", Student.class)
				.setParameter("email", email).setParameter("password", password).getSingleResult();
		} catch (NoResultException e) {
			System.out.println("No Result Found!");
			return null;
		}
	}
	
	
}

package com.spring.repository;

import org.springframework.stereotype.Repository;

import com.spring.model.Material;

import jakarta.persistence.EntityManager;

@Repository
public class MaterialRepository {

	public Material findMaterailbyId(int id) {
		EntityManager em = JPAUtil.getEntityManager();
		return em.find(Material.class, id);
	}
	
	public int addMaterial(Material material) {
		int i = 0;
		EntityManager em = JPAUtil.getEntityManager();
		try {
			em.getTransaction().begin();
			em.persist(material);
			em.getTransaction().commit();
			i = 1;
		} catch (Exception e) {
			
			System.out.println("Adding Material Error : " + e.getMessage());
			i = 0;
		}
		return i;
	}
	
}

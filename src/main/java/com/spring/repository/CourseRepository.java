package com.spring.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.model.Course;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

@Repository
public class CourseRepository {

	public Course findCoursebyId(int id) {
		EntityManager em = JPAUtil.getEntityManager();
		return em.find(Course.class, id);
	}
	
	public List<Course> showRequestedCourseListforAdmin() {
		EntityManager em = JPAUtil.getEntityManager();
		em.getTransaction().begin();
		@SuppressWarnings("unchecked")
		List<Course> courseList = em.createQuery("SELECT c FROM Course c WHERE c.isApproved = 0 AND c.isDeleted = 0").getResultList();
		em.getTransaction().commit();
		return courseList;
	}
	
	public List<Course> approvedCourseList() {
		EntityManager em = JPAUtil.getEntityManager();
		em.getTransaction().begin();
		@SuppressWarnings("unchecked")
		List<Course> courseList = em.createQuery("SELECT c FROM Course c WHERE c.isApproved = 1 AND c.isDeleted = 0").getResultList();
		em.getTransaction().commit();
		return courseList;
	}
	
	public int approveCourse(Course course) {
		int i = 0;
		EntityManager em = JPAUtil.getEntityManager();
		
		try {
		em.getTransaction().begin();
		course.setIsApproved(1);
		em.merge(course);
		em.getTransaction().commit();
		i = 1;
		} 
		catch (Exception e) {
			em.getTransaction().rollback();
			System.out.println("Approving course Error : " + e.getMessage());
			i = 0;
		}
		return i;
	}
	
	public int rejectCourse(Course course) {
		int i = 0;
		EntityManager em = JPAUtil.getEntityManager();
		
		try {
			em.getTransaction().begin();
			course.setIsApproved(2);
			em.merge(course);
			em.getTransaction().commit();
			i = 1;
		} catch (Exception e) {
			em.getTransaction().rollback();
			System.out.println("Rejecting course Error : " + e.getMessage());
			i = 0;
		}
		return i;
	}
	
	public int cancelCourse(Course course) {
		int i = 0;
		EntityManager em = JPAUtil.getEntityManager();
		
		try {
			em.getTransaction().begin();
			course.setIsDeleted(1);
			em.merge(course);
			em.getTransaction().commit();
			i = 1;
		} catch (Exception e) {
			em.getTransaction().rollback();
			System.out.println("Deleting course Error : " + e.getMessage());
			i = 0;
		}
		return i;
	}
	
	public List<Course> showRequestedCoursebyTeacherId(int id) {
		EntityManager em = JPAUtil.getEntityManager();
		em.getTransaction().begin();
		@SuppressWarnings("unchecked")
		List<Course> courseList = em.createQuery("SELECT c FROM Course c WHERE c.isApproved = 0 AND c.isDeleted = 0 AND c.teacher.id = :teacherId").setParameter("teacherId", id).getResultList();
		em.getTransaction().commit();
		return courseList;
	}
	
	public int addCourse(Course course) {
		
		int i = 0;
		EntityManager em = JPAUtil.getEntityManager();
		em.getTransaction().begin();
		em.persist(course);
		em.getTransaction().commit();
		
		if(course.getId() != 0) {
			i = 1;
		}
		return i;
	}
	
	public int updateCourse(Course course) {
		int i = 0;
		EntityManager em = JPAUtil.getEntityManager();
		try {
		em.getTransaction().begin();
		em.merge(course);
		em.getTransaction().commit();
		i = 1;
		} catch (Exception e){
			em.getTransaction().rollback();
			System.out.println("Updating course Error : " + e.getMessage());
			i = 0;
		}
		return i;
	}
	
	public int enrollByStudentId(int studentId, int courseId) {
	    int result = 0;
	    EntityManager em = JPAUtil.getEntityManager();

	    try {
	        em.getTransaction().begin();

	        // Enroll the student in the course
	        Query enrollQuery = em.createNativeQuery(
	            "INSERT INTO course_student(student_id, course_id) VALUES(:studentId, :courseId)"
	        );
	        enrollQuery.setParameter("studentId", studentId);
	        enrollQuery.setParameter("courseId", courseId);
	        result = enrollQuery.executeUpdate();

	        if (result > 0) {
	            // Get the teacher_id and title for the course
	            Query teacherQuery = em.createQuery(
	                "SELECT c.teacher.id, c.title FROM Course c WHERE c.id = :courseId"
	            );
	            teacherQuery.setParameter("courseId", courseId);

	            Object[] courseData = (Object[]) teacherQuery.getSingleResult();
	            if (courseData != null && courseData.length == 2) {
	                int teacherId = (Integer) courseData[0];
	                String courseTitle = (String) courseData[1];

	                // Create a notification for the teacher
	                Query notifyQuery = em.createNativeQuery(
	                    "INSERT INTO notification(teacher_id, message) VALUES(:teacherId, :message)"
	                );
	                notifyQuery.setParameter("teacherId", teacherId);
	                notifyQuery.setParameter("message", 
	                    "You got a new enrollment request for " + courseTitle);
	                notifyQuery.executeUpdate();
	            } else {
	                throw new IllegalStateException("Course data is incomplete.");
	            }
	        }

	        em.getTransaction().commit();
	    } catch (Exception e) {
	        if (em.getTransaction().isActive()) {
	            em.getTransaction().rollback();
	        }
	        System.err.println("Error in enrollByStudentId: " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        em.close();
	    }

	    return result;
	}



	
	
	
}

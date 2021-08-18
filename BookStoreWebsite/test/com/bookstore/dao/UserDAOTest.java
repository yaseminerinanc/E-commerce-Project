package com.bookstore.dao;

import static org.junit.Assert.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.PersistenceException;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import com.bookstore.entity.Users;

public class UserDAOTest {
	
	private static EntityManagerFactory entityManagerFactory;
	private static EntityManager entityManager;
	private static UserDAO userDAO;
	
	@BeforeClass
	public static void setUpClass() {
	
	EntityManagerFactory entityManagerFactory =Persistence.createEntityManagerFactory("BookStoreWebsite");
	EntityManager entityManager=entityManagerFactory.createEntityManager();
	
	userDAO= new UserDAO(entityManager);
	
	}

	@Test
	public void testCreateUsers() {
		
		Users user=new Users();
		user.setEmail("tommy@gmail.com");
		user.setFullName("tom");
		user.setPassword("12345");
		
		
		
		entityManager.getTransaction().begin();
		
		UserDAO userDao= new UserDAO(entityManager);
		user= userDao.create(user);
		
	
		
		assertTrue(user.getUserId()>0);
		

	}
	
	@Test(expected=PersistenceException.class)
	public void testCreateUsersFieldsNotSet() {
	
		Users user=new Users();
		
		user= userDAO.create(user);
	}
	
	@Test
	public void testUpdateUsers() {
		
		Users user=new Users();
		user.setUserId(1);
		user.setEmail("yasmin@mail.com");
		user.setFullName("yasmin");
		user.setPassword("mysecret");
		
		user =userDAO.update(user);
		String expected="mysecret";
		String actual=user.getPassword();
		
		assertEquals(expected,actual);
	
	}
	
	@AfterClass
	public static void tearDownClass() {
		
		entityManager.close();
		entityManagerFactory.close();
	}
	
	

}

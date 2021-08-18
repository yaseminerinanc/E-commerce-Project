package com.bookstore.service;

import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.UserDAO;
import com.bookstore.entity.Users;

public class UserServices {
	
	private UserDAO userDAO;
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	public UserServices(HttpServletRequest request,HttpServletResponse response ) {
		
		
		this.request=request;
		this.response=response;

		
		userDAO=new UserDAO();
		
	}
	
	public void listUser() throws ServletException, IOException {
		
		listUser(null);
	}
	
	public void listUser(String message) 
			throws ServletException, IOException {
		
		List<Users> listUsers=userDAO.listAll();
		request.setAttribute("listUsers",listUsers);
		
		if(message !=null ){
			
			request.setAttribute("message", message);
	}
		String listPage="user_listjsp.jsp";
		RequestDispatcher rd =request.getRequestDispatcher(listPage);
		rd.forward(request, response);

	}
	
	public void createUser() throws ServletException, IOException{
		
		String email=request.getParameter("email");
		String fullname=request.getParameter("fullname");
		String password=request.getParameter("password");
		
		Users exitUser=userDAO.findByEmail(email);
		if(exitUser != null) {
			
			String message="This" + " "+email +" " +" already exist.";
		
			request.setAttribute("message", message);
			RequestDispatcher rd =request.getRequestDispatcher("message.jsp");
			rd.forward(request, response);
		
		}else {
			Users newUsers = new Users(email,fullname,password);
			userDAO.create(newUsers);
			listUser("New user created successfully.");		
		}
		
	}

	public void editUser() throws ServletException, IOException {
		
		int userId=Integer.parseInt(request.getParameter("id"));
		Users user = userDAO.get(userId);
		
		String editPage="userform.jsp";
		request.setAttribute("user", user);
		
		RequestDispatcher rd= request.getRequestDispatcher(editPage);
		rd.forward(request, response);
	}

	public void updateUser() throws ServletException, IOException {
		
		int userId=Integer.parseInt(request.getParameter("userId"));
		String email=request.getParameter("email");
		String fullname=request.getParameter("fullname");
		String password = request.getParameter("password");
		
		Users userById=userDAO.get(userId);
		Users userByEmail=userDAO.findByEmail(email);
		
		if(userByEmail != null && userById.getUserId() != userByEmail.getUserId()) {
			
			String message="Could not update user.User with email " + email + "already exists.";
			request.setAttribute("message", message);
			RequestDispatcher rd= request.getRequestDispatcher("message.jsp");
			rd.forward(request,response);
			
		} else {
			
			Users user =new Users(userId,email,fullname,password);
			userDAO.update(user);
			
			String message="User has been updated successfull";
			listUser(message);			
		}
		
	}

	public void delete() throws ServletException, IOException {
		int userId=Integer.parseInt(request.getParameter("id"));
		userDAO.delete(userId);
		String message="User has been deleted successfull";
		listUser(message);	
	}
	
	public void login() throws ServletException, IOException {
		
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		
		boolean loginResult =userDAO.checkLogin(email,password);
		
		if(loginResult) {
			System.out.println("User is authenticated.");
			
			request.getSession().setAttribute("useremail", email);
			
			RequestDispatcher dispatcher= request.getRequestDispatcher("/admin/");
			dispatcher.forward(request, response);
			
			
		}else
		{
			
			String message= "Login failed.";
			
			request.setAttribute("message", message);
			RequestDispatcher dispatcher= request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		}
		
		
	}
	
	
	
	
}

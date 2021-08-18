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

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.CategoryDAO;
import com.bookstore.dao.UserDAO;
import com.bookstore.entity.Category;

public class CategoryServices {
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	private CategoryDAO categoryDAO;
	
	
	public CategoryServices(HttpServletRequest request, HttpServletResponse response) {
		

		this.request = request;
		this.response = response;
		
		categoryDAO= new CategoryDAO();
	}
	

	
	public void listCategory(String message) throws ServletException, IOException {
		
		List<Category> listCategory=categoryDAO.listAll();
		request.setAttribute("listCategory", listCategory);
		
		if(message !=null) {
		request.setAttribute("message", message);
		
		}
		
		String listPage="categorylist.jsp";
		RequestDispatcher rd =request.getRequestDispatcher(listPage);
		rd.forward(request, response);
		
		
	}
	
	public void listCategory()throws ServletException, IOException {
		
		listCategory(null);
		
	}

	public void createCategory() throws ServletException, IOException {
		
		String name =request.getParameter("categoryName");
		Category exitCategory =categoryDAO.findByName(name);
		
		if(exitCategory != null) {
			
			String message="Could not create category. A category with name"+" "+name +" "+ "already exist.";
			request.setAttribute("message", message);
			RequestDispatcher rd =request.getRequestDispatcher("message.jsp");
			rd.forward(request, response);
		}
		
		else {
			Category newCategory= new Category(name);
			categoryDAO.create(newCategory);
			String message = "New Category has been created successfully";
			listCategory(message);
		}
		
	}
	
	public void editCategory() throws ServletException, IOException {
		
		int categoryId= Integer.parseInt(request.getParameter("id"));
		Category category=categoryDAO.get(categoryId);
		request.setAttribute("category", category);
		
		String editPage="categoryform.jsp";
		RequestDispatcher rd =request.getRequestDispatcher(editPage);
		rd.forward(request, response);
	}



	public void updateCategory() throws ServletException, IOException {
		
		Integer categoryId=Integer.parseInt(request.getParameter("categoryId"));
		String categoryName=request.getParameter("categoryName");
		
	
		  Category categoryById= categoryDAO.get(categoryId); 
		  Category categoryByName=categoryDAO.findByName(categoryName);
		  
		  if(categoryByName != null && categoryById.getCategoryId() !=
		  categoryByName.getCategoryId()) { String
		  message="Could not update category.A category with name"+categoryName
		  +"already exists."; request.setAttribute("message", message);
		  
		  RequestDispatcher rd=request.getRequestDispatcher("message.jsp");
		  rd.forward(request, response); }
		  
		  else {
				Category updateCategory= new Category(categoryId,categoryName);
				categoryDAO.update(updateCategory);
				String message="Category has been updated successfully";
				listCategory(message);
		 
		  }
		
	}


	public void deleteCategory() throws ServletException, IOException {
		
		int categoryId=Integer.parseInt(request.getParameter("id"));
		
		BookDAO bookDAO =new BookDAO();
		long numberOfBooks=bookDAO.countByCategory(categoryId);
		String message;
		
		if(numberOfBooks > 0) {
			
			message="Could not delete the category (ID:%d) because it contains some books.";
			String.format(message, numberOfBooks);
		}else {
			
			categoryDAO.delete(categoryId);
			 message="Category has been deleted successfull";
		}
		
	
		listCategory(message);	
		
		
	}
}	
	

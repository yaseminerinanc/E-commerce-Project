package com.bookstore.controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.service.CategoryServices;




@WebServlet("/admin/createcategory")
public class CreateCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


    public CreateCategoryServlet() {
        
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		CategoryServices cs= new CategoryServices(request,response);
		cs.createCategory();
		
	}

}

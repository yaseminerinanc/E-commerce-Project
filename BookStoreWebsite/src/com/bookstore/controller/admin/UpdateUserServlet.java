package com.bookstore.controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.service.UserServices;


@WebServlet("/admin/updateuser")
public class UpdateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public UpdateUserServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
	
		UserServices userservices= new UserServices(request,response);
		userservices.updateUser();
	}

}

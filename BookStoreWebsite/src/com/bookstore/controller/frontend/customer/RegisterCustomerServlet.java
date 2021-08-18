package com.bookstore.controller.frontend.customer;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.service.CustomerServices;


@WebServlet("/registercustomer")
public class RegisterCustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public RegisterCustomerServlet() {
        super();
        
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		CustomerServices customerService =new CustomerServices(request, response);
		customerService.registerCustomer();
	}

}

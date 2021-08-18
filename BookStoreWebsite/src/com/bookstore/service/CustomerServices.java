package com.bookstore.service;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.CustomerDAO;

import com.bookstore.entity.Customer;

public class CustomerServices {
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	private CustomerDAO customerDAO;
	
	
	public CustomerServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
		customerDAO = new CustomerDAO();
	}
	
		public void listCustomer() throws ServletException, IOException{
		
			listCustomer(null);
	}

	public void listCustomer(String message) throws ServletException, IOException {
		
		if(message !=null) {	
		request.setAttribute("message", message);}
	
		List<Customer> listCustomers=customerDAO.listAll();
		request.setAttribute("listCustomers", listCustomers);
		
		String listPage="customerlist.jsp";
		RequestDispatcher rd =request.getRequestDispatcher(listPage);
		rd.forward(request, response);
	}



	public void createCustomer() throws ServletException, IOException {
		
		String email=request.getParameter("email");
		Customer customerByEmail= customerDAO.findByEmail(email);
		
		if(customerByEmail !=null) {
			
			String message="Could not create customer because this customer" + email + "already exists" ;
			listCustomer(message);
			return ;
		
	}else {
		
		Customer newCustomer= new Customer();
		updateCustomerFieldsFrom(newCustomer);
		
		customerDAO.create(newCustomer);
		
		String message= "A new customer create successfully.";	
		listCustomer(message);
	
	}
}

	public void editCustomer() throws ServletException, IOException {
		
		Integer customerId=Integer.parseInt(request.getParameter("id"));
		Customer customer = customerDAO.get(customerId);
		
		request.setAttribute("customer", customer);
		
		CommonUtility.generateCountryList(request);
		
		String editPage="customerform.jsp";
		RequestDispatcher rd= request.getRequestDispatcher(editPage);
		rd.forward(request, response);
	}

	public void updateCustomer() throws ServletException, IOException {
		Integer customerId=Integer.parseInt(request.getParameter("customerId"));
		String  email= request.getParameter("email");
		
		Customer customerByEmail=customerDAO.findByEmail(email);
		String message;
		
		if(customerByEmail!=null && customerByEmail.getCustomerId()!=customerId) {
			
			 message ="Could not update the customer ID" + customerId + 
					"there is customer  having same title.";
		} else {
			
			Customer customerById= new Customer();
		
			updateCustomerFieldsFrom(customerById);
			customerById.setRegisterDate(new Date());
			
			customerDAO.update(customerById);
			message="The customer has been updated successfully.";
			
		}
		
			listCustomer(message);
		
	}

	public void deleteCustomer() throws ServletException, IOException {
		Integer customerId=Integer.parseInt(request.getParameter("id"));
		customerDAO.delete(customerId);
		String message="Customer has been deleted successfull";
		listCustomer(message);	
		
	}

	public void registerCustomer() throws ServletException, IOException {
		
		String email=request.getParameter("email");
		Customer customerByEmail= customerDAO.findByEmail(email);
		String message= " ";
		
		if(customerByEmail !=null) {
			 message="Could not register this " + email + "already exists" ;
			
			return ;
		
	}else {
		Customer newCustomer= new Customer();
		updateCustomerFieldsFrom(newCustomer);
		customerDAO.create(newCustomer);
		
		 message= "You have registered successfully.<br/>"
		 		+ "You can login <a href='login'>Click here<a/> to login. ";
		
	}
		String messagePage="frontend/message.jsp";
		RequestDispatcher rd= request.getRequestDispatcher(messagePage);
		request.setAttribute("message", message);
		rd.forward(request, response);
	}

	public void updateCustomerFieldsFrom(Customer customer) {
		String email= request.getParameter("email");
		String firstname= request.getParameter("firstname");
		String lastname= request.getParameter("lastname");
		String password= request.getParameter("password");
		String addressLine1= request.getParameter("address1");
		String addressLine2= request.getParameter("address2");
		String phone= request.getParameter("phone");
		String city= request.getParameter("city");
		String state= request.getParameter("state");
		String country= request.getParameter("country");
	
		
		if(email != null && !email.equals("")){
			customer.setCustomerEmail(email);
		} 
		
		customer.setFirstname(firstname);
		customer.setLastname(lastname);
		
		if(password != null && !password.equals("")) {
			customer.setPassword(password);
		}
		
		customer.setAddressLine1(addressLine1);
		customer.setAddressLine2(addressLine2);
		customer.setPhone(phone);
		customer.setCity(city);
		customer.setState(state);
		customer.setCountry(country);
	
		
	}

	public void showLogin() throws ServletException, IOException {
		String loginForm ="frontend/login.jsp";
		RequestDispatcher dispatcher =request.getRequestDispatcher(loginForm);
		dispatcher.forward(request, response);
	}

	public void doLogin() throws ServletException, IOException {
		String email= request.getParameter("email");
		String password= request.getParameter("password");
		
		Customer customer=customerDAO.checkedLogin(email, password);
		
		if(customer==null) {
			String message="Login failed.Please check your email and password.";
			request.setAttribute("message",message);
			showLogin();
			
		}else {
			
			request.getSession().setAttribute("loggedCustomer", customer);
			showCustomerProfile();
			
		}
		
	}

	public void doLogout() throws IOException {
		request.getSession().removeAttribute("loggedCustomer");
		response.sendRedirect(request.getContextPath());
	
		
	}
	

	public void showCustomerProfile() throws IOException, ServletException {
		String customerProfile ="frontend/customerprofile.jsp";
		RequestDispatcher dispatcher =request.getRequestDispatcher(customerProfile);
		dispatcher.forward(request, response);
	
		
	}

	public void showCustomerProfileEditForm() throws ServletException, IOException {
		
		CommonUtility.generateCountryList(request);
		String editPage ="frontend/editprofile.jsp";
		RequestDispatcher dispatcher =request.getRequestDispatcher(editPage);
		dispatcher.forward(request, response);		
	}

	public void updateCustomerProfile() throws IOException, ServletException {
		
		Customer customer= (Customer) 	request.getSession().getAttribute("loggedCustomer");
		updateCustomerFieldsFrom(customer);
		customerDAO.update(customer);
		
		showCustomerProfile();
	}
	
	public void newCustomer() throws ServletException, IOException {
		
			CommonUtility.generateCountryList(request);
			String customerForm ="customerform.jsp";
			request.getRequestDispatcher(customerForm).forward(request, response);					
	}

	public void showCustomerRegistrationForm() throws ServletException, IOException {
		
		CommonUtility.generateCountryList(request);
		
		String registerForm ="frontend/registerform.jsp";
		RequestDispatcher dispatcher =request.getRequestDispatcher(registerForm);
		dispatcher.forward(request, response);
		
		
	}

}

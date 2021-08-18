package com.bookstore.controller.frontend;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;


@WebFilter("/*")
public class CustomerLoginFilter implements Filter {
	
	public static final String[] loginRequiredURLs= {"/viewprofile","/editprofile","/updateprofile",
			"/checkout","/placeorder","/vieworder","/showorderdetail"};

    
    public CustomerLoginFilter() {
    }

	
	public void destroy() {
	}

	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
			throws IOException, ServletException {
		
		HttpServletRequest httpRequest= (HttpServletRequest) request;
		HttpSession session =  httpRequest.getSession(false);
		
		String path=httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
		
		if(path.startsWith("/admin/")) {
			
			chain.doFilter(request, response);
			return;
		}
		
		boolean loggedIn =session != null && session.getAttribute("loggedCustomer") != null;
		
		if(!loggedIn && isLoginRequired(httpRequest.getRequestURL().toString()) ) {
			String loginPage="frontend/login.jsp";
			RequestDispatcher dispatcher =httpRequest.getRequestDispatcher(loginPage);
			dispatcher.forward(request,response);
		}
		else {
			chain.doFilter(request, response);
			
			}
			
	}
	
	private boolean isLoginRequired(String request) {
		
		for(String loginRequiredURL :loginRequiredURLs) {
			
			if(request.contains(loginRequiredURL)) {
				return true;
			}
		}
		
		return false;
	}

	
	public void init(FilterConfig fConfig) throws ServletException {
	}

}

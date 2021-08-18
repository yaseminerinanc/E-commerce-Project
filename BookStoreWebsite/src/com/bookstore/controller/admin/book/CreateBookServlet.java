package com.bookstore.controller.admin.book;


import com.bookstore.service.BookServices;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/admin/createbook")
@MultipartConfig(
		fileSizeThreshold=1024 * 10 , //10 KB
		maxFileSize = 1024 * 300 ,
		maxRequestSize = 1024 * 1024
		)
public class CreateBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

  
    public CreateBookServlet() {}
       

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			BookServices bookServices = new BookServices(request,response);
			bookServices.createBook();
	}

}

package com.bookstore.service;

import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.CategoryDAO;
import com.bookstore.entity.Book;
import com.bookstore.entity.Category;


public class BookServices {
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	private BookDAO bookDAO;
	private CategoryDAO categoryDAO;
	
	
	
	public BookServices( HttpServletRequest request, HttpServletResponse response) {
		super();
		
		this.request = request;
		this.response = response;
		bookDAO= new BookDAO();
		categoryDAO=new CategoryDAO();
	}
	
	public void listBooks() throws ServletException, IOException {
		
		listBooks(null);
	}


	public void listBooks(String message) throws ServletException, IOException {
		
		List<Book> listBooks=bookDAO.listAll();
		request.setAttribute("listBooks", listBooks);
		
		if(message != null) {
			
			request.setAttribute("message",message);
		}
		
		String listPage="booklist.jsp";
		RequestDispatcher rd =request.getRequestDispatcher(listPage);
		rd.forward(request, response);
		
	}
	
	public void showBookNewForm() throws ServletException, IOException {
		
		List<Category> listCategory=categoryDAO.listAll();
		request.setAttribute("listCategory", listCategory);
		
		String newPage="bookform.jsp";
		RequestDispatcher requestDispatcher =request.getRequestDispatcher(newPage);
		requestDispatcher.forward(request, response);
		
	}
	


	public void createBook() throws ServletException, IOException{
		
		
		String title=request.getParameter("title");
		
		Book exitsBook= bookDAO.findByTitle(title);
		
		if(exitsBook !=null) {
			
			String message="Could not create new book because this book" + title + "already exists" ;
			listBooks(message);
			return ;
			
		}
		
		Book newBook= new Book();
		readBookFields(newBook);
	
		Book createdBook =bookDAO.create(newBook);
		
		if(createdBook.getBookId() > 0) {
			String message= "A new book create successfully.";	
			listBooks(message);
		}
	}
	
	public void readBookFields(Book book) throws ServletException, IOException {
		
		String title= request.getParameter("title");
		String author=request.getParameter("author");
		String description=request.getParameter("description");
		String isbn=request.getParameter("isbn");
		float price= Float.parseFloat(request.getParameter("price"));
		
		DateFormat dateFormat= new SimpleDateFormat("MM/dd/yyyy");
		Date publishDate=null;
		
		try {
			 publishDate=dateFormat.parse(request.getParameter("publishDate"));
			
		}catch(ParseException ex){
			ex.printStackTrace();
			throw new ServletException("Error parse publish date- format is MM/dd/yyyy");
		}
	
		
		book.setTitle(title);
		book.setAuthor(author);
		book.setDescription(description);
		book.setIsbn(isbn);
		book.setPrice(price);
		book.setPublishDate(publishDate);
		
		Integer categoryId=Integer.parseInt(request.getParameter("category"));
		Category category =categoryDAO.get(categoryId);
		book.setCategory(category);
		
	
		Part part = request.getPart("bookImage");
		
		if(part !=null && part.getSize() > 0) {
			long size=part.getSize();
			byte[] imageBytes= new byte[(int) size];
			
			InputStream inputStream =part.getInputStream();
			inputStream.read(imageBytes);
			inputStream.close();
			
			book.setImage(imageBytes);
			
		}
		
		
	}

	public void editBook() throws ServletException, IOException {
		Integer bookId=Integer.parseInt(request.getParameter("id"));
		Book book=bookDAO.get(bookId);
		
		request.setAttribute("book", book);
		
		String editPage="bookform.jsp";
		RequestDispatcher requestDispatcher =request.getRequestDispatcher(editPage);
		requestDispatcher.forward(request, response);
	}

	public void updateBook() throws ServletException, IOException {
		
		Integer bookId=Integer.parseInt(request.getParameter("bookId"));
		String title=request.getParameter("title");
		Integer categoryId=Integer.parseInt(request.getParameter("category"));
		
		Book exitsBook =bookDAO.get(bookId);
		Book bookByTitle=bookDAO.findByTitle(title);
	
		if(bookByTitle!= null && !exitsBook.equals(bookByTitle)) {
			String message="Could not update book because there is another book having same title.";
			listBooks(message);
			return;

		}

		readBookFields(exitsBook);
		bookDAO.update(exitsBook);
		
		String message="The book has been updated successfully.";
		listBooks(message);
	}

	public void deleteBook() throws ServletException, IOException {
		int bookId=Integer.parseInt(request.getParameter("id"));
		bookDAO.delete(bookId);
		String message="Book has been deleted successfull";
		listBooks(message);	
		
	}

	public void listBooksByCategory() throws ServletException, IOException {
		int categoryId=Integer.parseInt(request.getParameter("id"));
		List<Book> listBooks=bookDAO.listByCategory(categoryId);
		Category category=categoryDAO.get(categoryId);
		List<Category> listCategory=categoryDAO.listAll();
		
		request.setAttribute("listCategory", listCategory);
		request.setAttribute("listBooks", listBooks);
		request.setAttribute("category", category);
		
		String listPage="frontend/booklistbycategory.jsp";
		RequestDispatcher requestDispatcher=request.getRequestDispatcher(listPage);
		requestDispatcher.forward(request, response);
		
	}

	public void viewBookDetail() throws ServletException, IOException {
		int bookId=Integer.parseInt(request.getParameter("id"));
		Book book = bookDAO.get(bookId);
		List<Category> listCategory=categoryDAO.listAll();
		
		request.setAttribute("listCategory", listCategory);
		request.setAttribute("book", book);
		
		String detailPage="frontend/bookdetail.jsp";
		RequestDispatcher requestDispatcher=request.getRequestDispatcher(detailPage);
		requestDispatcher.forward(request, response);
		
	}

	public void search() throws ServletException, IOException {
		String keyword =request.getParameter("keyword");
		List<Book> result=null;
		
		if(keyword.equals("")) {
			result=bookDAO.listAll();
		}else {
			
			result=bookDAO.search(keyword);
		}
		
		request.setAttribute("keyword", keyword);
		request.setAttribute("result", result);
		
		String searchPage="frontend/searchresult.jsp";
		RequestDispatcher requestDispatcher=request.getRequestDispatcher(searchPage);
		requestDispatcher.forward(request, response);
		
	}

}

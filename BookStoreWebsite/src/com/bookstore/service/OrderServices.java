package com.bookstore.service;

import java.io.IOException;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bookstore.controller.frontend.shoppingcart.ShoppingCart;
import com.bookstore.dao.OrderDAO;
import com.bookstore.entity.Book;
import com.bookstore.entity.BookOrder;
import com.bookstore.entity.Customer;
import com.bookstore.entity.OrderDetail;

public class OrderServices {
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	private OrderDAO orderDAO;
	
	public OrderServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
		this.orderDAO = new OrderDAO();
	}
	
	public void listAllOrder() throws ServletException, IOException {
		
		listAllOrder(null);
	}
	
	public void listAllOrder(String message) throws ServletException, IOException {
		
		if(message!=null) {
			
			request.setAttribute("message", message);
		}
		
		List<BookOrder> order=orderDAO.listAll();
		request.setAttribute("listorders", order);
		
		RequestDispatcher rd=request.getRequestDispatcher("orderlist.jsp");
		rd.forward(request, response);
	}


	public void viewOrderDetailForAdmin() throws ServletException, IOException {
		
		int orderId=Integer.parseInt(request.getParameter("id"));
		
		BookOrder order= orderDAO.get(orderId);
		request.setAttribute("order", order);
		
		String detailPage="orderdetail.jsp";
		RequestDispatcher rd=request.getRequestDispatcher(detailPage);
		rd.forward(request, response);	
	}


	public void showCheckoutForm() throws ServletException, IOException {
		String checkoutPage="frontend/checkout.jsp";
		RequestDispatcher rd=request.getRequestDispatcher(checkoutPage);
		rd.forward(request, response);	
		
	}


	public void placeOrder() throws ServletException, IOException {
		
		String recipientName= request.getParameter("recipientName");
		String recipientPhone= request.getParameter("recipientPhone");
		String address= request.getParameter("address");
		String city= request.getParameter("city");
		String country= request.getParameter("country");
		String paymentMethod= request.getParameter("paymentMethod");
		String shippingAddress= address + "," + city + "," + country;
		
		BookOrder order= new BookOrder();
		order.setRecipientName(recipientName);
		order.setRecipientPhone(recipientPhone);
		order.setAddressLine1(shippingAddress);
		order.setPaymentMethod(paymentMethod);
		
		HttpSession session =request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		order.setCustomer(customer);
		
		ShoppingCart shoppingCart = (ShoppingCart) session.getAttribute("cart");
		Map<Book, Integer> items =shoppingCart.getItems();
		
		Iterator<Book> iterator = items.keySet().iterator();
		
		Set<OrderDetail> orderDetails=new HashSet<>();
		
		while(iterator.hasNext()) {
			
			Book book =iterator.next();
			Integer quantity=items.get(book);
			float subtotal=(quantity * book.getPrice());
			
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setBook(book);
			orderDetail.setBookOrder(order);
			orderDetail.setQuantity(quantity);
			orderDetail.setSubtotal(subtotal);
			
			orderDetails.add(orderDetail);
		}
		
		order.setOrderDetails(orderDetails);
		order.setOrderTotal(shoppingCart.getTotalAmount());
		
		orderDAO.create(order);
		
		String message="Thank you.Your order has been received."+"We will deliver your books within a few days.";
		request.setAttribute("message", message);
		String messagePage="frontend/message.jsp";
		RequestDispatcher rd=request.getRequestDispatcher(messagePage);
		rd.forward(request, response);	
	}
	public void listOrderByCustomer() throws ServletException, IOException {
		HttpSession session=request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		List<BookOrder> listOrders= orderDAO.listByCustomer(customer.getCustomerId());
		
		request.setAttribute("listOrders", listOrders);
		
		String historyPage="frontend/orderlist.jsp";
		RequestDispatcher rd=request.getRequestDispatcher(historyPage);
		rd.forward(request, response);	
		
	}
	public void showOrderDetailForCustomer() throws ServletException, IOException {
		
		
		int orderId=Integer.parseInt(request.getParameter("id"));
		
		HttpSession session=request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		
		BookOrder order= orderDAO.get(orderId,customer.getCustomerId());
		request.setAttribute("order", order);
		
		String detailPage="frontend/orderdetail.jsp";
		RequestDispatcher rd=request.getRequestDispatcher(detailPage);
		rd.forward(request, response);
	}
	public void showEditOrderForm() throws ServletException, IOException {
			
		Integer orderId=Integer.parseInt(request.getParameter("id"));
		
		HttpSession session =request.getSession();
		
		  Object isPendingBook=session.getAttribute("NewBookPendingToAddToOrder");
		  
		  if(isPendingBook==null) {
		  
		  BookOrder bookOrder =orderDAO.get(orderId); 
		  session.setAttribute("order",bookOrder); 
		  }
		  else {
		  
		  session.removeAttribute("NewBookPendingToAddToOrder"); 
		  }
		  CommonUtility.generateCountryList(request);
		 
		String editPage="orderform.jsp";
		RequestDispatcher rd=request.getRequestDispatcher(editPage);
		rd.forward(request, response);
	}
	public void updateOrder() throws ServletException, IOException {
		HttpSession session = request.getSession();
		BookOrder order= (BookOrder) session.getAttribute("order");
		
		String recipientName= request.getParameter("recipientName");
		String recipientPhone= request.getParameter("recipientPhone");
		String shippingAddress= request.getParameter("shippingAddress");
		String paymentMethod= request.getParameter("paymentMethod");
		String orderStatus= request.getParameter("orderStatus");
		
		order.setRecipientName(recipientName);
		order.setRecipientPhone(recipientPhone);
		order.setAddressLine1(shippingAddress);
		order.setPaymentMethod(paymentMethod);
		order.setStatus(orderStatus);
		
		String[] arrayBookId=request.getParameterValues("bookId");
		String[] arrayPrice=request.getParameterValues("price");
		String[] arrayQuantity=new String[arrayBookId.length];
		
		for(int i = 1; i<=arrayQuantity.length; i++) {
			
			arrayQuantity[i-1]=request.getParameter("quantity" +i);
			System.out.println(arrayQuantity[i-1]);
			
		}
		
		Set<OrderDetail> orderDetails =order.getOrderDetails();
		orderDetails.clear();
		
		float totalAmount=0.0f;
		for(int i=0 ; i<arrayBookId.length;i++) {
			int bookId= Integer.parseInt(arrayBookId[i]);
			int quantity= Integer.parseInt(arrayQuantity[i]);
			float price = Float.parseFloat(arrayPrice[i]);
			
			float subtotal=price *quantity;
			
			OrderDetail orderDetail= new OrderDetail();
			orderDetail.setBook(new Book(bookId));
			orderDetail.setQuantity(quantity);
			orderDetail.setSubtotal(subtotal);
			orderDetail.setBookOrder(order);
			
			orderDetails.add(orderDetail);
			
			totalAmount +=subtotal;
		}
		
		order.setOrderTotal(totalAmount);
		
		orderDAO.update(order);
		
		String message= "The order" + order.getOrderId() + "has been updated.";
		
		listAllOrder(message);
	}

	public void deleteOrder() throws ServletException, IOException {
		Integer orderId= Integer.parseInt(request.getParameter("id"));
		orderDAO.delete(orderId);
		
		String messsage ="The order ID" + orderId + "has been deleted.";
		listAllOrder(messsage);
 		
	}


}

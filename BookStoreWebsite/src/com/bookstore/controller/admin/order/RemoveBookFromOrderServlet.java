package com.bookstore.controller.admin.order;

import java.io.IOException;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bookstore.entity.BookOrder;
import com.bookstore.entity.OrderDetail;


@WebServlet("/admin/removebookfromorder")
public class RemoveBookFromOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public RemoveBookFromOrderServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		Integer bookId=Integer.parseInt(request.getParameter("id"));
		HttpSession session =request.getSession();
		
		BookOrder order =(BookOrder) session.getAttribute("order");
		
		Set<OrderDetail> orderDetail =order.getOrderDetails();
		Iterator <OrderDetail> iterator =orderDetail.iterator();
		
		while(iterator.hasNext()) {
			
			OrderDetail orderDetails = iterator.next();
			if(orderDetails.getBook().getBookId()==bookId) {
				
				float newTotal=order.getOrderTotal() - orderDetails.getSubtotal();
				order.setOrderTotal(newTotal);
				iterator.remove();
			}
			
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("orderform.jsp");
		rd.forward(request, response);
	}

}

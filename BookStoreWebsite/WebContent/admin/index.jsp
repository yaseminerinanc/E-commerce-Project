<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta name="description" content="Books" charset="UTF-8">
<title>Bookstore Administration</title>
<link rel="icon" href="../images/007-book-1.png">
<link rel= "stylesheet" href="../css/style.css">
<link href="https://fonts.googleapis.com/css2?family=Merriweather:ital,wght@1,300&family=Sacramento&display=swap" rel="stylesheet">

</head>
<body>
		<jsp:directive.include file="header.jsp"/>
		
		<div align="center">
		<hr width="60%" >
		<h2>Administrative Dashboard</h2>
		</div>
		
		<div align="center">
		<h2>Quick Actions:</h2>
		<a href="newbook">New Book</a>
		<a href="userform.jsp">New User</a>
		<a href="categoryform.jsp">New Category</a>
		<a href="newcustomer">New Customer</a>
		
		</div>
		
		
		<div align="center">
		<hr width="60%" >
		<h2>Resent Sales Actions:</h2>	
		<table border= "1">
			<tr>
				<th>Order ID</th>
				<th>Ordered By</th>
				<th>Book Copies</th>
				<th>Total</th>
				<th>Payment Method</th>
				<th>Status</th>
				<th>Order Date</th>
			</tr>
			
			<c:forEach items="${listMostRecentSales}" var="order" varStatus=" status">
			
				<tr>
				<td><a href= " vieworder?id = ${order.orderId}" >${order.orderId}</a></td>
				
				<td>${order.customer.fullname}</td>
				<td>${order.bookCopies}</td>
				<td> <fmt:formatNumber value="${order.orderTotal}" type="currency"></fmt:formatNumber></td>
				<td>${order.paymentMethod}</td>
				<td>${order.status}</td>
				<td>${order.orderTime}</td>
				
				</tr>
			
			</c:forEach>
			
		</table>
		</div>
		
		<div align="center">
		<hr width="60%" >
		<h2>Resent Reviews:</h2>	
		</div>
		
		<div align="center">
		<hr width="60%" >
		<h2>Statistics:</h2>	
		Total Users:${totalUsers} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		Total Books:${totalBooks} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		Total Customers:${totalCustomers} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		Total Customers:${totalOrders} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<hr width="60%" >
		</div>

		<jsp:directive.include file="footer.jsp"/>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div align="center">
		<h2>Order OverView</h2>
			<table>
			<tr>
				<td><b>Ordered By:</b></td>
				<td>${order.customer.fullname}</td>
			</tr>
			
			<tr>
				<td>Shipping Status:</td>
				<td>${order.status}</td>
			</tr>

			<tr>
				<td>Shipping Date:</td>
				<td>${order.orderTime}</td>
			</tr>
			<tr>
				<td>Book Copies:</td>
				<td>${order.bookCopies}</td>
			</tr>
			
			<tr>
				<td>Payment Method:</td>
				<td>${order.paymentMethod}</td>
			</tr>
			<tr>
				<td>Total Amount:</td>
				<td><fmt:formatNumber value="${order.orderTotal}" type="currency"></fmt:formatNumber></td>
			</tr>
		</table>
		
		<h2>Recipient Information</h2>
		<table>
			<tr>
				<td>Recipient Name:</td>
				<td>${order.recipientName} " " ${order.recipientLastname} </td>
			</tr>
			<tr>
				<td>Recipient Phone:</td>
				<td>${order.recipientPhone}</td>
			</tr>
		
			<tr>
				<td>Shipping Address:</td>
				<td>${order.addressLine1} ${order.addressLine2}</td>
			</tr>
			<tr>
				<td>State</td>
				<td>${order.state}</td>
			</tr>
			<tr>
				<td>City</td>
				<td>${order.city}</td>
			</tr>
			<tr>
				<td>Country</td>
				<td>${order.country}</td>
			</tr>
		</table>
	</div>
	<br>

	<div align="center">
		<table border="1" cellpadding="5">
			<tr>
				<th>Index</th>
				<th>Book Title</th>
				<th>Book Author</th>
				<th>Price</th>
				<th>Quantity</th>
				<th>Sub Total</th>
			</tr>

			<c:forEach items="${order.orderDetails}" var="orderDetail"
				varStatus="status">
				<tr>
					<td>${status.index +1}</td>
					<td>${orderDetail.book.title}</td>
					<td>${orderDetail.book.author}</td>
					<td><fmt:formatNumber value="${orderDetail.book.price}"
							type="currency"></fmt:formatNumber></td>
					<td>${orderDetail.quantity}</td>
					<td><fmt:formatNumber value="${orderDetail.subtotal}"
							type="currency"></fmt:formatNumber></td>
				</tr>

			</c:forEach>

			<tr>
				<td colspan="6" align="right">
				
				<p>Sub Total: <fmt:formatNumber value="${order.subtotal}" type= "currency" /></p>
				<p>Tax: <fmt:formatNumber value="${order.tax}" type= "currency" /></p>
				<p>Shipping Fee: <fmt:formatNumber value="${order.shippingFee}" type= "currency" /></p>
				<p>TOTAL:<fmt:formatNumber value="${order.orderTotal}" type="currency" /></p>
			</tr>

		</table>
		</div>
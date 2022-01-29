<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div align="center">

		<table>

			<tr>
				<td>Shipping Status:</td>
				<td>${order.status}</td>
			</tr>

			<tr>
				<td>Shipping Date:</td>
				<td>${order.orderTime}</td>
			</tr>

			<tr>
				<td>Quantity</td>
				<td>${order.bookCopies}</td>
			</tr>
			<tr>
				<td>Total Amount:</td>
				<td><fmt:formatNumber value="${order.orderTotal}"
						type="currency"></fmt:formatNumber></td>
			</tr>
			<tr>
				<td>Recipient Name:</td>
				<td>${order.recipientName}</td>
			</tr>
			<tr>
				<td>Recipient Phone:</td>
				<td>${order.addressLine1}</td>
			</tr>
			<tr>
				<td>Payment Method:</td>
				<td>${order.paymentMethod}</td>
			</tr>


			<tr>
				<td>Ship to:</td>
				<td>${order.addressLine1}</td>
			</tr>
		</table>
	</div>
	<br>

	<div align="center">
		<table border="1" cellpadding="5">
			<tr>
				<th>No</th>
				<th>Book Title</th>
				<th>Book Author</th>
				<th>Price</th>
				<th>Quantity</th>
				<th>Subtotal</th>
			</tr>

			<c:forEach items="${order.orderDetails}" var="orderDetail" varStatus="status">
				<tr>
					<td>${status.index +1}</td>
					<td><img style="vertical-align: middle;"
						src="data:image/jpg;base64,${orderDetail.book.base64Image }"
						width="48" height="64" /> ${orderDetail.book.title}</td>
					<td>${orderDetail.book.author}</td>
					<td><fmt:formatNumber value="${orderDetail.book.price}"
							type="currency"></fmt:formatNumber></td>
					<td>${orderDetail.quantity}</td>
					<td><fmt:formatNumber value="${orderDetail.subtotal}"
							type="currency"></fmt:formatNumber></td>
				</tr>

			</c:forEach>

			<tr>
				<td colspan="4" align="right"><b><i>TOTAL:</i></b></td>
				<td><b>${order.bookCopies}</b></td>
				<td><b><fmt:formatNumber value="${order.orderTotal}" type="currency" /></b></td>
			</tr>

		</table>
	</div>
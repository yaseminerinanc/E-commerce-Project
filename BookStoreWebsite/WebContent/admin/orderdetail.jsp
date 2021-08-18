<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Details -Bookstore Administration</title>

<link rel="icon" href="../images/007-book-1.png">
<link rel= "stylesheet" href="../css/style.css">
<script type="text/javascript" src= "../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src= "../js/jquery.validate.min.js"></script>

</head>
<body>

  <jsp:directive.include file="header.jsp"/>

	

	<div align="center" >
		<hr width="60%" >
		<h2 >Details of Order ID: ${order.orderId}</h2>
	</div>

	<c:if test="${message!= null}">
		<div align="center">
			<h4>${message}</h4>
		</div>
	</c:if>

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
				<td><fmt:formatNumber value="${order.orderTotal}"
						type="currency"></fmt:formatNumber></td>
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
				<th>Subtotal</th>
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
				
				<p>Subtotal: <fmt:formatNumber value="${order.subtotal}" type= "currency" /></p>
				<p>Tax: <fmt:formatNumber value="${order.tax}" type= "currency" /></p>
				<p>Shipping Fee: <fmt:formatNumber value="${order.shippingFee}" type= "currency" /></p>
				<p>TOTAL:<fmt:formatNumber value="${order.orderTotal}"
							type="currency" /></p>
			</tr>

		</table>
	</div>
	<div align="center">
		<br /> <a href="">Delete this Order</a>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<a href="editorder?id=${order.orderId }">Edit this Order</a>

	</div>






	<jsp:directive.include file="footer.jsp" />



	<script type="text/javascript">
		
		$(document).ready(function (){
			
			$(".deleteLink").each(function(){
				$(this).on("click", function (){
					bookId=$(this).attr("id");
					if (confirm("Are you sure want to delete the book with ID" + bookId + " ?")){
						window.location= "deletebook?id=" + bookId;
					}		
				});
			});
		});
		
			/*function confirmDelete(userId){
				if (confirm("Are you sure wan to delete the user with ID" + userId + " ?")){
					window.location= "deleteuser?id=" +userId;
				}
			}*/
		</script>
</body>
</html>
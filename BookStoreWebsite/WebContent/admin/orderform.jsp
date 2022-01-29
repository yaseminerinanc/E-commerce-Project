<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Details -Bookstore Administration</title>

<link rel="icon" href="../images/007-book-1.png">
<link rel= "stylesheet" href="../css/style.css">
<script type="text/javascript" src= "js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src= "js/jquery.validate.min.js"></script>

</head>
<body>

  <jsp:directive.include file="header.jsp"/>

	

	<div align="center" >
		<hr width="60%" >
		<h2 >Edit Order ID: ${order.orderId}</h2>
	</div>

	<c:if test="${message!= null}">
		<div align="center">
			<h4>${message}</h4>
		</div>
	</c:if>
	
	<form action="updateorder" method="post" id="orderForm" >

	<div align="center">
			<table>
			<tr>
				<td><b>Ordered By:</b></td>
				<td>${order.customer.fullname}</td>
			</tr>
			<tr>
				<td>Order Date:</td>
				<td>${order.orderTime}</td>
			</tr>
			
				<tr>
				<td>Payment Method:</td>
				<td>
				
					<select name="paymentMethod">
					<option value= "Cash On Delivery" <c:if test="${order.paymentMethod eq Cash On Delivery}" >selected='selected' </c:if>>Cash on Delivery</option>
					<option value="PayPal" <c:if test= "${order.paymentMethod eq PayPal}">selected='selected'</c:if>>PayPal or Credit Card</option>
					</select></td>
			</tr>
			<tr>
				<td>Order Status:</td>
				<td>
					<select name= "orderStatus">
					<option value= "Processing"	<c:if test="${order.status eq 'Processing' }">selected='selected'</c:if>>Processing</option>
					<option value= "Shipping" 	<c:if test="${order.status eq 'Shipping' }">selected='selected'</c:if>>Shipping</option>
					<option value= "Delivered" 	<c:if test="${order.status eq 'Delivered' }">selected='selected'</c:if>>Delivered</option>
					<option value= "Completed" 	<c:if test="${order.status eq 'Completed' }">selected='selected'</c:if>>Completed</option>
					<option value= "Cancelled" 	<c:if test="${order.status eq 'Cancelled' }">selected='selected'</c:if>>Cancelled</option>
					
					</select>
				</td>
			</tr>
			</table>
			<h2>Recipient Information</h2>
			
			<table>
			
			<tr>
				<td>First Name:</td>
				<td><input type="text" name="recipientName" id ="recipientName" value="${order.recipientName}" size="45" required= "required"></input></td>
			</tr>
			
			<tr>
				<td>Last Name:</td>
				<td><input type="text" name="recipientLastname" id ="recipientLastname" value="${order.recipientLastname}" size="45" required= "required"></input></td>
			</tr>
			
			<tr>
				<td>Phone:</td>
				<td><input type="number" name="recipientPhone" id ="recipientPhone" value="${order.recipientPhone}" size="15" required= "required"></input></td>
			</tr>
			
			<tr>
				<td>Address Line 1</td>
				<td><input type="text" name="addressLine1" id ="addressLine1" value="${order.addressLine1}" size="45" required= "required"></input></td>
			</tr>
			
			<tr>
				<td>Address Line 2</td>
				<td><input type="text" name="addressLine2" id ="addressLine2" value="${order.addressLine2}" size="45" required= "required"></input></td>
			</tr>
			
			<tr>
				<td>City</td>
				<td><input type="text" name="city" id ="city" value="${order.city}" size="45" required= "required"></input></td>
			</tr>
			
				<tr>
				
				<td> <b>Country: </b> </td>
				<td>
					<select name="country" id="country" >
					<c:forEach items= "${mapCountries}" var="country">
					<option value="${country.value}"> <c:if test="${order.country} eq ${country.value}">selected="selected" </c:if>${country.key} </option>
					</c:forEach>
					</select>
				</td>
				</tr>
			
			</table>
	</div>
	<br>
	<div align="center">
		<table border="1" >
			<tr>
				<th>Index</th>
				<th>Book Title</th>
				<th>Book Author</th>
				<th>Price</th>
				<th>Quantity</th>
				<th>Subtotal</th>
				<th></th>
			</tr>

			<c:forEach items="${order.orderDetails}" var="orderDetail"
				varStatus="status">
				<tr>
					<td>${status.index +1}</td>
					<td>${orderDetail.book.title}</td>
					<td>${orderDetail.book.author}</td>
					<td>
							<input type="hidden"name="price" value= "${orderDetail.book.price}" />
							<fmt:formatNumber  value="${orderDetail.book.price}"
							type="currency"></fmt:formatNumber></td>
					<td>
					<input type="hidden"name="bookId" value= "${orderDetail.book.bookId}" />
					<input type="number"name="quantity${status.index +1}" value= "${orderDetail.quantity}" min="1" max="5" required="required" size= "5" />
					</td>
					<td><fmt:formatNumber value="${orderDetail.subtotal}"
							type="currency"></fmt:formatNumber></td>
					<td><a href= "removebookfromorder?id=${orderDetail.book.bookId}">Remove</a></td>
				</tr>

			</c:forEach>

			<tr>
				<td colspan="7" align="right">
					<p>Sub Total: <fmt:formatNumber value="${order.subtotal}" type= "currency" /></p>
					<p>Tax: <input type="number" size="5" name="tax" id="tax"  value="${order.tax}" required= "required" min=0/></p>
					<p>Shipping Fee: <input type="number" size="5" name="fee" id="fee" value="${order.shippingFee}" required= "required" min=0 /></p>
					<p>TOTAL:<fmt:formatNumber name="total" id= "total" value="${order.orderTotal}" type="currency" /></p>
				</td>	
				
			</tr>

		</table>
	</div>
	<div align="center">
		<br/> <a href="javascript:showAddBookPopup()"><b>Add Books</b></a>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type= "submit" value= "Save"> 
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type= "button" value= "Cancel" onclick= "javascript:window.location.href=/listorders"> 
	</div>
</form>

	<jsp:directive.include file="footer.jsp" />

	<script>
		function showAddBookPopup(){
			var width=500;
			var height=200;
			var left=(screen.width - width) /2
			var top=(screen.height - height) /2
			window.open('addbookform' ,'_blank','width=' + width +',height=' +height+',left=' +left + ',top='+top); 
		} 
			/*function confirmDelete(userId){
				if (confirm("Are you sure wan to delete the user with ID" + userId + " ?")){
					window.location= "deleteuser?id=" +userId;
				}
			}*/
	</script>
</body>
</html>
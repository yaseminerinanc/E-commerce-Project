<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Login</title>
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src= "js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src= "js/jquery.validate.min.js"></script>
<script type="text/javascript" src= "js/jquery-ui.min.js"></script>
</head>
<body>

	<jsp:directive.include file="header.jsp" />
	<div align="center">
		<h2>Shopping Cart Details</h2>
		<c:if test="${message!= null}">
			<div align="center">
				<h4>${message}</h4>
			</div>
		</c:if>

		<c:set var="cart" value="${sessionScope['cart'] }" />

		<c:if test="${cart.totalItems ==0 }">
			<h2>There is no items in your cart.</h2>
		</c:if>

		<c:if test="${cart.totalItems > 0 }">

			<form action="updatecart" method="post" id="cartform">
				<div>
					<table border="1">

						<tr>
							<th>No</th>
							<th colspan="2">Book</th>
							<th>Quantity</th>
							<th>Price</th>
							<th>SubTotal</th>
							<th></th>
						</tr>
						<c:forEach var="item" items="${cart.items}" varStatus="status">

							<tr>
								<td>${status.index +1}</td>
								<td><img
									src="data:image/jpg;base64,${item.key.base64Image }" width="84"
									height="110" /></td>

								<td style="font-size: x-large; font-weigh: bold">${item.key.title}</td>
								<td>
								<input type="hidden" name="bookId" value="${item.key.bookId}" >
								<input type="number" name="quantity${status.index + 1 }"
									value="${item.value}" size="5" min="1" max="5" required="required"></td>
								<td><fmt:formatNumber value="${item.key.price} "
										type="currency" /></td>
								<td><fmt:formatNumber
										value="${item.value * item.key.price} " type="currency" /></td>
								<td><a href="removefromcart?bookId=${item.key.bookId}">
										<b>Remove</b>
								</a></td>


							</tr>
						</c:forEach>

						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td>${cart.totalQuantity}book(s)</td>
							<td>Total:</td>
							<td colspan="2"><fmt:formatNumber
									value="${cart.totalAmount}" type="currency" /></td>
						</tr>

					</table>
				</div>
				<div>
					<table>
						<tr>
							<td></td>
							<td> <button type= "submit">Update</button></td>
							<td> <input type="button" id="clearCart" value= "Clear Cart"/></td>
							<td><a href="${pageContext.request.contextPath}/"><b>Continue Shopping</b></a></td>
							<td><a href="checkout"><b>Checkout</b></a></td>		
						</tr>
					</table>
				</div>
			</form>
	</c:if>
</div>
	<jsp:directive.include file="footer.jsp" />
	
	<script type="text/javascript">
	
	$(document).ready(function(){
		$("#clearCart").click(function(){
			window.location='clearcart';
			
		});
	});
	
</script>
</body>
</html>
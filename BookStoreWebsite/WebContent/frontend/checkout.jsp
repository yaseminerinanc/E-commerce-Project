<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout Online Book Store</title>
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
</head>
<body>

	<jsp:directive.include file="header.jsp" />
	<div align="center">
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
			<div>
				<h2>
					Review Your Order Details <a href="viewcart">Edit</a>
				</h2>
				<table border="1">

					<tr>
						<th>No</th>
						<th colspan="2">Book</th>
						<th>Author</th>
						<th>Price</th>
						<th>Quantity</th>
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
							<td>${item.key.author}</td>
							<td><fmt:formatNumber value="${item.key.price} "
									type="currency" /></td>
							<td><input type="number" name="quantity${status.index + 1 }"
								readonly="readonly" value="${item.value}" size="5" min="1"
								max="5" required="required"></td>

							<td><fmt:formatNumber
									value="${item.value * item.key.price} " type="currency" /></td>
						</tr>
					</c:forEach>

					<tr>
						<td colspan="7" align="right">
							<p>Number of copies: ${cart.totalQuantity}</p>
							<p>
								Sub Total:
								<fmt:formatNumber value="${cart.totalAmount}" type="currency" />
							</p>
							<p>
								Tax :
								<fmt:formatNumber value="${tax}" type="currency" />
							</p>
							<p>
								Shipping Fee:
								<fmt:formatNumber value="${fee}" type="currency" />
							</p>
							<p>
								TOTAL :
								<fmt:formatNumber value="${total}" type="currency" />
							</p>
						</td>
					</tr>

				</table>
				<h2>Recipient Information</h2>
				<form id="orderForm" action="placeorder" method="post">
					<table>

						<tr>
							<td>First Name:</td>
							<td><input type="text" name="firstname" required="required"
								value="${loggedCustomer.firstname}"></td>
						</tr>

						<tr>
							<td>Last Name:</td>
							<td><input type="text" name="lastname" required="required"
								value="${loggedCustomer.lastname}"></td>
						</tr>

						<tr>
							<td>Phone:</td>
							<td><input type="text" name="phone" required="required"
								value="${loggedCustomer.phone}"></td>
						</tr>

						<tr>
							<td>Address Line 1:</td>
							<td><input type="text" name="addressLine1" 
								required="required" value="${loggedCustomer.addressLine1}"></td>
						</tr>

						<tr>
							<td>Address Line 2:</td>
							<td><input type="text" name="addressLine2"
								required="required" value="${loggedCustomer.addressLine2}"></td>
						</tr>

						<tr>
							<td>City:</td>
							<td><input type="text" name="city" required="required"
								value="${loggedCustomer.city}"></td>
						</tr>

						<tr>
							<td>Country:</td>
							<td><select name="country" id="country">
									<c:forEach items="${mapCountries}" var="country">
										<option value="${country.value}">
											<c:if test="${loggedCustomer.country} eq ${country.value}">selected="selected" </c:if>${country.key}
										</option>
									</c:forEach>
							</select>
							</td>
						</tr>
					</table>

					<div>
						<h2>Payment</h2>
						Choose your payment method: &nbsp;&nbsp;&nbsp; 
						<select name="paymentMethod">
							<option value="Cash On Delivery">Cash On Delivery</option>
							<option value="paypal">PayPal or Credit Card</option>
						</select>
					</div>

					&nbsp;
					<div>
						<table>
							<tr>
								<td><button type="submit">Place Order</button></td>
								<td><a href="${pageContext.request.contextPath}/"><b>Continue
											Shopping</b></a></td>

							</tr>
						</table>
					</div>
				</form>
			</div>
		</c:if>
	</div>
	<jsp:directive.include file="footer.jsp" />

	<script type="text/javascript">
		$(document).ready(function() {
			$("#clearCart").click(function() {
				window.location = 'clearcart';

			});
		});
	</script>



</body>
</html>
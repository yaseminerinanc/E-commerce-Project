<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="#">
</head>
<body>

	<div align="center">

		<div>
		<a href="${pageContext.request.contextPath}/admin/" >
			<img src="images/x.png" />
			
			</a>
		</div>

		<div>
			Welcome, Admin | <a href="logout">Logout</a><br /> <br />
		</div>
		<div>
			<div id= "headermenu">
				<div >
					<a href="listusers"> <img alt="Users"
						src="../images/009-user-1.png"><br>Users
					</a> &nbsp;&nbsp;
				</div>


				<div>
					<a href="listcategory"> <img alt="Categories"
.						src="../images/006-list-1.png"><br>Categories
					</a> &nbsp;&nbsp;
				</div>

				<div >
					<a href="listbooks"><img alt="Books"
						src="../images/007-book-1.png"><br>Books </a>
				&nbsp;&nbsp;
				</div>

				<div>
					<a href="listcustomers"> <img alt="Customers"
						src="../images/customer.png"><br>Customers
					</a> &nbsp;&nbsp;
				</div>
				<div >
					<a href="reviews"> <img alt="CustomerReviews"
						src="../images/007-customer-review-1.png"><br>Customer
						Reviews
					</a> &nbsp;&nbsp;

				</div>

				<div>
					<a href="listorders"> <img alt="Orders"
						src="../images/008-order-1.png"><br>Orders
					</a> &nbsp;&nbsp;
				</div>

			</div>

		</div>
		</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Profile </title>
</head>
<body>

	<jsp:directive.include file="header.jsp" />
	
		<div align="center">
		<br/>
		<h2>Welcome, ${loggedCustomer.fullname}</h2>
		<br/>
		</div>
		
		<table style= "width:50% ; margin:0 auto; border:0">
				<tr>
					<td>Email Address:</td>
					<td>${loggedCustomer.customerEmail}</td>
				</tr>
				
				<tr>
					<td>Full Name:</td>
					<td>${loggedCustomer.firstname}</td>
				</tr>
				
					<tr>
					<td>Full Name:</td>
					<td>${loggedCustomer.lastname}</td>
				</tr>
				
				<tr>
					<td>Address1:</td>
					<td>${loggedCustomer.addressLine1}</td>
				</tr>
				
					<tr>
					<td>Address2:</td>
					<td>${loggedCustomer.addressLine2}</td>
				</tr>
				
				<tr>
					<td>State:</td>
					<td>${loggedCustomer.state}</td>
				</tr>
				
				<tr>
					<td>City:</td>
					<td>${loggedCustomer.city}</td>
				</tr>
				
				<tr>
					<td>Country:</td>
					<td>${loggedCustomer.countryName}</td>
				</tr>
				
				<tr>
					<td>&nbsp;</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
						<b><a href ="editprofile">Edit My Profile</a></b>
					</td>		
				</tr>
			</table>
	<jsp:directive.include file="footer.jsp" />
</body>
</html>
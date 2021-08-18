<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Customers -Bookstore Administration</title>
<link rel="icon" href="../images/007-book-1.png">
<link rel= "stylesheet" href="../css/style.css">
<script type="text/javascript" src= "../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src= "../js/jquery.validate.min.js"></script>
</head>
<body>
		<jsp:directive.include file="header.jsp"/>
		
		<div align="center">
		<hr width="60%" >
		<h2 class="pageheading" >Customer Management</h2>
		
		<h3><a href="newcustomer">Create New Customer</a></h3>
		
		</div>
		
		<c:if test="${message!= null}">
		<div align="center">
			<h4>${message}</h4>
		</div>
		</c:if>
		
		<div align="center">
		<table border="1" cellpadding="5">
		<tr>
		<th>Index</th>
		<th>ID</th>
		<th>Email</th>
		<th>First Name</th>
		<th>Last Name</th>
		<th>City</th>
		<th>Country</th>
		<th>Register Date</th>
		<th>Actions</th>
		</tr>
		<c:forEach var="customer" items="${listCustomers}" varStatus="status">
		
		<tr>
		<td>${status.index +1}</td>
		<td>${customer.customerId}</td>
		<td>${customer.customerEmail}</td>
		<td>${customer.firstname}</td>
		<td>${customer.lastname}</td>
		<td>${customer.city}</td>
		<td>${customer.country}</td>
		<td>${customer.registerDate}"</td>
		<td>	
		<a href="editcustomer?id=${customer.customerId} ">Edit</a>
		<a href="javascript:void(0);" class= "deleteLink" id= "${customer.customerId}">Delete</a>
		</td>
		</tr>
		</c:forEach>
		
		</table>
		
		</div>	
		<div align="center">
		
		</div>

		<jsp:directive.include file="footer.jsp"/>
		
		<script type="text/javascript">
		
		$(document).ready(function (){
			
			$(".deleteLink").each(function(){
				$(this).on("click", function (){
					customerId=$(this).attr("id");
					if (confirm("Are you sure want to delete the customer with ID" + customerId + " ?")){
						window.location= "deletecustomer?id=" + customerId;
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
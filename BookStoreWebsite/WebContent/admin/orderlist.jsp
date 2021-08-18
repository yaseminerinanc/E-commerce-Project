<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Orders -Bookstore Administration</title>
<link rel="icon" href="../images/007-book-1.png">
<link rel= "stylesheet" href="../css/style.css">
<script type="text/javascript" src= "../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src= "../js/jquery.validate.min.js"></script>
</head>
<body>
		<jsp:directive.include file="header.jsp"/>
		
		<div align="center">
		<hr width="60%" >
		<h2 class="pageheading" >Books Management</h2>
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
		<th>Order ID</th>
		<th>Ordered by</th>
		<th>Book Copies</th>
		<th>Total</th>
		<th>Payment Method</th>
		<th>Status</th>
		<th>Order Date</th>
		<th>Actions</th>
		</tr>
		<c:forEach var="order" items="${listorders}" varStatus="status">
		
		<tr>
		<td>${status.index +1}</td>
		<td>${order.orderId}</td>
		<td>${order.customer.fullname}</td>
		<td>${order.bookCopies}</td>
		<td> <fmt:formatNumber value="${order.orderTotal}" type="currency"></fmt:formatNumber></td>
		<td>${order.paymentMethod}</td>
		<td>${order.status}</td>
		<td>${order.orderTime}</td>
		<td>	
		<a href="vieworder?id=${order.orderId} ">Detail</a>&nbsp;
		<a href="editorder?id=${order.orderId} ">Edit</a>&nbsp;
		<a href="javascript:void(0);" class= "deleteLink" id= "${order.orderId}">Delete</a>
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
					orderId=$(this).attr("id");
					if (confirm("Are you sure want to delete the order with ID" + orderId + " ?")){
						window.location= "deleteorder?id=" + orderId;
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
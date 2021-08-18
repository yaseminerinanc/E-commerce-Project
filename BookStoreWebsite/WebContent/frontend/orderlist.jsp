<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Order History -Bookstore Administration</title>
<link rel="icon" href="../images/007-book-1.png">
<link rel= "stylesheet" href="../css/style.css">
<script type="text/javascript" src= "../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src= "../js/jquery.validate.min.js"></script>
</head>
<body>
		<jsp:directive.include file="header.jsp"/>
		
		<div align="center">
		<hr width="60%" >
		<h2 class="pageheading">My Order History</h2>
		</div>
		
		<c:if test="${fn:length(listOrders)==0 }">
		<div align="center">
		<h3>You have not placed any orders.</h3>
		</div>
		</c:if>
		
		<c:if test="${fn:length(listOrders) > 0 }">
		
		<div align="center">
		<table border="1" cellpadding="5">
		<tr>
		<th>Index</th>
		<th>Order ID</th>
		<th>Quantity</th>
		<th>Total Amount</th>
		<th>Order Date</th>
		<th>Status</th>
		<th>Actions</th>
		</tr>
		<c:forEach var="order" items="${listOrders}" varStatus="status">
		
		<tr>
		<td>${status.index +1}</td>
		<td>${order.orderId}</td>
		<td>${order.bookCopies}</td>
		<td> <fmt:formatNumber value="${order.orderTotal}" type="currency"></fmt:formatNumber></td>
		<td>${order.orderTime}</td>
		<td>${order.status}</td>
		
		<td>	
		<a href="showorderdetail?id=${order.orderId} ">View Detail</a>&nbsp;
		</td>
		</tr>
		</c:forEach>
		
		</table>
		
		</div>
		</c:if>	
		<div align="center">
		
		</div>

		<jsp:directive.include file="footer.jsp"/>
		
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
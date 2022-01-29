<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Order Details -Bookstore Administration</title>

<link rel="icon" href="../images/007-book-1.png">
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>

</head>
<body>

	<jsp:directive.include file="header.jsp" />


	<c:if test="${order==null }">
		<h2 align="center">Sorry, You are not authorized to view this order.</h2>
	</c:if>
	<c:if test="${order!=null }">
	
	<jsp:directive.include file="../common/commonorderdetail.jsp" />
		
	<div align="center">
		<hr width="60%">
		<h2>Details of Order ID: ${order.orderId}</h2>
	</div>


	
</c:if>	
	<!-- 	<div align="center">
		<br /> <a href="">Delete this Order</a>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<a href="">Edit this Order</a>

	</div>
 -->

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
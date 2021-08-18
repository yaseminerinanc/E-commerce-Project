<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create New Category</title>
<link rel="icon" href="../images/007-book-1.png">
<link rel= "stylesheet" href="../css/style.css">
<script type="text/javascript" src= "../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src= "../js/jquery.validate.min.js"></script>
</head>
<body>

	<jsp:directive.include file="header.jsp" />

	<div align="center">

		<h2>
			<c:if test="${category != null }">
				Edit Category
			</c:if>

			<c:if test="${category == null }">
			Create New Category		
			</c:if>
		</h2>
	</div>
	<div align="center">
	
		<c:if test="${category != null}">
				<form action="updatecategory" method="post" id= "categoryForm" >
				<input type= "hidden" name= "categoryId"  value= "${category.categoryId }">
		</c:if>
		
		<c:if test="${category ==null}">
		
			<form action="createcategory" method="post" id= "categoryForm">
		</c:if>
		
			<table class= "form">
				<tr>
					<td align="right">Name:</td>
					<td align="left"><input type="text" id="categoryName" name="categoryName" required="required"
						size="20" value="${category.categoryName}"/></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button type="submit">Save</button> 
						<button onclick="javascript:history.go(-1);">Cancel</button>
					</td>	
				</tr>
			</table>
		</form>	
	</div>

	<jsp:directive.include file="footer.jsp" />
</body>

<script type="text/javascript">
	
	$(document).ready(function()){
		
		$( "#categoryForm").validate({
			rules:{
				categoryName:"required";		
			},	
			messages:{			
				categoryName:"Please enter category name.";
				
			}
			
		});
	});
	
</script>


</html>
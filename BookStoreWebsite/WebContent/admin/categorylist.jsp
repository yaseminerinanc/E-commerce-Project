<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Categories -Bookstore Administration</title>
<link rel="icon" href="../images/007-book-1.png">
<link rel= "stylesheet" href="../css/style.css">
<script type="text/javascript" src= "../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src= "../js/jquery.validate.min.js"></script>
</head>
<body>
		<jsp:directive.include file="header.jsp"/>
		
		<div align="center">
		<hr width="60%" >
		<h2>Category Management</h2>
		<h3><a href="categoryform.jsp">Create New Category</a></h3>
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
		<th>Name</th>
		<th>Actions</th>
		</tr>
		<c:forEach var="category" items="${listCategory}" varStatus="status">
		
		<tr>
		<td>${status.index +1}</td>
		<td>${category.categoryId}</td>
		<td>${category.categoryName}</td>
		
		<td>	
		<a href="editcategory?id=${category.categoryId} ">Edit</a>
		<a href="javascript:void(0);" class= "deleteLink" id= "${category.categoryId }"
		
		>Delete</a>
		</td>
		</tr>
		</c:forEach>
		
		</table>
		
		</div>	
		<div align="center">
		
		</div>

		<jsp:directive.include file="footer.jsp"/>
		
		<script type="text/javascript">
		
		$(document).ready(function(){
			$(".deleteLink").each(function(){
				$(this).on("click", function(){
					categoryId=$(this).attr("id");
					if(confirm("Are you sure delete the category with" + categoryId + "?")){
						window.location="deletecategory?id=" +categoryId;
					
					}					
				});
	
			});
		});
		
		/*
			function confirmDelete(categoryId){
				
				if (confirm("Are you sure wan to delete the category with ID" + categoryId + " ?")){
					
					window.location= "deletecategory?id=" +categoryId;
				}
			}
		*/
		</script>
</body>
</html>
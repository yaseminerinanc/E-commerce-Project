<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Books -Bookstore Administration</title>
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
		
		<h3><a href="newbook">Create New Book</a></h3>
		
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
		<th>Image</th>
		<th>Title</th>
		<th>Author</th>
		<th>Category</th>
		<th>Price</th>
		<th>Last Updated</th>
		<th>Actions</th>
		</tr>
		<c:forEach var="book" items="${listBooks}" varStatus="status">
		
		<tr>
		<td>${status.index +1}</td>
		<td>${book.bookId}</td>
		<td>
		<img src="data:image/jpg;base64,${book.base64Image}" width="84" height="110" />
		</td>
		<td>${book.title}</td>
		<td>${book.author}</td>
		<td>${book.category.categoryName}</td>
		<td>$ ${book.price}</td>
		<td><fmt:formatDate pattern="MM/dd/yyyy" value= "${book.lastUpdated}"/>${book.lastUpdated}</td>
		<td>	
		<a href="editbook?id=${book.bookId} ">Edit</a>
		<a href="javascript:void(0);" class= "deleteLink" id= "${book.bookId}">Delete</a>
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
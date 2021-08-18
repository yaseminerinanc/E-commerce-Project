<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create New User</title>
<link rel="icon" href="../images/007-book-1.png">
<link rel= "stylesheet" href="../css/style.css">
<script type="text/javascript" src= "../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src= "../js/jquery.validate.min.js"></script>
</head>
<body>

	<jsp:directive.include file="header.jsp" />
	<div align="center">
		<h2 >
			<c:if test="${user != null }">
				Edit User
		</c:if>
			<c:if test="${user == null }">
			Create New User		
		</c:if>
		</h2>
	</div>
	
	<div align="center">
		<c:if test="${user != null }">
				<form action="updateuser" method="post" id= "userForm">
				<input type= "hidden" name= "userId"  value= "${user.userId }">
		</c:if>
		<c:if test="${user ==null }">
			<form action="createuser" method="post" id= "userForm">
		</c:if>
		
			<table class= "form">
				<tr>
					<td align="right">Email:</td>
					<td align="left"><input type="text" id="email" name="email" required="required"
						size="20" value="${user.email}"></input></td>
				</tr>
				<tr>
					<td align="right">Full Name:</td>
					<td align="left"><input type="text" id="fullname"
						name="fullname" size="20" value="${user.fullName }"/></td>
				</tr>
				<tr>
					<td align="right">Password:</td>
					<td align="left"><input type="password" id="password"
						name="password" size="20" value="${user.password }" required="required"/></td>
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
	
	$(document).ready(function(){
		
		$("#userForm").validate({
			rules:{
				
				email:{
					required:true,
					 email:true
					
				},
				
			
				fullname:"required",
				password:"required"
		
			},
			
			messages:{
				
			email:{ 
				
				required:"Please enter email", 
				email:"Please enter valid email address"
				},
			
			fullname:"Please enter fullname",
			password:"Please enter password "
				
			}
			
		});
	});
	
</script>

</html>
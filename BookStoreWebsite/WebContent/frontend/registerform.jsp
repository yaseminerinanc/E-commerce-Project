<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Customer</title>

<link rel="icon" href="../images/007-book-1.png">
<link rel= "stylesheet" href="../css/style.css">
<link  rel= "stylesheet" href= "../css/jquery-ui.min.css"></link>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="..//richtext.min.css">


<script type="text/javascript" src= "../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src= "../js/jquery.validate.min.js"></script>

<script type="text/javascript" src= "../js/jquery-ui.min.js"></script>
<script type="text/javascript" src= "../js/jquery.richtext.min.js"></script>
</head>
<body>

	<jsp:directive.include file="header.jsp" />
	
	<div align="center">
		<h2 >Register as a Customer</h2>
	</div>
	
	<div align="center">
	
		<form action="register" method="post" id= "customerForm">
		
		
		<table class= "form">
				<tr>
					<td align="right">Email:</td>
					<td align="left"><input type="email" id="email" name="email" required="required" 
						size="45" ></input></td>
				</tr>
				<tr>
					<td align="right">Full Name:</td>
					<td align="left"><input type="text" id="fullName" required="required" 
						name="fullName" size="45" /></td>
				</tr>				
					<tr>
					<td align="right">Password:</td>
					<td align="left"><input type="password" id="password" required="required" 
						name="password" size="45" /></td>
					</tr>	
					
					<tr>
					<td align="right">Confirm Password:</td>
					<td align="left"><input type="password" id="confirmPassword" required="required" 
						name="password" size="45" "/></td>
					</tr>			
					<tr>
					<td align="right">Phone Number:</td>
					<td align="left"><input type="text" id="phone" required="required" 
					name="phone" size="45" /></td>
					</tr>		
					<tr>
					<td align="right">Address:</td>
					<td align="left">
					<input type="text" id="address" name="address" size="45" required="required"  /> <br/>
					</td>
					</tr>
					
					<tr>
					<td align="right">City:</td>
					<td align="left"><input type="text" id="city" required="required" 
						name="city" size="45"  /></td>
					</tr>	
								
					<tr>
					<td align="right">Country:</td>
					<td align="left">
					
					<select name="country" id="country" >
						<c:forEach items= "${mapCountries}" var="country">
						<option value="${country.value}"> <c:if test="${customer.country} eq ${country.value}">selected="selected" </c:if>${country.key} </option>
						 </c:forEach>
					</select>
					
				

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
		
		$("#registerForm").validate({
			rules:{
				
				email:{
					
					required:true,
					email:true
				},
				fullName:"required",
				password:"required",
				confirmPassword:{ 
					
					required:true,
					equalTo:"#password"
				}
				,
				phone:"required",
				address:"required",
				city:"required",
				country:"required"
			},	
			messages:{
				
				email: {
					required:"Please enter e-mail address.",
					email:"Please enter valid address."
				},
				fullName:"required",
				password:"required",
				confirmPassword:{
					required:"Please confirm password.",
					equalTo:"Confirm password does not match password."
				},
				phone:"required",
				address:"required",
				city:"required",
				country:"required"	
			}
			
		});
	});
	
</script>

</html>
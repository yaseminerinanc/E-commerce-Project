<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>

<link rel="icon" href="../images/007-book-1.png">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/jquery-ui.min.css"></link>
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="..//richtext.min.css">


<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>

<script type="text/javascript" src="../js/jquery-ui.min.js"></script>
<script type="text/javascript" src="../js/jquery.richtext.min.js"></script>
</head>
<body>

	<jsp:directive.include file="header.jsp" />

	<div align="center">
		<h2>Edit Profile</h2>
	</div>

	<div align="center">

		<form action="updateprofile" method="post" id="c">


			<table class="form">
				<tr>
					<td align="right">Email:</td>
					<td align="left">${loggedCustomer.customerEmail}</td>
				</tr>
				
				<tr>
					<td align="right">First Name:</td>
					<td align="left"><input type="text" id="firstname" 
						name="firstname" size="45" value="${loggedCustomer.firstname}"/></td>
				</tr>	
				
				<tr>
					<td align="right">Last Name:</td>
					<td align="left"><input type="text" id="lastname" 
						name="lastname" size="45" value="${loggedCustomer.lastname}"/></td>
				</tr>	

				<tr>
					<td align="right">Phone Number:</td>
					<td align="left"><input type="text" id="phone"
						value="${loggedCustomer.phone }" name="phone" size="45" /></td>
				</tr>
				<tr>
					<td align="right">Address Line 1:</td>
					<td align="left">
					<input type="text" id="address1" name="address1" size="45" value="${loggedCustomer.addressLine1}"/> <br/>
				</td>
					
				<tr>
					<td align="right">Address Line 2:</td>
					<td align="left">
					<input type="text" id="address2" name="address2" size="45" value="${loggedCustomer.addressLine2}"/> <br/>
					</td>
					</tr>
					
				<tr>
					<td align="right">State:</td>
					<td align="left"><input type="text" id="state" 
						name="state" size="45" value="${loggedCustomer.state}" /></td>
				</tr>	
					

				<tr>
					<td align="right">City:</td>
					<td align="left"><input type="text" id="city"
						value="${loggedCustomer.city }" name="city" size="45" /></td>
				</tr>

				<tr>
					<td align="right">Country:</td>
					<td align="left">
						<select name="country" id="country" >
						<c:forEach items= "${mapCountries}" var="country">
						<option value="${country.value}"> <c:if test="${loggedCustomer.country} eq ${country.value}">selected="selected" </c:if>${country.key}</option>
						 </c:forEach>
					</select>
					</td>
				</tr>

				<tr>
					<td>&nbsp;</td>
				</tr>

				<tr>
					<td colspan="2" align="center"><i>Leave password fields
							blank if you do not want to change password</i></td>

				</tr>

				<tr>
					<td align="right">Password:</td>
					<td align="left"><input type="password" id="password"
						name="password" size="45" /></td>
				</tr>

				<tr>
					<td align="right">Confirm Password:</td>
					<td align="left"><input type="password" id="confirmPassword"
						name="password" size="45" /></td>
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
				confirmPassword:{ 
					
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
			
				confirmPassword:{
					
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create New Customer</title>

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
		<h2 >
		<c:if test="${customer != null }">
				Edit Customer
		</c:if>
		<c:if test="${customer == null }">
				Create New Customer		
		</c:if>
		</h2>
	</div>
	
	<div align="center">
		<c:if test="${customer != null }">
			<form action="updatecustomer" method="post" id= "customerForm">
				<input type= "hidden" name= "customerId"  value= "${customer.customerId}">
		</c:if>
		<c:if test="${customer ==null }">
			<form action="createcustomer" method="post" id= "customerForm">
		</c:if>
		
		<table class= "form">
				<tr>
					<td align="right">Email:</td>
					<td align="left"><input type="email" id="email" name="email" required="required" 
						size="45" value="${customer.customerEmail}"></input></td>
				</tr>
				<tr>
					<td align="right">First Name:</td>
					<td align="left"><input type="text" id="firstname" 
						name="firstname" size="45" value="${customer.firstname}"/></td>
				</tr>	
				
				<tr>
					<td align="right">Last Name:</td>
					<td align="left"><input type="text" id="lastname" 
						name="lastname" size="45" value="${customer.lastname}"/></td>
				</tr>			
					<tr>
					<td align="right">Password:</td>
					<td align="left"><input type="password" id="password" 
						name="password" size="45" value="${customer.password}"/></td>
					</tr>	
					
					<tr>
					<td align="right">Confirm Password:</td>
					<td align="left"><input type="password" id="confirmPassword" 
						name="password" size="45" value="${customer.password}"/></td>
					</tr>			
					<tr>
					<td align="right">Phone Number:</td>
					<td align="left"><input type="text" id="phone"
					name="phone" size="45" value="${customer.phone}"/></td>
					</tr>	
						
					<tr>
					<td align="right">Address Line 1:</td>
					<td align="left">
					<input type="text" id="address1" name="address1" size="45" value="${customer.addressLine1}" /> <br/>
					</td>
					
					<tr>
					<td align="right">Address Line 2:</td>
					<td align="left">
					<input type="text" id="address2" name="address2" size="45" value="${customer.addressLine2}" /> <br/>
					</td>
					</tr>
					
					<tr>
					<td align="right">State:</td>
					<td align="left"><input type="text" id="state" 
						name="state" size="45" value="${customer.state}" /></td>
					</tr>
					
					<tr>
					<td align="right">City:</td>
					<td align="left"><input type="text" id="city" 
						name="city" size="45" value="${customer.city}" /></td>
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
						<button type="submit">Save</button> &nbsp;&nbsp;&nbsp;
						<input type="button" value="Cancel" onclick="javascript:history.go(-1);">Cancel</input>
					</td>		
				</tr>
			</table>
		</form>
	</div>

	<jsp:directive.include file="footer.jsp" />
	
</body>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("#customerForm").validate({
			rules:{
				
				email:{
					
					required:true,
					email:true
				},
				firstname:"required",
				lastname:"required",
				password:"required",
				confirmPassword:{ 
					
					required:true,
					equalTo:"#password"
				}
				,
				phone:"required",
				address1:"required",
				address2:"required",
				state:"required",
				city:"required",
				country:"required"
			},	
			messages:{
				
				email: {
					required:"Please enter e-mail address.",
					email:"Please enter valid address."
				},
				firstname:"required",
				lastname:"required",
				password:"required",
				confirmPassword:{
					required:"Please confirm password.",
					equalTo:"Confirm password does not match password."
				},
				phone:"required",
				address1:"required",
				address2:"required",
				state:"required",
				city:"required",
				country:"required"	
			}
			
		});
	});
	
</script>

</html>
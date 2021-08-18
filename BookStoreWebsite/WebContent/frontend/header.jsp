<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div align="center">

	<h1>Header-Logo</h1>

	<div>
		<a href="${pageContext.request.contextPath}/" >
		<img src="images/x.png" />
		</a>
	</div>

	<div>
		<form action="search" method="get">
			<input type="text" name="keyword" size="50" /> 
			<input type="submit"value="Search" size="50" /> 
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
				<c:if test="${loggedCustomer != null }">
				<a href="viewprofile">Welcome,${loggedCustomer.fullname}</a> |
				<a href="vieworders">My Orders</a> | 
				<a href="logout">Logout</a> 
				
			</c:if>

			<c:if test="${loggedCustomer == null }">
				<a href="login">Sign In</a> |
				<a href="register">Register</a> 	
			</c:if>
			
			
			<a href="viewcart">Cart</a>
		</form>	
	</div>
	<div> &nbsp;</div>
	<div>
		<c:forEach var="category" items="${listCategory}" varStatus="status"> 
		
		<a href="viewcategory?id= ${category.categoryId }">
		<font size= "+1"> <b><c:out value= "${category.categoryName}"/></b></font>
		</a>	
		<c:if test ="${not status.last}">
		&nbsp; | &nbsp;
		</c:if>		
		</c:forEach>
	
	</div>

</div>
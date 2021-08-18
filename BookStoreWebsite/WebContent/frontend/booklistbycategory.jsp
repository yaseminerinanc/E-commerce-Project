<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Books in ${category.categoryName} Online Book Store</title>

<link rel="stylesheet" href="css/style.css">
</head>
<body>

	<jsp:directive.include file="header.jsp" />
	<div align="center"  >
		<h2>${category.categoryName}</h2>
	</div>

	<div align="center" width="80% " style= "margin:0 auto" >
		<c:forEach items="${listBooks }" var="book">
			<div style= "float:left; display:inline-block; margin:20px"  >
				<div>
				<a href ="viewbook?id=${book.bookId }" >
					<img src="data:image/jpg;base64,${book.base64Image }" width="128" height="164" />
				</a>
				</div>
				<div><b>${book.title}</b></div>
				<div>Rating *****</div>
				<div><i>by ${book.author}</i></div>
				<div>$ ${book.price} </div>
			</div>
		</c:forEach>
	</div>

	<jsp:directive.include file="footer.jsp" />

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${book.title}-OnlineBooksStore</title>
<link rel="stylesheet" href="css/style.css">

<script type="text/javascript" src= "js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src= "js/jquery.validate.min.js"></script>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	<div class="center">
		<table width="80%" style="border:0"  >
			<tr>
				<td colspan="3" align="left" height="10%">
					<h2>${book.title}</h2> by ${book.author}
				</td>
			</tr>
			<tr>
				<td rowspan="2"><img
					src="data:image/jpg;base64,${book.base64Image }" width="240"
					height="164" /></td>
				<td valign="top" align="left">
					<h2>***** Rating</h2>
				</td>

				<td valign="top" rowspan="2" width="20%">
				<h2>$ ${book.price}</h2>
				
				 <br /> <br/>
					<button id="buttonAddToCart" type="submit">Add to Cart</button>
				</td>
			</tr>
			<tr>
				<td valign="top" style="text-align:justify;" >${book.description }</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td>Customer Reviews</td>
				<td colspan= "2" align="center">
					<button >Write Customer Review</button>
				</td>
			</tr>
		</table>

	</div>

	<jsp:directive.include file="footer.jsp" />
	<script type= "text/javascript">
		$(document).ready(function(){
			$("#buttonAddToCart").click(function(){
				window.location = 'addtocart?bookId=' + ${book.bookId};
			});	
		});
	</script>

</body>
</html>
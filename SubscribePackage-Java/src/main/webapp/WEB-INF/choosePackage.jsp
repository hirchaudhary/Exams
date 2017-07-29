<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>Admin Dashboard!</title>
	<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
	<div class="container">
	<form method="POST" action="/logout">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<br>
			<input id="logout" type="submit" value="Logout" />
		</form>
	<h1>Welcome to Dojoscriptions Sammy!</h1>
	<h3>Please choose a subscription and start date</h3>
		<form action="/user/pack/add/${currentUser.id}" method="post">
			<label for="dueDate">Due Day:
				<select id="dueDate" name="dueDate">
					<c:forEach begin="1" end="31" var="i">
						<option value="${i}"> <c:out value="${i}" /> </option>
					</c:forEach>
				</select>
			</label>
			<label for="id">Package
				<select id="id" name="id">
					<c:forEach items="${packages}" var="pack">
					<c:if test = "${pack.availability == true}">
					<option value="${pack.id}"> ${pack.name} ($${pack.cost})</option>
					</c:if>
					</c:forEach>
				</select>
			</label>
			
			<input type="submit" value="Sign Up!"></input>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		</form>
		</div>
	</body>
</html>
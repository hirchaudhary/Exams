<%@page import="com.hiral.belt.services.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%> 

<!DOCTYPE HTML>
<html>
<head>
	<title>Admin Dashboard!</title>
	<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
	<div class="container">
	<h1>Admin Dashboard</h1>
		<form method="POST" action="/logout">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<br>
			<input id="logout" type="submit" value="Logout" />
		</form>
		<h2>Customers</h2>
		<table>
			<tr>
				<th>Name</th>
				<th>Next Due Date</th>
				<th>Amount Due</th>
				<th>Package Type</th>
			</tr>
			
			<c:forEach items="${allUsers}" var="user">
				<c:choose>
		            <c:when test="${!user.isAdmin()}">
						<tr>
							<td><a href="/user/edit/${user.id}">${user.firstName} ${user.lastName}</a></td>
							<td>${user.dueDate}</td>
							<td>${user.getPackages().getCost()}</td>
							<td>${user.getPackages().getName()}</td>
						</tr>
		            </c:when>             
		        </c:choose>
			</c:forEach>
		</table>
		
		<h2>Packages</h2>
		<table>
			<tr>
				<th>Package Name</th>
				<th>Package Cost</th>
				<th>Available</th>
				<th>Users</th>
				<th>Actions</th>
			</tr>
			
			<c:forEach items="${packages}" var="pack">
				<tr>
					<td>${pack.name}</td>
					<td>$${pack.cost}</td>
					<td>${pack.users.size()}</td>
					<c:choose>
		            	<c:when test="${pack.availability == true}">
							<td>Available</td>
							<td><a href="package/update/${pack.id}">deactivate</a>
							<c:if test = "${pack.users.size() == 0}">
						        <a href="package/delete/${pack.id}">Delete</a>
						    </c:if>
							</td>
			            </c:when>
			           	<c:otherwise>
                			<td>Unavailable</td>
                			<td><a href="package/update/${pack.id}">activate</a>
                			<c:if test = "${pack.users.size() == 0}">
						        <a href="package/delete/${pack.id}">Delete</a>
						    </c:if>
                			</td>    
            			</c:otherwise>         
			        </c:choose>
				</tr>
			</c:forEach>
		</table>
		
		<h3>Create new Package</h3>
		<form:form method="POST" action="/package/add" modelAttribute="package">
			<p>
	            <form:label path="name">Package Name:</form:label>
	            <form:input path="name"/><form:errors path="name"/>
	        </p>
	        <p>
	            <form:label path="cost">Cost:</form:label>
	            <form:input path="cost"/><form:errors path="cost"/>
	        </p>
	        <input type="submit" value="Create Guild"/>
		</form:form>

	</div>
</body>
</html>
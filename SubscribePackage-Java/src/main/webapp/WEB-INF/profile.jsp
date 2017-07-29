<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome Page</title>
</head>
<body>
    <h1>Welcome <c:out value="${currentUser.firstName}"></c:out></h1>
    <a href="editMe/${currentUser.id}">Edit Profile</a>
    <form id="logoutForm" method="POST" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="submit" value="Logout!" />
    </form><br>
    <div style="border:2px solid black; width:400px; padding:20px">
    	<strong>Current Package: </strong>${currentUser.packages.name}<br>
    	<strong>Next Due Date: </strong><fmt:formatDate pattern = "MMMM dd'th' yyyy" value = "${currentUser.dueDate}" /><br>
    	<strong>Amount Due: </strong>${currentUser.packages.cost}<br>
    	<strong>User Since: </strong><fmt:formatDate pattern = "MMMM dd'th' yyyy" value = "${currentUser.createdAt}" /><br>
    </div>
</body>
</html>
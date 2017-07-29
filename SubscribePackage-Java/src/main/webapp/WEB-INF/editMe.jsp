<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome Page</title>
</head>
<body>
    <h1>Welcome <c:out value="${currentUser.firstName}"></c:out></h1>
    <form id="logoutForm" method="POST" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="submit" value="Logout!" />
    </form><br>

    <form:form method="POST" action="/editMe/${user.id}" modelAttribute="user">
        <p>
            <form:label path="firstName">First Name:</form:label>
            <form:input path="firstName"/><form:errors path="firstName"/>
        </p>
        <p>
            <form:label path="lastName">Last Name:</form:label>
            <form:input path="lastName"/><form:errors path="lastName"/>
        </p>
        <p>
            <form:label path="username">Username:</form:label>
            <form:input path="username"/><form:errors path="username"/>
        </p>
        <p>
            <form:label path="email">Email address:</form:label>
            <form:input path="email"/><form:errors path="email"/>
        </p>
        <form:hidden path="createdAt" value="${currentUser.createdAt}"/>
	    <form:hidden path="password" value="${currentUser.password}"/>
   		<label for="packages">Package
			<select id="packages" name="packages">
				<c:forEach items="${packages}" var="pack">
				<c:if test = "${pack.availability == true}">
				<option value="${pack.id}"> ${pack.name} ($${pack.cost})</option>
				</c:if>
				</c:forEach>
			</select>
		</label>
	    <input type="submit" value="Submit"/>
	</form:form>
	<c:if test="${error != null}">
			<c:out value="${error}"></c:out>
	</c:if>
</body>
</html>
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
    <p>Email:   		${user.email}</p>
    <p>Customer Since:    <fmt:formatDate pattern = "MMMM dd'th' yyyy" value = "${user.createdAt}" /></p>
    <form:form method="POST" action="/user/edit/${id}" modelAttribute="user">
	    <form:label path="firstName">First Name
	    <form:input path="firstName"/>
	    <form:errors path="firstName"/>
	    </form:label><br>
	    <form:label path="lastName">Last Name
	    <form:input path="lastName"/>
	    <form:errors path="lastName"/>
	    </form:label><br>
	    <form:hidden path="createdAt" value="${user.createdAt}"/>
	    <form:hidden path="password" value="${user.password}"/>
	    <form:hidden path="email" value="${user.email}"/>
	    <form:hidden path="username" value="${user.username}"/>
	    
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
</body>
</html>
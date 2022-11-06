<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<c:if test="${param.error != null}">
    <i style="color: red">Invalid login or password</i>
</c:if>
<form:form method="post">
    Username: <input type="text" name="username"> <!-- name must be exact as "username" -->
    <br/>
    Password: <input type="password" name="password"> <!-- name must be exact as "password" -->
    <br/>
    <input type="submit" value="Login">

</form:form>
</body>
</html>

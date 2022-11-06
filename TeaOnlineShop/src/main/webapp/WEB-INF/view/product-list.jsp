<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf8" pageEncoding="UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>List of Products</title>
    <link rel="stylesheet" type="text/css" href="/TeaOnlineShop/resources/css/product-list.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
</head>
<body>

<div class="container">
    <div align="center">
        <h1 class="myFonts">NotkaTea</h1>
        <!-- main image-->
        <img src="/TeaOnlineShop/resources/images/mainImage.jpg" alt="TeaImage">
        <form:form action="logout" method="post">
            <input type="submit" value="Logout">
        </form:form>
    </div>
    <br/>
    <!-- button for adding product-->
    <form action="${pageContext.request.contextPath}/admin/addProduct">
        <input type="submit" value="Add product" class="btn btn-primary">
    </form>

    <table border="1" class="table table-striped table-hover">
        <thead>
        <tr>
            <td>id</td>
            <td align="center">name</td>
            <td align="center">description</td>
            <td align="center">price</td>
            <td align="center">Update</td>
            <td align="center">Delete</td>
        </tr>
        </thead>
        <c:forEach var="product" items="${products}">
            <tr>
                <td>${product.id}</td>
                <td>${product.name}</td>
                <td>${product.description}</td>
                <td>${product.price}</td>
                <td><a href="${pageContext.request.contextPath}/admin/updateProduct?productId=${product.id}">Update
                    product</a></td>
                <td><a href="${pageContext.request.contextPath}/admin/deleteProduct?productId=${product.id}"
                       onclick="if(!confirm('Are you sure you want to delete this item?')) return false">Delete
                    product</a></td>
            </tr>
        </c:forEach>
    </table>
</div>


</body>
</html>

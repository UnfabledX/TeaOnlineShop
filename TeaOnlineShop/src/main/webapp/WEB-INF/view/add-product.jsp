<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="textarea" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
    <link rel="stylesheet" type="text/css" href="/TeaOnlineShop/resources/css/add-product.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <h1>Add Product</h1>
    <form:form action="saveButton" modelAttribute="product" method="post" >
        <div class="form-floating mb-3">
            <form:input path="name" type="text" class="form-control" id="floatingInput"
                        placeholder="Enter name of product"/>
            <label for="floatingInput">Name</label>
        </div>
        <div class="form-floating mb-3">
            <textarea:input path="description" class="form-control" placeholder="Enter description of the product"
                            id="floatingTextarea2"
                            style="height: 100px"/>
            <label for="floatingTextarea2">Description</label>
        </div>
        <div class="form-floating mb-3">
            <form:input path="price" type="text" class="form-control" id="floatingInput"
                        placeholder="Enter name of product"/>
            <label for="floatingInput">Price</label>
        </div>
        <div class="d-grid gap-2 d-md-block">
            <input type="submit" value="Submit" class="btn btn-success btn-lg">
            <button class="btn btn-secondary btn-lg" type="button"
                    onclick="location.href='${pageContext.request.contextPath}/admin/showProducts'">Cancel</button>
        </div>
    </form:form>
</div>
</body>
</html>

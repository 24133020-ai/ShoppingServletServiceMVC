<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ Người Dùng</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body style="padding-top: 50px;">
<div class="container">
    <div class="jumbotron text-center">
        <h1>Chào mừng bạn đến với Hệ Thống!</h1>
        <p>Xin chào: <strong>${sessionScope.account != null ? sessionScope.account.fullName : 'Trần Hữu Việt Huân'}</strong> (${sessionScope.account.email})</p>
        <p>Vai trò của bạn: User thường (Role ID: ${sessionScope.account.roleid})</p>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-lg">Đăng xuất</a>
    </div>
</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body { background-color: #f4f7f6; padding-top: 60px; }
        .box { max-width: 440px; margin: auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .box-title { text-align: center; font-size: 22px; font-weight: 600; margin-bottom: 20px; color: #333; }
        .input-group-addon { background-color: #eee; min-width: 42px; }
        .btn-main { background-color: #0088cc; color: #fff; font-size: 16px; padding: 10px; font-weight: bold; }
        .btn-main:hover { background-color: #006699; color: #fff; }
        .otp-input { font-size: 24px; letter-spacing: 8px; text-align: center; }
    </style>
</head>
<body>
<div class="container">
    <div class="box">
        <h2 class="box-title">Quên mật khẩu</h2>
        <p class="text-center text-muted">Nhập email đã đăng ký, chúng tôi sẽ gửi mã OTP để đặt lại mật khẩu.</p>

        <c:if test="${alert != null}">
            <div class="alert alert-danger">${alert}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                    <input type="email" name="email" placeholder="Nhập Email" class="form-control" required autofocus />
                </div>
            </div>
            <button type="submit" class="btn btn-main btn-block">Gửi mã OTP</button>
        </form>

        <div class="text-center" style="margin-top: 20px;">
            <a href="${pageContext.request.contextPath}/login">Quay lại đăng nhập</a>
        </div>
    </div>
</div>
</body>
</html>

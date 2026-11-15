<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản</title>
    <!-- Bootstrap 3 CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            background-color: #f4f7f6;
            padding-top: 40px;
        }
        .register-box {
            max-width: 440px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .register-title {
            text-align: center;
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 25px;
            color: #333;
        }
        .input-group-addon {
            background-color: #eee;
            min-width: 42px;
        }
        .btn-register {
            background-color: #0088cc;
            color: white;
            font-size: 16px;
            padding: 10px;
            font-weight: bold;
        }
        .btn-register:hover {
            background-color: #006699;
            color: white;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="register-box">
        <h2 class="register-title">Tạo tài khoản mới</h2>

        <c:if test="${alert != null}">
            <div class="alert alert-danger">${alert}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    <input type="text" placeholder="Tài khoản" name="username" class="form-control" required />
                </div>
            </div>

            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-id-card"></i></span>
                    <input type="text" placeholder="Họ tên" name="fullname" class="form-control" required />
                </div>
            </div>

            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                    <input type="email" placeholder="Nhập Email" name="email" class="form-control" required />
                </div>
            </div>

            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                    <input type="text" placeholder="Số điện thoại" name="phone" class="form-control" />
                </div>
            </div>

            <div class="form-group">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <input type="password" placeholder="Mật khẩu" name="password" class="form-control" required />
                </div>
            </div>

            <button type="submit" class="btn btn-register btn-block">Tạo tài khoản</button>

            <div class="text-center" style="margin-top: 20px;">
                <span>Nếu bạn đã có tài khoản? </span>
                <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>

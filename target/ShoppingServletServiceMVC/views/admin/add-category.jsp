<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục mới</title>
    <!-- Bootstrap 3 CDN -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            background-color: #f0f3f4;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .header-bar {
            background-color: #0088cc;
            color: #fff;
            padding: 12px 25px;
        }
        .header-bar h3 {
            margin: 0;
            font-size: 22px;
            font-weight: bold;
        }
        .user-info {
            float: right;
            color: white;
            line-height: 35px;
        }
        .user-info a {
            color: #fff;
            margin-left: 15px;
            background: #d9534f;
            padding: 5px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
        }
        .sidebar {
            background-color: #2c3e50;
            min-height: calc(100vh - 60px);
            color: #fff;
            padding: 20px 0;
        }
        .admin-profile {
            text-align: center;
            padding: 15px;
            border-bottom: 1px solid #34495e;
        }
        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin-top: 15px;
        }
        .sidebar-menu li a {
            display: block;
            color: #bdc3c7;
            padding: 12px 20px;
            text-decoration: none;
            font-size: 14px;
        }
        .sidebar-menu li a:hover, .sidebar-menu li.active a {
            background-color: #1abc9c;
            color: #fff;
        }
        .main-content {
            padding: 25px 30px;
            background: #fff;
            min-height: calc(100vh - 60px);
        }
    </style>
</head>
<body>

<div class="header-bar clearfix">
    <div style="float: left;">
        <h3>Dashboard</h3>
    </div>
    <div class="user-info">
        <span>Xin chào, <strong>${sessionScope.account != null ? sessionScope.account.fullName : 'Trần Hữu Việt Huân'}</strong></span>
        <a href="${pageContext.request.contextPath}/logout"><i class="fa fa-sign-out"></i> Đăng xuất</a>
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-2 col-sm-3 sidebar">
            <div class="admin-profile">
                <i class="fa fa-user-circle-o fa-4x" style="color: #1abc9c;"></i>
                <div style="margin-top: 8px; font-weight: bold;">Trần Hữu Việt Huân</div>
                <div style="font-size: 12px; color: #bdc3c7;">(Admin)</div>
            </div>
            <ul class="sidebar-menu">
                <li><a href="#"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/admin/category/list"><i class="fa fa-folder-open"></i> Quản lý Danh mục</a></li>
                <li style="padding-left: 20px;" class="active"><a href="${pageContext.request.contextPath}/admin/category/add"><i class="fa fa-plus"></i> Thêm danh mục mới</a></li>
                <li style="padding-left: 20px;"><a href="${pageContext.request.contextPath}/admin/category/list"><i class="fa fa-list"></i> Danh sách danh mục</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="col-md-10 col-sm-9 main-content">
            <h2 style="margin-top: 0; color: #333; font-weight: bold;">Thêm mới danh mục</h2>
            <hr/>

            <div class="panel panel-default" style="max-width: 600px;">
                <div class="panel-heading"><strong>Thông tin danh mục</strong></div>
                <div class="panel-body">
                    <!-- Form gửi đến /admin/category/add với multipart/form-data -->
                    <form role="form" action="${pageContext.request.contextPath}/admin/category/add" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label>Tên danh mục:</label>
                            <input class="form-control" placeholder="Vui lòng nhập tên danh mục" name="catename" required />
                        </div>

                        <div class="form-group">
                            <label>Ảnh đại diện:</label>
                            <input type="file" name="icon" class="form-control" />
                        </div>

                        <button type="submit" class="btn btn-success">Thêm</button>
                        <button type="reset" class="btn btn-default">Hủy</button>
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-info pull-right">Quay lại danh sách</a>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>

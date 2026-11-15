<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục - Admin Dashboard</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
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
        .admin-profile img {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            margin-bottom: 10px;
            background: #fff;
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
        .table-responsive {
            margin-top: 20px;
        }
        .cate-img {
            max-width: 100px;
            max-height: 80px;
            object-fit: contain;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 3px;
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
                <li style="padding-left: 20px;"><a href="${pageContext.request.contextPath}/admin/category/add"><i class="fa fa-plus"></i> Thêm danh mục mới</a></li>
                <li style="padding-left: 20px;"><a href="${pageContext.request.contextPath}/admin/category/list"><i class="fa fa-list"></i> Danh sách danh mục</a></li>
                <li><a href="#"><i class="fa fa-shopping-cart"></i> Quản lý sản phẩm</a></li>
                <li><a href="#"><i class="fa fa-users"></i> Quản lý tài khoản</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="col-md-10 col-sm-9 main-content">
            <div class="row">
                <div class="col-md-8">
                    <h2 style="margin-top: 0; color: #d9534f; font-weight: bold;">Quản lý danh mục</h2>
                    <p class="text-muted">Nơi bạn có thể quản lý danh mục của mình</p>
                </div>
                <div class="col-md-4 text-right">
                    <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-primary" style="margin-top: 10px;">
                        <i class="fa fa-plus"></i> Thêm danh mục mới
                    </a>
                </div>
            </div>

            <hr/>

            <div class="panel panel-default">
                <div class="panel-heading" style="font-weight: bold;">Danh sách danh mục</div>
                <div class="panel-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr class="info">
                                    <th style="width: 60px; text-align: center;">STT</th>
                                    <th style="width: 140px; text-align: center;">Hình ảnh</th>
                                    <th>Tên danh mục</th>
                                    <th style="width: 150px; text-align: center;">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${cateList}" var="cate" varStatus="STT">
                                    <tr class="odd gradeX">
                                        <td style="text-align: center; vertical-align: middle;">${STT.index + 1}</td>
                                        <td style="text-align: center; vertical-align: middle;">
                                            <c:url value="/image?fname=${cate.icon}" var="imgUrl"></c:url>
                                            <img class="cate-img" src="${imgUrl}" alt="${cate.catename}" onerror="this.src='https://via.placeholder.com/100x80?text=No+Image'" />
                                        </td>
                                        <td style="vertical-align: middle; font-weight: 500;">${cate.catename}</td>
                                        <td style="text-align: center; vertical-align: middle;">
                                            <a href="<c:url value='/admin/category/edit?id=${cate.id}'/>" class="btn btn-warning btn-xs">
                                                <i class="fa fa-pencil"></i> Sửa
                                            </a>
                                            |
                                            <a href="<c:url value='/admin/category/delete?id=${cate.id}'/>" class="btn btn-danger btn-xs" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">
                                                <i class="fa fa-trash"></i> Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty cateList}">
                                    <tr>
                                        <td colspan="4" class="text-center text-muted">Chưa có danh mục nào. Hãy bấm "Thêm danh mục mới".</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>

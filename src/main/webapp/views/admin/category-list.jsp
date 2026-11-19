<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục - JPA Hibernate</title>
<style>
        body { background-color: #f0f3f4; font-family: Arial, sans-serif; margin: 0; padding: 0; }
        .header-bar { background-color: #0088cc; color: #fff; padding: 12px 25px; }
        .header-bar h3 { margin: 0; font-size: 22px; font-weight: bold; }
        .user-info { float: right; color: white; line-height: 35px; }
        .user-info a { color: #fff; margin-left: 15px; background: #d9534f; padding: 5px 12px; border-radius: 4px; text-decoration: none; font-weight: bold; }
        .sidebar { background-color: #2c3e50; min-height: calc(100vh - 60px); color: #fff; padding: 20px 0; }
        .admin-profile { text-align: center; padding: 15px; border-bottom: 1px solid #34495e; }
        .sidebar-menu { list-style: none; padding: 0; margin-top: 15px; }
        .sidebar-menu li a { display: block; color: #bdc3c7; padding: 12px 20px; text-decoration: none; font-size: 14px; }
        .sidebar-menu li a:hover, .sidebar-menu li.active a { background-color: #1abc9c; color: #fff; }
        .main-content { padding: 25px 30px; background: #fff; min-height: calc(100vh - 60px); }
        .cate-img { max-width: 120px; max-height: 90px; object-fit: contain; border: 1px solid #ddd; border-radius: 4px; padding: 3px; }
    </style>
</head>
<body>

<div class="header-bar clearfix">
    <div style="float: left;">
        <h3>Dashboard (JPA 3.0 &amp; Hibernate)</h3>
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
                <li class="active"><a href="${pageContext.request.contextPath}/admin/categories"><i class="fa fa-folder-open"></i> Quản lý Danh mục (JPA)</a></li>
                <li style="padding-left: 20px;"><a href="${pageContext.request.contextPath}/admin/category/add"><i class="fa fa-plus"></i> Add Category</a></li>
                <li style="padding-left: 20px;"><a href="${pageContext.request.contextPath}/admin/categories"><i class="fa fa-list"></i> Danh sách danh mục</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="col-md-10 col-sm-9 main-content">
            <c:if test="${alert != null}">
                <div class="alert alert-danger"><c:out value="${alert}"/></div>
            </c:if>
            <div class="row">
                <div class="col-md-8">
                    <h2 style="margin-top: 0; color: #d9534f; font-weight: bold;">Quản lý danh mục (JPA CRUD)</h2>
                    <p class="text-muted">Áp dụng công nghệ JPA 3.0, Jakarta 6.0 và Hibernate ORM</p>
                </div>
                <div class="col-md-4 text-right">
                    <a href="<c:url value='/admin/category/add'/>" class="btn btn-primary" style="margin-top: 10px;">
                        <i class="fa fa-plus"></i> Add Category
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
                                    <th style="width: 150px; text-align: center;">Images</th>
                                    <th>Category name</th>
                                    <th style="width: 130px; text-align: center;">Status</th>
                                    <th style="width: 160px; text-align: center;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listcate}" var="cate" varStatus="STT">
                                    <tr>
                                        <td style="text-align: center; vertical-align: middle;">${STT.index + 1}</td>
                                        <td style="text-align: center; vertical-align: middle;">
                                            <c:choose>
                                                <c:when test="${cate.images != null && (cate.images.startsWith('http://') || cate.images.startsWith('https://'))}">
                                                    <c:url value="${cate.images}" var="imgUrl"></c:url>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
                                                </c:otherwise>
                                            </c:choose>
                                            <img class="cate-img" src="${imgUrl}" alt="${cate.categoryname}" onerror="this.src='https://via.placeholder.com/120x90?text=No+Image'" />
                                        </td>
                                        <td style="vertical-align: middle; font-weight: 500;">${cate.categoryname}</td>
                                        <td style="text-align: center; vertical-align: middle;">
                                            <c:if test="${cate.status == 1}">
                                                <span class="label label-success">Hoạt động</span>
                                            </c:if>
                                            <c:if test="${cate.status != 1}">
                                                <span class="label label-danger">Khóa</span>
                                            </c:if>
                                        </td>
                                        <td style="text-align: center; vertical-align: middle;">
                                            <a href="<c:url value='/admin/category/edit?id=${cate.categoryId}'/>" class="btn btn-warning btn-xs">
                                                <i class="fa fa-pencil"></i> Sửa
                                            </a>
                                            |
                                            <a href="<c:url value='/admin/category/delete?id=${cate.categoryId}'/>" class="btn btn-danger btn-xs" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">
                                                <i class="fa fa-trash"></i> Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listcate}">
                                    <tr>
                                        <td colspan="5" class="text-center text-muted">Chưa có danh mục nào. Hãy bấm "Add Category" để thêm mới.</td>
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

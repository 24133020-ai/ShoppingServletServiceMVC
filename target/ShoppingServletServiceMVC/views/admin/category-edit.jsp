<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa Category - JPA Hibernate</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
        .img-preview { max-width: 140px; max-height: 100px; border: 1px solid #ccc; border-radius: 4px; padding: 4px; margin: 10px 0; display: block; }
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
            <h2 style="margin-top: 0; color: #333; font-weight: bold;">Edit Category</h2>
            <hr/>

            <div class="panel panel-default" style="max-width: 600px;">
                <div class="panel-heading"><strong>Chỉnh sửa Category</strong></div>
                <div class="panel-body">
                    <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="categoryid" value="${cate.categoryId}">

                        <div class="form-group">
                            <label for="categoryname">Category name:</label>
                            <input type="text" class="form-control" id="categoryname" name="categoryname" value="${cate.categoryname}" required>
                        </div>

                        <div class="form-group">
                            <label for="images">Link images:</label>
                            <input type="text" class="form-control" id="images" name="images" value="${cate.images}">
                        </div>

                        <div class="form-group">
                            <label>Ảnh hiện tại:</label>
                            <c:choose>
                                <c:when test="${cate.images != null && (cate.images.startsWith('http://') || cate.images.startsWith('https://'))}">
                                    <c:url value="${cate.images}" var="imgUrl"></c:url>
                                </c:when>
                                <c:otherwise>
                                    <c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
                                </c:otherwise>
                            </c:choose>
                            <img class="img-preview" src="${imgUrl}" alt="${cate.categoryname}" onerror="this.src='https://via.placeholder.com/140x100?text=No+Image'"><br>

                            <label for="images1">Upload images mới (để trống nếu giữ ảnh cũ):</label>
                            <input type="file" class="form-control" id="images1" name="images1">
                        </div>

                        <div class="form-group">
                            <label>Status:</label><br>
                            <label class="radio-inline">
                                <input type="radio" id="ston" name="status" value="1" ${cate.status == 1 ? 'checked' : ''}> Hoạt động
                            </label>
                            <label class="radio-inline">
                                <input type="radio" id="stoff" name="status" value="0" ${cate.status != 1 ? 'checked' : ''}> Khóa
                            </label>
                        </div>

                        <br>
                        <input type="submit" class="btn btn-warning" value="Update">
                        <a href="<c:url value='/admin/categories'/>" class="btn btn-default pull-right">Back to list</a>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>

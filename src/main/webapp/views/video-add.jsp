<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Video</title>
<style>
        body { background-color: #f0f3f4; font-family: Arial, sans-serif; margin: 0; padding: 0; }
        .header-bar { background-color: #0088cc; color: #fff; padding: 12px 25px; }
        .header-bar h3 { margin: 0; font-size: 22px; font-weight: bold; }
        .user-info { float: right; color: white; line-height: 35px; }
        .user-info a { color: #fff; margin-left: 15px; padding: 5px 12px; border-radius: 4px; text-decoration: none; font-weight: bold; background: #006699; }
        .user-info a.logout { background: #d9534f; }
        .main-content { padding: 25px 30px; }
        .poster { width: 100%; height: 160px; object-fit: cover; background: #e5e5e5; }
        .no-poster { width: 100%; height: 160px; background: #e5e5e5; color: #999; line-height: 160px; text-align: center; }
        .video-title { font-weight: bold; font-size: 16px; }
    </style>
</head>
<body>
<div class="header-bar clearfix">
    <div style="float: left;">
        <h3>Video</h3>
    </div>
    <div class="user-info">
        <span>Xin chào, <strong><c:out value="${sessionScope.account.fullName}"/></strong></span>
        <a href="${pageContext.request.contextPath}/home"><i class="fa fa-home"></i> Trang chủ</a>
        <a href="${pageContext.request.contextPath}/video"><i class="fa fa-film"></i> Video của tôi</a>
        <a href="${pageContext.request.contextPath}/logout" class="logout"><i class="fa fa-sign-out"></i> Đăng xuất</a>
    </div>
</div>

<div class="container main-content">
    <h2 style="margin-top: 0; font-weight: bold;">Add New Video</h2>
    <hr/>

    <div class="panel panel-default" style="max-width: 650px;">
        <div class="panel-heading"><strong>Thông tin Video</strong></div>
        <div class="panel-body">
            <c:if test="${alert != null}">
                <div class="alert alert-danger"><c:out value="${alert}"/></div>
            </c:if>
            <form action="<c:url value='/video/insert'/>" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="videoId">Video ID (mã video YouTube):</label>
                    <input type="text" class="form-control" id="videoId" name="videoId" maxlength="50"
                           pattern="[A-Za-z0-9_-]{1,50}" title="Chỉ gồm chữ không dấu, số, dấu gạch ngang và gạch dưới."
                           placeholder="Ví dụ: dQw4w9WgXcQ" value="<c:out value='${video.videoId}'/>" required />
                </div>
                <div class="form-group">
                    <label for="title">Title:</label>
                    <input type="text" class="form-control" id="title" name="title" minlength="1" maxlength="255"
                           placeholder="Nhập tiêu đề video" value="<c:out value='${video.title}'/>" required />
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea class="form-control" id="description" name="description" rows="4" maxlength="5000"><c:out value="${video.description}"/></textarea>
                    <small class="help-block">Mô tả tối đa 5.000 ký tự.</small>
                </div>
                <div class="form-group">
                    <label for="posterFile">Poster (upload từ máy tính):</label>
                    <input type="file" class="form-control" id="posterFile" name="posterFile" accept="image/png,image/jpeg,image/gif,image/webp" />
                    <small class="help-block">Chỉ nhận PNG, JPG, JPEG hoặc WEBP; tối đa 5MB.</small>
                </div>
                <div class="form-group">
                    <label>Status:</label><br/>
                    <label class="radio-inline">
                        <input type="radio" name="active" value="1" ${video == null || video.active ? 'checked' : ''} required /> Hoạt động
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="active" value="0" ${video != null && !video.active ? 'checked' : ''} /> Khóa
                    </label>
                </div>
                <br/>
                <input type="submit" class="btn btn-success" value="Insert" />
                <input type="reset" class="btn btn-default" value="Reset" />
                <a href="<c:url value='/video'/>" class="btn btn-info pull-right">Back to list</a>
            </form>
        </div>
    </div>
</div>
</body>
</html>

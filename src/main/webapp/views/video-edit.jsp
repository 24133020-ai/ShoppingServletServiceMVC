<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa Video</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
    <h2 style="margin-top: 0; font-weight: bold;">Edit Video</h2>
    <hr/>

    <div class="panel panel-default" style="max-width: 650px;">
        <div class="panel-heading"><strong>Thông tin Video</strong></div>
        <div class="panel-body">
            <c:if test="${alert != null}">
                <div class="alert alert-danger">${alert}</div>
            </c:if>
            <form action="<c:url value='/video/update'/>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="videoId" value="<c:out value='${video.videoId}'/>" />
                <div class="form-group">
                    <label>Video ID:</label>
                    <input type="text" class="form-control" value="<c:out value='${video.videoId}'/>" disabled />
                </div>
                <div class="form-group">
                    <label for="title">Title:</label>
                    <input type="text" class="form-control" id="title" name="title" maxlength="255"
                           value="<c:out value='${video.title}'/>" required />
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea class="form-control" id="description" name="description" rows="4"><c:out value="${video.description}"/></textarea>
                </div>
                <div class="form-group">
                    <label>Poster hiện tại:</label><br/>
                    <c:choose>
                        <c:when test="${not empty video.poster}">
                            <img src="<c:url value='/image?fname=${video.poster}'/>" alt="poster"
                                 style="max-width: 240px; max-height: 135px; border: 1px solid #ddd; padding: 3px;" />
                        </c:when>
                        <c:otherwise><span class="text-muted">Chưa có poster</span></c:otherwise>
                    </c:choose>
                </div>
                <div class="form-group">
                    <label for="posterFile">Đổi poster (upload từ máy tính):</label>
                    <input type="file" class="form-control" id="posterFile" name="posterFile" accept="image/*" />
                </div>
                <div class="form-group">
                    <label>Status:</label><br/>
                    <label class="radio-inline">
                        <input type="radio" name="active" value="1" ${video.active ? 'checked' : ''} /> Hoạt động
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="active" value="0" ${!video.active ? 'checked' : ''} /> Khóa
                    </label>
                </div>
                <br/>
                <input type="submit" class="btn btn-success" value="Update" />
                <a href="<c:url value='/video'/>" class="btn btn-info pull-right">Back to list</a>
            </form>
        </div>
    </div>
</div>
</body>
</html>

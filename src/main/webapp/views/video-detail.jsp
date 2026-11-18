<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><c:out value="${video.title}"/></title>
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
    <div class="row">
        <div class="col-md-9">
            <div class="embed-responsive embed-responsive-16by9" style="position: relative; padding-bottom: 56.25%; height: 0;">
                <iframe style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: 0;"
                        src="https://www.youtube.com/embed/<c:out value='${video.videoId}'/>"
                        title="video player" allowfullscreen></iframe>
            </div>
            <h2 style="font-weight: bold;"><c:out value="${video.title}"/></h2>
            <p class="text-muted">
                <i class="fa fa-eye"></i> ${video.views} lượt xem
                &nbsp;|&nbsp; Đăng bởi: <strong><c:out value="${video.user.fullName}"/></strong>
                &nbsp;|&nbsp;
                <c:if test="${video.active}"><span class="label label-success">Hoạt động</span></c:if>
                <c:if test="${!video.active}"><span class="label label-danger">Khóa</span></c:if>
            </p>
            <div class="well" style="white-space: pre-wrap;"><c:out value="${video.description}"/></div>
            <a href="<c:url value='/home'/>" class="btn btn-default"><i class="fa fa-home"></i> Trang chủ</a>
            <a href="<c:url value='/video'/>" class="btn btn-info"><i class="fa fa-film"></i> Video của tôi</a>
        </div>
    </div>
</div>
</body>
</html>

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
        <a href="${pageContext.request.contextPath}/video" class="btn btn-primary btn-lg">Video của tôi</a>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-lg">Đăng xuất</a>
    </div>

    <!-- 10 video mới nhất -->
    <h3 style="font-weight: bold;">Video mới nhất</h3>
    <hr/>
    <div class="row">
        <c:forEach items="${newestVideos}" var="v">
            <div class="col-sm-6 col-md-3">
                <div class="thumbnail">
                    <c:choose>
                        <c:when test="${not empty v.poster}">
                            <img src="<c:url value='/image?fname=${v.poster}'/>" alt="poster"
                                 style="width: 100%; height: 130px; object-fit: cover;" />
                        </c:when>
                        <c:otherwise>
                            <div style="width: 100%; height: 130px; background: #e5e5e5; color: #999; line-height: 130px; text-align: center;">No poster</div>
                        </c:otherwise>
                    </c:choose>
                    <div class="caption">
                        <a href="<c:url value='/video/detail?id=${v.videoId}'/>" style="font-weight: bold;"><c:out value="${v.title}"/></a>
                        <p class="text-muted" style="margin: 6px 0 0;">
                            <small>Đăng bởi: <c:out value="${v.user.fullName}"/></small>
                        </p>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty newestVideos}">
            <div class="col-md-12 text-center text-muted">Chưa có video nào.</div>
        </c:if>
    </div>
</div>
</body>
</html>

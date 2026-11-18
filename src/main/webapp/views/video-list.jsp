<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Video của tôi</title>
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
        <div class="col-md-8">
            <h2 style="margin-top: 0; font-weight: bold;">Video của tôi</h2>
        </div>
        <div class="col-md-4 text-right">
            <a href="<c:url value='/video/add'/>" class="btn btn-primary" style="margin-top: 10px;">
                <i class="fa fa-plus"></i> Add Video
            </a>
        </div>
    </div>
    <hr/>

    <c:if test="${alert != null}">
        <div class="alert alert-danger">${alert}</div>
    </c:if>

    <div class="row">
        <c:forEach items="${listvideo}" var="v">
            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <c:choose>
                        <c:when test="${not empty v.poster}">
                            <img class="poster" src="<c:url value='/image?fname=${v.poster}'/>" alt="poster" />
                        </c:when>
                        <c:otherwise>
                            <div class="no-poster">No poster</div>
                        </c:otherwise>
                    </c:choose>
                    <div class="caption">
                        <a class="video-title" href="<c:url value='/video/detail?id=${v.videoId}'/>"><c:out value="${v.title}"/></a>
                        <p style="margin-top: 8px;">
                            <c:if test="${v.active}"><span class="label label-success">Hoạt động</span></c:if>
                            <c:if test="${!v.active}"><span class="label label-danger">Khóa</span></c:if>
                            <span class="text-muted" style="margin-left: 8px;"><i class="fa fa-eye"></i> ${v.views}</span>
                        </p>
                        <p>
                            <a href="<c:url value='/video/edit?id=${v.videoId}'/>" class="btn btn-warning btn-xs"><i class="fa fa-pencil"></i> Sửa</a>
                            <a href="<c:url value='/video/delete?id=${v.videoId}'/>" class="btn btn-danger btn-xs"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa video này?');"><i class="fa fa-trash"></i> Xóa</a>
                        </p>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty listvideo}">
            <div class="col-md-12 text-center text-muted">Bạn chưa có video nào. Hãy bấm "Add Video" để thêm mới.</div>
        </c:if>
    </div>

    <!-- Phân trang: 6 video / trang -->
    <c:if test="${totalPages > 1}">
        <div class="text-center">
            <ul class="pagination">
                <li class="${currentPage == 1 ? 'disabled' : ''}">
                    <a href="<c:url value='/video?page=${currentPage - 1}'/>">&laquo;</a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="${i == currentPage ? 'active' : ''}">
                        <a href="<c:url value='/video?page=${i}'/>">${i}</a>
                    </li>
                </c:forEach>
                <li class="${currentPage == totalPages ? 'disabled' : ''}">
                    <a href="<c:url value='/video?page=${currentPage + 1}'/>">&raquo;</a>
                </li>
            </ul>
        </div>
    </c:if>
</div>
</body>
</html>

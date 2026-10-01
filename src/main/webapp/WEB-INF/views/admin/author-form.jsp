<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title><c:choose><c:when test="${not empty author}">Sửa Tác Giả</c:when><c:otherwise>Thêm Tác Giả Mới</c:otherwise></c:choose> - MSSV 24162067</title>
</head>

<div class="row justify-content-center">
    <div class="col-md-6">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-success text-white py-3">
                <h4 class="mb-0 fw-bold">
                    <c:choose>
                        <c:when test="${not empty author}"><i class="fa-solid fa-pen-to-square me-2"></i>Cập Nhật Tác Giả ID: ${author.authorId}</c:when>
                        <c:otherwise><i class="fa-solid fa-plus-circle me-2"></i>Thêm Tác Giả Mới</c:otherwise>
                    </c:choose>
                </h4>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin/authors" method="post">
                    <c:if test="${not empty author}">
                        <input type="hidden" name="authorId" value="${author.authorId}"/>
                    </c:if>

                    <div class="mb-3">
                        <label for="authorName" class="form-label fw-bold">Họ và tên tác giả:</label>
                        <input type="text" class="form-control" id="authorName" name="authorName" value="<c:out value="${author.authorName}"/>" required placeholder="Nhập tên tác giả">
                    </div>

                    <div class="mb-4">
                        <label for="dateOfBirth" class="form-label fw-bold">Ngày sinh:</label>
                        <fmt:formatDate var="formattedDob" value="${author.dateOfBirth}" pattern="yyyy-MM-dd"/>
                        <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" value="${formattedDob}">
                    </div>

                    <div class="text-end">
                        <a href="${pageContext.request.contextPath}/admin/authors" class="btn btn-secondary me-2">Hủy bỏ</a>
                        <button type="submit" class="btn btn-success px-4 fw-bold">Lưu Tác Giả</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

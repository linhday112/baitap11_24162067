<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <title><c:choose><c:when test="${not empty user}">Sửa Người Dùng</c:when><c:otherwise>Thêm Người Dùng Mới</c:otherwise></c:choose> - MSSV 24162067</title>
</head>

<div class="row justify-content-center">
    <div class="col-md-7">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-warning text-dark py-3">
                <h4 class="mb-0 fw-bold">
                    <c:choose>
                        <c:when test="${not empty user}"><i class="fa-solid fa-user-pen me-2"></i>Cập Nhật Người Dùng ID: ${user.id}</c:when>
                        <c:otherwise><i class="fa-solid fa-user-plus me-2"></i>Thêm Người Dùng Mới</c:otherwise>
                    </c:choose>
                </h4>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin/users" method="post">
                    <c:if test="${not empty user}">
                        <input type="hidden" name="id" value="${user.id}"/>
                    </c:if>

                    <div class="mb-3">
                        <label for="email" class="form-label fw-bold">Email:</label>
                        <input type="email" class="form-control" id="email" name="email" value="<c:out value="${user.email}"/>" required placeholder="example@gmail.com">
                    </div>

                    <div class="mb-3">
                        <label for="fullname" class="form-label fw-bold">Họ và tên:</label>
                        <input type="text" class="form-control" id="fullname" name="fullname" value="<c:out value="${user.fullname}"/>" required placeholder="Nguyễn Văn A">
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label fw-bold">Số điện thoại:</label>
                        <input type="text" class="form-control" id="phone" name="phone" value="<c:out value="${user.phone}"/>" placeholder="0912345678">
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label fw-bold">Mật khẩu <c:if test="${not empty user}"><span class="text-muted font-weight-normal">(Bỏ trống nếu không thay đổi)</span></c:if>:</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" ${empty user ? 'required' : ''}>
                    </div>

                    <div class="mb-4">
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="isAdmin" name="isAdmin" value="true" ${user.isAdmin ? 'checked' : ''}>
                            <label class="form-check-label fw-bold" for="isAdmin">Gán quyền Quản Trị Viên (Is Admin)</label>
                        </div>
                    </div>

                    <div class="text-end">
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary me-2">Hủy bỏ</a>
                        <button type="submit" class="btn btn-warning text-dark px-4 fw-bold">Lưu Người Dùng</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <title>Đặt Lại Mật Khẩu - MSSV 24162067</title>
</head>

<div class="row justify-content-center my-4">
    <div class="col-md-5">
        <div class="card shadow border-0 rounded-4">
            <div class="card-body p-4 p-md-5">
                <h3 class="fw-bold text-center mb-2"><i class="fa-solid fa-lock-open text-success me-2"></i>Đặt Lại Mật Khẩu</h3>
                <p class="text-muted text-center mb-4">Nhập mã OTP vừa gửi tới email <strong><c:out value="${sessionScope.resetEmail_24162067}"/></strong> và mật khẩu mới của bạn.</p>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fa-solid fa-triangle-exclamation me-2"></i><c:out value="${error}"/>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/reset-password" method="post">
                    <div class="mb-3">
                        <label for="otp" class="form-label fw-semibold">Mã OTP (6 chữ số):</label>
                        <input type="text" class="form-control text-center fw-bold fs-4" id="otp" name="otp" maxlength="6" placeholder="000000" required autofocus autocomplete="off">
                    </div>
                    <div class="mb-3">
                        <label for="newPassword" class="form-label fw-semibold">Mật khẩu mới:</label>
                        <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="••••••••" required>
                    </div>
                    <div class="mb-4">
                        <label for="confirmPassword" class="form-label fw-semibold">Xác nhận mật khẩu mới:</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="••••••••" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100 py-2 fw-bold">Lưu Mật Khẩu Mới</button>
                </form>

                <div class="mt-4 text-center">
                    <a href="${pageContext.request.contextPath}/forgot-password" class="text-secondary small">Gửi lại mã OTP</a>
                </div>
            </div>
        </div>
    </div>
</div>

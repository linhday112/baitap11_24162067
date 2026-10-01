<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <title>Đăng Ký Tài Khoản - MSSV 24162067</title>
</head>

<div class="row justify-content-center my-4">
    <div class="col-md-6">
        <div class="card shadow border-0 rounded-4">
            <div class="card-body p-4 p-md-5">
                <h3 class="fw-bold text-center mb-4"><i class="fa-solid fa-user-plus text-primary me-2"></i>Đăng Ký Tài Khoản</h3>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fa-solid fa-triangle-exclamation me-2"></i><c:out value="${error}"/>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="mb-3">
                        <label for="email" class="form-label fw-semibold">Email nhận OTP:</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="example@gmail.com" required>
                    </div>
                    <div class="mb-3">
                        <label for="fullname" class="form-label fw-semibold">Họ và Tên:</label>
                        <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Nguyễn Văn A" required>
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label fw-semibold">Số điện thoại:</label>
                        <input type="text" class="form-control" id="phone" name="phone" placeholder="0912345678">
                    </div>
                    <div class="mb-4">
                        <label for="password" class="form-label fw-semibold">Mật khẩu:</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100 py-2 fw-bold">Gửi Mã OTP Qua Mail</button>
                </form>

                <div class="mt-4 text-center">
                    <p class="mb-0 text-muted">Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="text-primary fw-bold">Đăng nhập</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <title>Quên Mật Khẩu - MSSV 24162067</title>
</head>

<div class="row justify-content-center my-5">
    <div class="col-md-5">
        <div class="card shadow border-0 rounded-4">
            <div class="card-body p-4 p-md-5">
                <h3 class="fw-bold text-center mb-2"><i class="fa-solid fa-key text-warning me-2"></i>Quên Mật Khẩu</h3>
                <p class="text-muted text-center mb-4">Nhập email đã đăng ký của bạn để nhận mã xác thực OTP khôi phục mật khẩu.</p>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fa-solid fa-triangle-exclamation me-2"></i><c:out value="${error}"/>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                    <div class="mb-4">
                        <label for="email" class="form-label fw-semibold">Email tài khoản:</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="example@gmail.com" required autofocus>
                    </div>
                    <button type="submit" class="btn btn-warning w-100 py-2 fw-bold text-dark">Gửi Mã OTP Đặt Lại Mật Khẩu</button>
                </form>

                <div class="mt-4 text-center">
                    <a href="${pageContext.request.contextPath}/login" class="text-secondary fw-semibold"><i class="fa-solid fa-arrow-left me-1"></i>Quay lại đăng nhập</a>
                </div>
            </div>
        </div>
    </div>
</div>

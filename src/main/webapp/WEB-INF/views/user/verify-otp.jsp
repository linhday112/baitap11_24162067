<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <title>Xác Thực OTP - MSSV 24162067</title>
</head>

<div class="row justify-content-center my-5">
    <div class="col-md-5">
        <div class="card shadow border-0 rounded-4">
            <div class="card-body p-4 p-md-5 text-center">
                <i class="fa-solid fa-envelope-circle-check text-success fa-3x mb-3"></i>
                <h3 class="fw-bold mb-2">Nhập Mã OTP Xác Thực</h3>
                <p class="text-muted mb-4">Mã OTP 6 chữ số đã được gửi tới email <strong><c:out value="${sessionScope.pendingUser_24162067.email}"/></strong></p>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger text-start" role="alert">
                        <i class="fa-solid fa-triangle-exclamation me-2"></i><c:out value="${error}"/>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                    <div class="mb-4">
                        <input type="text" class="form-control form-control-lg text-center fw-bold fs-3 tracking-widest" id="otp" name="otp" maxlength="6" placeholder="000000" required autofocus autocomplete="off">
                    </div>
                    <button type="submit" class="btn btn-primary w-100 py-2 fw-bold">Xác Nhận Đăng Ký</button>
                </form>

                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/register" class="text-secondary small">Quay lại đăng ký</a>
                </div>
            </div>
        </div>
    </div>
</div>

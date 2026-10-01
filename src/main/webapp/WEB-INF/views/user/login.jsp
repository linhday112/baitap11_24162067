<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <title>Đăng Nhập - Hệ Thống Bookstore (MSSV: 24162067)</title>
</head>

<div class="row justify-content-center my-5">
    <div class="col-md-5">
        <div class="card shadow border-0 rounded-4">
            <div class="card-body p-4 p-md-5">
                <h3 class="fw-bold text-center mb-4"><i class="fa-solid fa-right-to-bracket text-primary me-2"></i>Đăng Nhập</h3>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fa-solid fa-triangle-exclamation me-2"></i><c:out value="${error}"/>
                    </div>
                </c:if>
                <c:if test="${not empty message}">
                    <div class="alert alert-success" role="alert">
                        <i class="fa-solid fa-circle-check me-2"></i><c:out value="${message}"/>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label for="email" class="form-label fw-semibold">Email:</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="user@example.com" required>
                    </div>
                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label for="password" class="form-label fw-semibold mb-0">Mật khẩu:</label>
                            <a href="${pageContext.request.contextPath}/forgot-password" class="text-primary small text-decoration-none">Quên mật khẩu?</a>
                        </div>
                        <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 py-2 font-weight-bold mt-2">Đăng Nhập</button>
                </form>

                <div class="mt-4 text-center">
                    <p class="mb-0 text-muted">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="text-primary fw-bold">Đăng ký ngay</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

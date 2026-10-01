<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <title>Bảng Điều Khiển Quản Trị - MSSV 24162067</title>
</head>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="fw-bold text-dark"><i class="fa-solid fa-gauge me-2"></i>Tổng Quan Hệ Thống</h2>
    <span class="badge bg-primary fs-6">Đề số: 01 | MSSV: 24162067</span>
</div>

<div class="row g-4 mb-4">
    <div class="col-md-3">
        <div class="card border-0 shadow-sm bg-primary text-white h-100">
            <div class="card-body p-4 d-flex align-items-center justify-content-between">
                <div>
                    <h6 class="text-white-50 text-uppercase fw-bold mb-1">Tổng Số Sách</h6>
                    <h2 class="display-5 fw-bold mb-0">${totalBooks}</h2>
                </div>
                <i class="fa-solid fa-book-open fa-3x text-white-50"></i>
            </div>
            <div class="card-footer bg-primary border-0">
                <a href="${pageContext.request.contextPath}/admin/books" class="text-white text-decoration-none small">
                    Quản lý sách <i class="fa-solid fa-arrow-right ms-1"></i>
                </a>
            </div>
        </div>
    </div>
    
    <div class="col-md-3">
        <div class="card border-0 shadow-sm bg-success text-white h-100">
            <div class="card-body p-4 d-flex align-items-center justify-content-between">
                <div>
                    <h6 class="text-white-50 text-uppercase fw-bold mb-1">Tổng Tác Giả</h6>
                    <h2 class="display-5 fw-bold mb-0">${totalAuthors}</h2>
                </div>
                <i class="fa-solid fa-pen-nib fa-3x text-white-50"></i>
            </div>
            <div class="card-footer bg-success border-0">
                <a href="${pageContext.request.contextPath}/admin/authors" class="text-white text-decoration-none small">
                    Quản lý tác giả <i class="fa-solid fa-arrow-right ms-1"></i>
                </a>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card border-0 shadow-sm bg-warning text-dark h-100">
            <div class="card-body p-4 d-flex align-items-center justify-content-between">
                <div>
                    <h6 class="text-black-50 text-uppercase fw-bold mb-1">Tổng Người Dùng</h6>
                    <h2 class="display-5 fw-bold mb-0">${totalUsers}</h2>
                </div>
                <i class="fa-solid fa-users fa-3x text-black-50"></i>
            </div>
            <div class="card-footer bg-warning border-0">
                <a href="${pageContext.request.contextPath}/admin/users" class="text-dark text-decoration-none small fw-bold">
                    Quản lý người dùng <i class="fa-solid fa-arrow-right ms-1"></i>
                </a>
            </div>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card border-0 shadow-sm bg-info text-white h-100">
            <div class="card-body p-4 d-flex align-items-center justify-content-between">
                <div>
                    <h6 class="text-white-50 text-uppercase fw-bold mb-1">Tổng Đơn Hàng</h6>
                    <h2 class="display-5 fw-bold mb-0">${totalOrders}</h2>
                    <c:if test="${newOrdersCount > 0}">
                        <span class="badge bg-danger small mt-1">${newOrdersCount} đơn mới</span>
                    </c:if>
                </div>
                <i class="fa-solid fa-boxes-packing fa-3x text-white-50"></i>
            </div>
            <div class="card-footer bg-info border-0">
                <a href="${pageContext.request.contextPath}/admin/orders" class="text-white text-decoration-none small">
                    Quản lý đơn hàng <i class="fa-solid fa-arrow-right ms-1"></i>
                </a>
            </div>
        </div>
    </div>
</div>

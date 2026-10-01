<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Quản Trị - MSSV 24162067</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { min-height: 100vh; display: flex; flex-direction: column; background-color: #f4f6f9; }
        .main-wrapper { display: flex; flex: 1; }
        .sidebar { width: 250px; background-color: #343a40; color: #fff; min-height: calc(100vh - 56px - 70px); }
        .sidebar .nav-link { color: #c2c7d0; padding: 12px 20px; font-weight: 500; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background-color: #0d6efd; }
        .admin-content { flex: 1; padding: 25px; }
        .footer-custom { background-color: #212529; color: #f8f9fa; padding: 18px 0; margin-top: auto; }
    </style>
</head>
<body>

    <!-- Admin Top Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container-fluid px-4">
            <a class="navbar-brand fw-bold text-warning" href="${pageContext.request.contextPath}/admin/home">
                <i class="fa-solid fa-user-shield me-2"></i>ADMIN PANEL <span class="badge bg-danger">24162067</span>
            </a>
            <div class="ms-auto d-flex align-items-center">
                <span class="text-light me-3">
                    <i class="fa-solid fa-user-circle me-1"></i>
                    Xin chào, <strong><c:out value="${sessionScope.account_24162067.fullname}"/></strong>
                </span>
                <a class="btn btn-outline-light btn-sm me-2" href="${pageContext.request.contextPath}/home" target="_blank">
                    <i class="fa-solid fa-globe me-1"></i>Xem Website
                </a>
                <a class="btn btn-danger btn-sm" href="${pageContext.request.contextPath}/logout">
                    <i class="fa-solid fa-right-from-bracket me-1"></i>Thoát
                </a>
            </div>
        </div>
    </nav>

    <!-- Admin Sidebar + Content Layout -->
    <div class="main-wrapper">
        <div class="sidebar py-3">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/home">
                        <i class="fa-solid fa-chart-line me-2"></i>Tổng Quan
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/books">
                        <i class="fa-solid fa-book-open me-2"></i>Quản Lý Sách
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/authors">
                        <i class="fa-solid fa-pen-nib me-2"></i>Quản Lý Tác Giả
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                        <i class="fa-solid fa-users-gear me-2"></i>Quản Lý Người Dùng
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                        <i class="fa-solid fa-boxes-packing me-2"></i>Quản Lý Đơn Hàng
                    </a>
                </li>
            </ul>
        </div>
        <div class="admin-content">
            ${pageContent_24162067}
        </div>
    </div>

    <!-- Mandatory Footer Display Requirement -->
    <footer class="footer-custom text-center">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6 text-md-start">
                    <span class="fw-bold"><i class="fa-solid me-2 text-warning"></i>HỆ THỐNG QUẢN TRỊ BOOKSTORE</span>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="m-0">
                        <strong>Họ tên sinh viên:</strong> Nguyễn Đình Lĩnh | 
                        <strong>MSSV:</strong> <span class="badge bg-warning text-dark">24162067</span> | 
                        <strong>Mã đề:</strong> <span class="badge bg-info text-dark">01</span>
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

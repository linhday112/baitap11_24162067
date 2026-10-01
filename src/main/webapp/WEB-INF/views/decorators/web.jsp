<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa Hàng Sách Online - 24162067</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { min-height: 100vh; display: flex; flex-direction: column; background-color: #f4f6f9; }
        .main-content { flex: 1; }
        .footer-custom { background-color: #1e242b; color: #f8f9fa; padding: 20px 0; margin-top: 40px; border-top: 3px solid #ffc107; }
        .book-card { transition: transform 0.2s, box-shadow 0.2s; height: 100%; border-radius: 12px; overflow: hidden; }
        .book-card:hover { transform: translateY(-5px); box-shadow: 0 12px 24px rgba(0,0,0,0.15); }
        .book-img { height: 260px; object-fit: cover; }
        
        /* Navbar Menu Enhancements */
        .navbar-custom { background: linear-gradient(135deg, #1a1d20 0%, #212529 100%); }
        .nav-link-item {
            color: rgba(255, 255, 255, 0.85) !important;
            font-size: 0.95rem;
            font-weight: 500;
            padding: 8px 14px !important;
            margin: 0 2px;
            border-radius: 8px;
            transition: all 0.25s ease-in-out;
            display: inline-flex;
            align-items: center;
        }
        .nav-link-item:hover {
            color: #ffc107 !important;
            background-color: rgba(255, 193, 7, 0.15);
        }
        .nav-link-item.active-yellow {
            color: #20252c !important;
            font-weight: 700 !important;
            background-color: #ffd45a !important;
            box-shadow: 0 3px 12px rgba(255, 193, 7, 0.18);
        }
        .navbar-custom { padding: 14px 0; border-bottom: 1px solid #343a40; }
        .navbar-custom .navbar-brand { font-size: 1.12rem; white-space: nowrap; }
        .navbar-custom .nav-link-item { padding: 9px 12px !important; margin: 0; gap: 4px; white-space: nowrap; }
        .navbar-custom .navbar-collapse { gap: 16px; }
        .navbar-custom .navbar-toggler:focus { box-shadow: 0 0 0 3px #ffd45a66; }
        @media (max-width: 1199px) and (min-width: 992px) {
            .navbar-custom .navbar-brand { margin-right: 12px !important; font-size: 1rem; }
            .navbar-custom .nav-link-item { padding: 9px 8px !important; font-size: .85rem; }
        }
        @media (max-width: 991px) {
            .navbar-custom .navbar-collapse { padding-top: 16px; }
            .navbar-custom .navbar-nav { align-items: stretch !important; }
            .navbar-custom .nav-link-item { display: flex; }
            .navbar-custom .navbar-nav.ms-auto { margin-top: 12px; }
        }
    </style>
</head>
<body>

    <c:set var="reqUri" value="${requestScope.navigationPath_24162067}"/>
    <c:set var="isHome" value="${reqUri == '/home' or reqUri == '/'}"/>
    <c:set var="isProducts" value="${reqUri == '/products' or reqUri.contains('/book-detail')}"/>
    <c:set var="isOrder" value="${reqUri.contains('/order-history')}"/>
    <c:set var="isCart" value="${reqUri.contains('/cart') or reqUri.contains('/checkout')}"/>
    <c:set var="isAdmin" value="${reqUri.contains('/admin')}"/>

    <!-- Header Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top shadow">
        <div class="container">
            <a class="navbar-brand fw-bold me-4" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-book-bookmark text-warning me-2 fs-4"></i>BOOK STORE <span class="badge bg-warning text-dark fs-6">24162067</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain" aria-controls="navbarMain" aria-expanded="false" aria-label="Mở menu">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarMain">
                <!-- Compact Main Menu Group -->
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 d-flex align-items-center gap-1">
                    <li class="nav-item">
                        <a class="nav-link nav-link-item ${isHome ? 'active-yellow' : ''}" aria-current="${isHome ? 'page' : 'false'}" href="${pageContext.request.contextPath}/home">
                            <i class="fa-solid fa-house me-1"></i>Trang Chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-item ${isProducts ? 'active-yellow' : ''}" aria-current="${isProducts ? 'page' : 'false'}" href="${pageContext.request.contextPath}/products">
                            <i class="fa-solid fa-book me-1"></i>Sản Phẩm
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-item ${isOrder ? 'active-yellow' : ''}" aria-current="${isOrder ? 'page' : 'false'}" href="${pageContext.request.contextPath}/order-history">
                            <i class="fa-solid fa-box-archive me-1"></i>Đơn Hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-item ${isCart ? 'active-yellow' : ''}" aria-current="${isCart ? 'page' : 'false'}" href="${pageContext.request.contextPath}/cart">
                            <i class="fa-solid fa-cart-shopping me-1"></i>Giỏ Hàng
                            <span id="cart-nav-count" class="badge bg-danger rounded-pill ms-1">${sessionScope.cart_24162067 != null ? sessionScope.cart_24162067.totalItems : 0}</span>
                        </a>
                    </li>
                    <c:if test="${not empty sessionScope.account_24162067 and sessionScope.account_24162067.isAdmin}">
                        <li class="nav-item">
                            <a class="nav-link nav-link-item ${isAdmin ? 'active-yellow' : ''}" href="${pageContext.request.contextPath}/admin/home">
                                <i class="fa-solid fa-user-shield me-1 text-warning"></i>Trang Quản Trị
                            </a>
                        </li>
                    </c:if>
                </ul>

                <!-- Right Profile / Auth Group -->
                <ul class="navbar-nav ms-auto align-items-center">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account_24162067}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle text-light nav-link-item fw-semibold" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fa-solid fa-user-circle text-warning fs-5 me-1"></i>
                                    <c:out value="${sessionScope.account_24162067.fullname != null ? sessionScope.account_24162067.fullname : sessionScope.account_24162067.email}"/>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/order-history"><i class="fa-solid fa-clock-rotate-left me-2 text-primary"></i>Lịch Sử Đơn Hàng</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket me-2 text-danger"></i>Đăng Xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item me-2">
                                <a class="btn btn-outline-warning btn-sm fw-bold px-3" href="${pageContext.request.contextPath}/login"><i class="fa-solid fa-right-to-bracket me-1"></i>Đăng Nhập</a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-warning btn-sm fw-bold text-dark px-3" href="${pageContext.request.contextPath}/register"><i class="fa-solid fa-user-plus me-1"></i>Đăng Ký</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content Area -->
    <div class="main-content container py-4">
        ${pageContent_24162067}
    </div>

    <!-- Mandatory Footer Display Requirement -->
    <footer class="footer-custom text-center">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-4 text-md-start mb-2 mb-md-0">
                    <h5 class="fw-bold m-0 text-warning"><i class="fa-solid fa-award me-2"></i>BÀI THI QUÁ TRÌNH 01</h5>
                </div>
                <div class="col-md-8 text-md-end">
                    <p class="m-0 fs-6">
                        <strong>Họ tên sinh viên:</strong> Nguyễn Đình Lĩnh | 
                        <strong>MSSV:</strong> <span class="badge bg-warning text-dark fs-6">24162067</span> | 
                        <strong>Mã đề:</strong> <span class="badge bg-info text-dark fs-6">01</span>
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

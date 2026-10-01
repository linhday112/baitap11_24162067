<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Thanh Toán Đơn Hàng COD - 24162067</title>
</head>

<div class="row mb-4 align-items-center">
    <div class="col-md-8">
        <h2 class="fw-bold text-primary"><i class="fa-solid fa-credit-card me-2"></i>Thanh Toán Đơn Hàng (COD)</h2>
        <p class="text-muted">Vui lòng kiểm tra thông tin giao hàng và sản phẩm trước khi đặt hàng</p>
    </div>
    <div class="col-md-4 text-end">
        <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary">
            <i class="fa-solid fa-cart-shopping me-1"></i>Quay lại giỏ hàng
        </a>
    </div>
</div>

<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fa-solid fa-circle-exclamation me-2"></i><c:out value="${error}"/>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<form action="${pageContext.request.contextPath}/checkout/process" method="post">
    <div class="row">
        <!-- Customer & Shipping Information -->
        <div class="col-lg-7 mb-4">
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-white py-3 border-0">
                    <h5 class="fw-bold m-0"><i class="fa-solid fa-address-card me-2 text-primary"></i>Thông Tin Nhận Hàng</h5>
                </div>
                <div class="card-body p-4">
                    <div class="mb-3">
                        <label for="recipientName" class="form-label fw-bold">Họ và tên người nhận <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="recipientName" name="recipientName" 
                               value="<c:out value='${user.fullname != null ? user.fullname : user.email}'/>" required placeholder="Nhập tên người nhận">
                    </div>
                    
                    <div class="mb-3">
                        <label for="recipientPhone" class="form-label fw-bold">Số điện thoại liên hệ <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="recipientPhone" name="recipientPhone" 
                               value="<c:out value='${user.phone}'/>" required placeholder="Nhập số điện thoại giao hàng">
                    </div>

                    <div class="mb-3">
                        <label for="address" class="form-label fw-bold">Địa chỉ giao hàng chi tiết <span class="text-danger">*</span></label>
                        <textarea class="form-control" id="address" name="address" rows="3" required placeholder="Nhập số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố"></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="note" class="form-label fw-bold">Ghi chú đơn hàng (Tùy chọn)</label>
                        <textarea class="form-control" id="note" name="note" rows="2" placeholder="Ví dụ: Giao giờ hành chính, gọi trước khi giao..."></textarea>
                    </div>
                </div>
            </div>

            <!-- Payment Method Card -->
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 border-0">
                    <h5 class="fw-bold m-0"><i class="fa-solid fa-wallet me-2 text-primary"></i>Phương Thức Thanh Toán</h5>
                </div>
                <div class="card-body p-4">
                    <div class="form-check p-3 border rounded bg-light d-flex align-items-center">
                        <input class="form-check-input me-3 fs-5" type="radio" name="paymentMethod" id="codPayment" value="COD" checked readOnly>
                        <label class="form-check-label w-100" for="codPayment">
                            <div class="fw-bold text-dark fs-6"><i class="fa-solid fa-hand-holding-dollar text-success me-2"></i>Thanh toán khi nhận hàng (COD)</div>
                            <div class="text-muted small">Bạn chỉ cần thanh toán tiền mặt trực tiếp cho nhân viên giao hàng khi nhận và kiểm tra sách.</div>
                        </label>
                    </div>
                </div>
            </div>
        </div>

        <!-- Order Summary Column -->
        <div class="col-lg-5">
            <div class="card shadow-sm border-0 sticky-top" style="top: 80px;">
                <div class="card-header bg-primary text-white py-3 border-0">
                    <h5 class="fw-bold m-0"><i class="fa-solid fa-box-open me-2"></i>Sản Phẩm Thanh Toán (${cart.totalItems})</h5>
                </div>
                <div class="card-body p-4">
                    <div class="checkout-items mb-3" style="max-height: 280px; overflow-y: auto;">
                        <c:forEach var="item" items="${cart.items}">
                            <div class="d-flex align-items-center mb-3 pb-2 border-bottom">
                                <c:choose>
                                    <c:when test="${not empty item.book.coverImage}">
                                        <img src="${item.book.coverImage}" class="rounded me-3" style="width: 50px; height: 65px; object-fit: cover;" alt="${item.book.title}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=100&q=80" class="rounded me-3" style="width: 50px; height: 65px; object-fit: cover;" alt="${item.book.title}">
                                    </c:otherwise>
                                </c:choose>
                                <div class="flex-grow-1">
                                    <div class="fw-bold text-dark small"><c:out value="${item.book.title}"/></div>
                                    <div class="text-muted small">SL: ${item.quantity} x <fmt:formatNumber value="${item.book.price}" pattern="#,##0"/> VNĐ</div>
                                </div>
                                <div class="fw-bold text-danger small">
                                    <fmt:formatNumber value="${item.totalPrice}" pattern="#,##0"/> VNĐ
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Tạm tính:</span>
                        <span class="fw-bold"><fmt:formatNumber value="${cart.totalAmount}" pattern="#,##0"/> VNĐ</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Phí vận chuyển:</span>
                        <span class="text-success fw-bold">MIỄN PHÍ</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="fs-5 fw-bold">Tổng tiền COD:</span>
                        <span class="fs-3 fw-bold text-danger"><fmt:formatNumber value="${cart.totalAmount}" pattern="#,##0"/> VNĐ</span>
                    </div>

                    <button type="submit" class="btn btn-success btn-lg w-100 fw-bold shadow-sm">
                        <i class="fa-solid fa-check-circle me-2"></i>Xác Nhận Đặt Hàng (COD)
                    </button>
                </div>
            </div>
        </div>
    </div>
</form>

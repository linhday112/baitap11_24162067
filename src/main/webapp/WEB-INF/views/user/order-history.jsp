<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Lịch Sử Đặt Hàng - 24162067</title>
</head>
<style>
    .order-history { --order-ink: #253449; --order-muted: #788494; }
    .order-hero { padding: 28px; border: 1px solid #e7eaf0; border-radius: 20px; background: linear-gradient(115deg, #fff 60%, #fff6d8); }
    .order-hero h2 { color: var(--order-ink) !important; font-size: clamp(1.5rem, 3vw, 2rem); letter-spacing: -.6px; }
    .order-hero h2 i { color: #c58b13; }
    .order-hero p { margin: 8px 0 0; }
    .order-hero .btn { border-radius: 10px; background: #fff; padding: 10px 16px; }
    .order-filters { border-radius: 16px; box-shadow: 0 4px 16px #25344906 !important; }
    .order-filters .nav { flex-wrap: nowrap; overflow-x: auto; padding: 4px; }
    .order-filters .nav-link { white-space: nowrap; font-size: .86rem; border: 1px solid transparent; }
    .order-filters .nav-link:hover { background: #fff8e1; }
    .order-card { border: 1px solid #e7ebf0 !important; border-radius: 18px; overflow: hidden; box-shadow: 0 5px 22px #25344908 !important; }
    .order-card .card-header { background: #fcfdff !important; padding: 18px 24px !important; gap: 12px; border-color: #edf0f4 !important; }
    .order-card .card-header > div:first-child { display: flex; flex-wrap: wrap; align-items: center; gap: 8px; }
    .order-card .card-header .badge { border-radius: 8px; }
    .order-card .card-header .badge.bg-primary { background: #fff1bd !important; color: #805500; font-size: .85rem !important; }
    .order-recipient { background: #f6f8fb !important; border: 0 !important; border-radius: 12px !important; line-height: 1.8; }
    .order-card .table td { padding: 14px 8px; }
    .order-card .table td.text-end { white-space: nowrap; }
    .order-card .table .border-bottom { border-color: #edf0f4 !important; }
    .order-card .card-footer { background: #fcfdff !important; padding: 18px 24px !important; gap: 12px; border-color: #edf0f4 !important; }
    .order-card .card-footer .btn { border-radius: 8px; }
    .order-card .card-footer .text-danger { color: #bc483b !important; }
    .order-cover { box-shadow: 0 3px 8px #25344914; background: #f3f5f8; }
    @media (max-width: 575px) {
        .order-hero { padding: 22px 18px; }
        .order-hero .text-end { text-align: left !important; margin-top: 18px; }
        .order-card .card-body { padding: 16px !important; }
        .order-card .card-header, .order-card .card-footer { padding: 16px !important; }
        .order-filters .nav { flex-direction: row !important; }
        .order-card .card-footer > .fs-5 { width: 100%; display: flex; justify-content: space-between; flex-wrap: wrap; }
    }
</style>
<section class="order-history" aria-label="Lịch sử đặt hàng">

<div class="row mx-0 mb-4 align-items-center order-hero">
    <div class="col-md-8">
        <h2 class="fw-bold text-primary"><i class="fa-solid fa-clock-rotate-left me-2"></i>Lịch Sử Đặt Hàng</h2>
        <p class="text-muted">Theo dõi và quản lý các đơn hàng bạn đã mua</p>
    </div>
    <div class="col-md-4 text-end">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
            <i class="fa-solid fa-store me-1"></i>Tiếp tục mua sắm
        </a>
    </div>
</div>

<!-- Display Flash Alerts -->
<c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show mb-4 p-4 shadow-sm border-0 border-start border-5 border-success" role="alert">
        <div class="d-flex align-items-center">
            <i class="fa-solid fa-circle-check fa-3x text-success me-3"></i>
            <div>
                <h4 class="fw-bold text-success m-0 mb-1"><i class="fa-solid fa-heart text-danger me-1"></i>Đặt hàng thành công! Cảm ơn bạn đã đặt hàng.</h4>
                <p class="m-0 text-dark fs-6"><c:out value="${success}"/></p>
            </div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
        <i class="fa-solid fa-circle-exclamation me-2"></i><c:out value="${error}"/>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- Status Filter Tabs -->
<div class="card shadow-sm border-0 mb-4 order-filters">
    <div class="card-body p-2">
        <div class="nav nav-pills flex-column flex-sm-row gap-1">
            <c:forEach var="st" items="${statusList}">
                <a href="${pageContext.request.contextPath}/order-history?status=${st}" 
                   class="nav-link text-center px-3 py-2 rounded-3 ${currentStatus == st ? 'bg-warning text-dark fw-bold shadow-sm border border-warning' : 'text-dark hover-light'}">
                    <c:out value="${st}"/>
                </a>
            </c:forEach>
        </div>
    </div>
</div>

<!-- Order List Section -->
<c:choose>
    <c:when test="${empty orders}">
        <div class="card shadow-sm border-0 text-center p-5">
            <div class="card-body">
                <i class="fa-solid fa-box-open fa-4x text-muted mb-3"></i>
                <h4 class="fw-bold text-secondary">Không tìm thấy đơn hàng nào!</h4>
                <p class="text-muted">Không có đơn hàng nào khớp với trạng thái "<strong><c:out value="${currentStatus}"/></strong>".</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary px-4 py-2 mt-2">
                    <i class="fa-solid fa-cart-plus me-1"></i>Mua Sách Ngay
                </a>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <c:forEach var="order" items="${orders}">
            <div class="card shadow-sm border-0 mb-4 order-card">
                <div class="card-header bg-white py-3 d-flex flex-wrap justify-content-between align-items-center border-bottom">
                    <div>
                        <span class="fw-bold fs-6 text-dark me-3">Đơn hàng #<c:out value="${order.id}"/></span>
                        <span class="text-muted small me-3">
                            <i class="fa-regular fa-calendar me-1"></i>
                            <c:if test="${not empty order.orderDate}">
                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </c:if>
                        </span>
                        <span class="badge bg-secondary"><i class="fa-solid fa-money-bill-wave me-1"></i><c:out value="${order.paymentMethod}"/></span>
                    </div>
                    <div>
                        <c:choose>
                            <c:when test="${order.status == 'Đơn hàng mới'}"><span class="badge bg-primary px-3 py-2 fs-6"><i class="fa-solid fa-sparkles me-1"></i>Đơn hàng mới</span></c:when>
                            <c:when test="${order.status == 'Đã xác nhận'}"><span class="badge bg-info text-dark px-3 py-2 fs-6"><i class="fa-solid fa-check me-1"></i>Đã xác nhận</span></c:when>
                            <c:when test="${order.status == 'Chuẩn bị hàng'}"><span class="badge bg-warning text-dark px-3 py-2 fs-6"><i class="fa-solid fa-box-archive me-1"></i>Chuẩn bị hàng</span></c:when>
                            <c:when test="${order.status == 'Vận chuyển'}"><span class="badge bg-secondary px-3 py-2 fs-6"><i class="fa-solid fa-truck me-1"></i>Vận chuyển</span></c:when>
                            <c:when test="${order.status == 'Giao hàng'}"><span class="badge bg-dark px-3 py-2 fs-6"><i class="fa-solid fa-motorcycle me-1"></i>Giao hàng</span></c:when>
                            <c:when test="${order.status == 'Đã giao'}"><span class="badge bg-success px-3 py-2 fs-6"><i class="fa-solid fa-circle-check me-1"></i>Đã giao</span></c:when>
                            <c:when test="${order.status == 'Đơn hàng hủy'}"><span class="badge bg-danger px-3 py-2 fs-6"><i class="fa-solid fa-ban me-1"></i>Đơn hàng hủy</span></c:when>
                            <c:when test="${order.status == 'Đơn hàng hoàn'}"><span class="badge bg-dark text-warning px-3 py-2 fs-6"><i class="fa-solid fa-rotate-left me-1"></i>Đơn hàng hoàn</span></c:when>
                            <c:otherwise><span class="badge bg-secondary px-3 py-2 fs-6"><c:out value="${order.status}"/></span></c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="card-body p-4">
                    <!-- Recipient Details -->
                    <div class="row mx-0 mb-3 p-3 bg-light rounded border text-muted small order-recipient">
                        <div class="col-md-4 mb-2 mb-md-0">
                            <strong>Người nhận:</strong> <span class="text-dark fw-semibold"><c:out value="${order.recipientName}"/></span>
                        </div>
                        <div class="col-md-3 mb-2 mb-md-0">
                            <strong>SĐT:</strong> <span class="text-dark fw-semibold"><c:out value="${order.recipientPhone}"/></span>
                        </div>
                        <div class="col-md-5">
                            <strong>Địa chỉ:</strong> <span class="text-dark fw-semibold"><c:out value="${order.address}"/></span>
                        </div>
                        <c:if test="${not empty order.note}">
                            <div class="col-12 mt-2 pt-2 border-top">
                                <strong>Ghi chú:</strong> <em><c:out value="${order.note}"/></em>
                            </div>
                        </c:if>
                    </div>

                    <!-- Items Table -->
                    <div class="table-responsive">
                        <table class="table table-borderless align-middle mb-0">
                            <tbody>
                                <c:forEach var="item" items="${order.items}">
                                    <tr class="border-bottom">
                                        <td style="width: 60px;">
                                            <c:choose>
                                                <c:when test="${not empty item.book and not empty item.book.coverImage}">
                                                    <img src="${item.book.coverImage}" class="rounded order-cover" style="width: 50px; height: 65px; object-fit: cover;" alt="<c:out value='${item.book.title}'/>" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/book-placeholder.svg';">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/images/book-placeholder.svg" class="rounded order-cover" style="width: 50px; height: 65px; object-fit: cover;" alt="Bìa sách">
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-dark"><c:out value="${not empty item.book ? item.book.title : 'Sách đã mua'}"/></div>
                                            <div class="text-muted small">ISBN: <c:out value="${not empty item.book ? item.book.isbn : 'N/A'}"/></div>
                                        </td>
                                        <td class="text-end" style="width: 150px;">
                                            <div class="text-muted small">
                                                Đơn giá: 
                                                <c:if test="${not empty item.price}">
                                                    <fmt:formatNumber value="${item.price}" pattern="#,##0"/> VNĐ
                                                </c:if>
                                            </div>
                                            <div class="fw-semibold">SL: <c:out value="${item.quantity}"/></div>
                                        </td>
                                        <td class="text-end fw-bold text-danger" style="width: 140px;">
                                            <c:if test="${not empty item.totalPrice}">
                                                <fmt:formatNumber value="${item.totalPrice}" pattern="#,##0"/> VNĐ
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="card-footer bg-white py-3 d-flex flex-wrap justify-content-between align-items-center border-top">
                    <div>
                        <c:if test="${order.status == 'Đơn hàng mới'}">
                            <form action="${pageContext.request.contextPath}/order-history/cancel" method="post" class="d-inline">
                                <input type="hidden" name="orderId" value="${order.id}"/>
                                <button type="submit" class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${order.id}?');">
                                    <i class="fa-solid fa-xmark me-1"></i>Hủy đơn hàng
                                </button>
                            </form>
                        </c:if>
                    </div>
                    <div class="fs-5">
                        <span class="text-muted fs-6 me-2">Tổng tiền thanh toán COD:</span>
                        <span class="fw-bold text-danger fs-4"><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> VNĐ</span>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>
</section>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Quản Lý Đơn Hàng - Admin 24162067</title>
</head>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h2 class="fw-bold text-dark"><i class="fa-solid fa-boxes-packing me-2 text-primary"></i>Quản Lý Đơn Hàng</h2>
        <p class="text-muted m-0">Quản lý, xem chi tiết và thay đổi trạng thái tất cả đơn hàng của hệ thống</p>
    </div>
</div>

<c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show mb-4 shadow-sm" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i><c:out value="${success}"/>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- Status Filter Pills -->
<div class="card shadow-sm border-0 mb-4">
    <div class="card-body p-2">
        <div class="nav nav-pills flex-column flex-sm-row gap-1">
            <c:forEach var="st" items="${statusList}">
                <a href="${pageContext.request.contextPath}/admin/orders?status=${st}" 
                   class="nav-link text-center px-3 py-2 ${currentStatus == st ? 'active bg-primary text-white fw-bold' : 'text-dark hover-light'}">
                    <c:out value="${st}"/>
                </a>
            </c:forEach>
        </div>
    </div>
</div>

<div class="card shadow-sm border-0">
    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
            <thead class="table-light">
                <tr>
                    <th>Mã Đơn</th>
                    <th>Khách Hàng</th>
                    <th>Ngày Đặt</th>
                    <th>Tổng Tiền</th>
                    <th>Phương Thức</th>
                    <th>Trạng Thái</th>
                    <th class="text-center">Hành Động</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach var="o" items="${orders}">
                            <tr>
                                <td class="fw-bold text-primary">#<c:out value="${o.id}"/></td>
                                <td>
                                    <div class="fw-bold"><c:out value="${o.recipientName}"/></div>
                                    <div class="text-muted small"><i class="fa-solid fa-phone me-1"></i><c:out value="${o.recipientPhone}"/></div>
                                </td>
                                <td class="small text-nowrap"><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td class="fw-bold text-danger"><fmt:formatNumber value="${o.totalAmount}" pattern="#,##0"/> VNĐ</td>
                                <td><span class="badge bg-secondary"><c:out value="${o.paymentMethod}"/></span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${o.status == 'Đơn hàng mới'}"><span class="badge bg-warning text-dark fs-6"><i class="fa-solid fa-clock me-1"></i>Đơn hàng mới</span></c:when>
                                        <c:when test="${o.status == 'Đã xác nhận'}"><span class="badge bg-info text-white fs-6"><i class="fa-solid fa-check me-1"></i>Đã xác nhận</span></c:when>
                                        <c:when test="${o.status == 'Chuẩn bị hàng'}"><span class="badge bg-primary fs-6"><i class="fa-solid fa-box me-1"></i>Chuẩn bị hàng</span></c:when>
                                        <c:when test="${o.status == 'Vận chuyển'}"><span class="badge bg-primary fs-6"><i class="fa-solid fa-truck me-1"></i>Vận chuyển</span></c:when>
                                        <c:when test="${o.status == 'Giao hàng'}"><span class="badge bg-primary fs-6"><i class="fa-solid fa-truck-ramp-box me-1"></i>Giao hàng</span></c:when>
                                        <c:when test="${o.status == 'Đã giao'}"><span class="badge bg-success fs-6"><i class="fa-solid fa-circle-check me-1"></i>Đã giao</span></c:when>
                                        <c:when test="${o.status == 'Đơn hàng hủy'}"><span class="badge bg-danger fs-6"><i class="fa-solid fa-ban me-1"></i>Đơn hàng hủy</span></c:when>
                                        <c:otherwise><span class="badge bg-secondary fs-6"><c:out value="${o.status}"/></span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center justify-content-center gap-2">
                                        <!-- View Details Button -->
                                        <button type="button" class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#orderModal${o.id}" title="Xem chi tiết đơn hàng">
                                            <i class="fa-solid fa-eye me-1"></i>Chi Tiết
                                        </button>

                                        <!-- Update Status Form -->
                                        <form action="${pageContext.request.contextPath}/admin/orders/update-status" method="post" class="d-flex gap-1 align-items-center">
                                            <input type="hidden" name="orderId" value="${o.id}"/>
                                            <select name="status" class="form-select form-select-sm" style="width: 140px; font-size: 0.85rem;">
                                                <c:forEach var="s" items="${statusList}">
                                                    <c:if test="${s != 'Tất cả'}">
                                                        <option value="${s}" ${o.status == s ? 'selected' : ''}><c:out value="${s}"/></option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                            <button type="submit" class="btn btn-sm btn-primary" title="Cập nhật trạng thái">
                                                <i class="fa-solid fa-floppy-disk"></i>
                                            </button>
                                        </form>
                                    </div>

                                    <!-- Order Details Modal -->
                                    <div class="modal fade" id="orderModal${o.id}" tabindex="-1" aria-labelledby="orderModalLabel${o.id}" aria-hidden="true">
                                        <div class="modal-dialog modal-lg modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header bg-light">
                                                    <h5 class="modal-title fw-bold text-dark" id="orderModalLabel${o.id}">
                                                        <i class="fa-solid fa-receipt text-primary me-2"></i>Chi Tiết Đơn Hàng #${o.id}
                                                    </h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body p-4 text-start">
                                                    <div class="row g-3 mb-4">
                                                        <div class="col-md-6">
                                                            <div class="p-3 border rounded bg-light">
                                                                <h6 class="fw-bold text-primary mb-2"><i class="fa-solid fa-user me-2"></i>Thông Tin Người Nhận</h6>
                                                                <p class="mb-1"><strong>Họ tên:</strong> <c:out value="${o.recipientName}"/></p>
                                                                <p class="mb-1"><strong>Điện thoại:</strong> <c:out value="${o.recipientPhone}"/></p>
                                                                <p class="mb-1"><strong>Địa chỉ:</strong> <c:out value="${o.address}"/></p>
                                                                <p class="mb-0"><strong>Tài khoản đặt:</strong> <c:out value="${o.user.fullname}"/> (<c:out value="${o.user.email}"/>)</p>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="p-3 border rounded bg-light">
                                                                <h6 class="fw-bold text-primary mb-2"><i class="fa-solid fa-circle-info me-2"></i>Thông Tin Đơn Hàng</h6>
                                                                <p class="mb-1"><strong>Ngày đặt:</strong> <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/></p>
                                                                <p class="mb-1"><strong>Thanh toán:</strong> <span class="badge bg-secondary"><c:out value="${o.paymentMethod}"/></span></p>
                                                                <p class="mb-1"><strong>Trạng thái:</strong> <span class="badge bg-primary"><c:out value="${o.status}"/></span></p>
                                                                <p class="mb-0"><strong>Ghi chú:</strong> <c:out value="${empty o.note ? 'Không có' : o.note}"/></p>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <h6 class="fw-bold text-dark mb-3"><i class="fa-solid fa-book me-2 text-primary"></i>Danh Sách Sản Phẩm Đã Đặt</h6>
                                                    <div class="table-responsive border rounded mb-3">
                                                        <table class="table table-borderless table-striped align-middle mb-0">
                                                            <thead class="table-light">
                                                                <tr>
                                                                    <th>Sách</th>
                                                                    <th class="text-center">Số Lượng</th>
                                                                    <th class="text-end">Đơn Giá</th>
                                                                    <th class="text-end">Thành Tiền</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="item" items="${o.items}">
                                                                    <tr>
                                                                        <td>
                                                                            <div class="d-flex align-items-center gap-2">
                                                                                <c:choose>
                                                                                    <c:when test="${not empty item.book.coverImage}">
                                                                                        <img src="${item.book.coverImage}" alt="cover" style="width: 40px; height: 55px; object-fit: cover;" class="rounded shadow-sm"/>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <img src="${pageContext.request.contextPath}/static/images/book-placeholder.svg" alt="placeholder" style="width: 40px; height: 55px; object-fit: cover;" class="rounded shadow-sm"/>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                                <div>
                                                                                    <div class="fw-bold"><c:out value="${item.book.title}"/></div>
                                                                                    <div class="small text-muted">ISBN: <c:out value="${item.book.isbn}"/></div>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                        <td class="text-center fw-bold"><c:out value="${item.quantity}"/></td>
                                                                        <td class="text-end"><fmt:formatNumber value="${item.price}" pattern="#,##0"/> VNĐ</td>
                                                                        <td class="text-end fw-bold text-danger"><fmt:formatNumber value="${item.totalPrice}" pattern="#,##0"/> VNĐ</td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                    <div class="d-flex justify-content-end align-items-center p-3 bg-light rounded">
                                                        <h5 class="mb-0 fw-bold">Tổng Thanh Toán: <span class="text-danger"><fmt:formatNumber value="${o.totalAmount}" pattern="#,##0"/> VNĐ</span></h5>
                                                    </div>
                                                </div>
                                                <div class="modal-footer bg-light">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">Không tìm thấy đơn hàng nào.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

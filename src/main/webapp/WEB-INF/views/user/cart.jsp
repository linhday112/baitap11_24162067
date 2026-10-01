<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Giỏ Hàng Của Bạn - 24162067</title>
</head>

<div class="row mb-4 align-items-center">
    <div class="col-md-8">
        <h2 class="fw-bold text-primary"><i class="fa-solid fa-cart-shopping me-2"></i>Giỏ Hàng Của Bạn</h2>
        <p class="text-muted">Quản lý các sản phẩm bạn đã chọn trước khi thanh toán</p>
    </div>
    <div class="col-md-4 text-end">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
            <i class="fa-solid fa-arrow-left me-1"></i>Tiếp tục mua hàng
        </a>
    </div>
</div>

<!-- Display Flash Alerts -->
<c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i><c:out value="${success}"/>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fa-solid fa-circle-exclamation me-2"></i><c:out value="${error}"/>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:choose>
    <c:when test="${empty cart or empty cart.items}">
        <div class="card shadow-sm border-0 text-center p-5">
            <div class="card-body">
                <i class="fa-solid fa-cart-flatbed fa-4x text-muted mb-3"></i>
                <h4 class="fw-bold text-secondary">Giỏ hàng của bạn đang trống!</h4>
                <p class="text-muted">Hãy khám phá kho sách và thêm sản phẩm bạn yêu thích vào giỏ nhé.</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary px-4 py-2 mt-2">
                    <i class="fa-solid fa-store me-1"></i>Khám Phá Sản Phẩm Ngay
                </a>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="row">
            <div class="col-lg-8 mb-4">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white py-3 border-0">
                        <h5 class="fw-bold m-0"><i class="fa-solid fa-list me-2 text-primary"></i>Danh Sách Sản Phẩm (<span id="cart-list-count">${cart.totalItems}</span> món)</h5>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th style="width: 100px;">Hình ảnh</th>
                                    <th>Sách</th>
                                    <th style="width: 130px;">Đơn giá</th>
                                    <th style="width: 150px;">Số lượng</th>
                                    <th style="width: 130px;" class="text-end">Thành tiền</th>
                                    <th style="width: 60px;" class="text-center">Xóa</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cart.items}">
                                    <tr data-cart-book="${item.book.bookid}">
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty item.book.coverImage}">
                                                    <img src="${item.book.coverImage}" class="rounded" style="width: 60px; height: 80px; object-fit: cover;" alt="${item.book.title}">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=100&q=80" class="rounded" style="width: 60px; height: 80px; object-fit: cover;" alt="${item.book.title}">
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/book-detail?id=${item.book.bookid}" class="fw-bold text-dark text-decoration-none">
                                                <c:out value="${item.book.title}"/>
                                            </a>
                                            <div class="text-muted small mt-1">
                                                ISBN: <c:out value="${item.book.isbn}"/> | 
                                                Tồn kho: <span class="badge bg-secondary cart-stock"><c:out value="${item.book.quantity}"/></span>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="fw-semibold text-danger cart-price"><fmt:formatNumber value="${item.book.price}" pattern="#,##0"/> VNĐ</span>
                                        </td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/cart/update" method="post" class="cart-quantity-form d-flex align-items-center">
                                                <input type="hidden" name="bookid" value="${item.book.bookid}"/>
                                                <div class="input-group input-group-sm">
                                                    <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.book.quantity}" 
                                                           class="form-control text-center px-1 cart-quantity" data-saved="${item.quantity}" aria-label="Số lượng sách" style="max-width: 80px;" required/>
                                                </div>
                                            </form>
                                        </td>
                                        <td class="text-end fw-bold text-danger cart-item-total">
                                            <fmt:formatNumber value="${item.totalPrice}" pattern="#,##0"/> VNĐ
                                        </td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/cart/remove?bookid=${item.book.bookid}" 
                                               class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa cuốn sách này khỏi giỏ hàng?');" title="Xóa sản phẩm">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer bg-white border-top-0 d-flex justify-content-between py-3">
                        <a href="${pageContext.request.contextPath}/cart/clear" class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa toàn bộ giỏ hàng?');">
                            <i class="fa-solid fa-broom me-1"></i>Xóa toàn bộ giỏ hàng
                        </a>
                        <span class="text-muted small align-self-center">* Số lượng tối đa đặt mua bị giới hạn bởi tồn kho thực tế của cuốn sách.</span>
                    </div>
                </div>
            </div>

            <!-- Cart Summary & Checkout Action -->
            <div class="col-lg-4">
                <div class="card shadow-sm border-0 sticky-top" style="top: 80px;">
                    <div class="card-header bg-primary text-white py-3 border-0">
                        <h5 class="fw-bold m-0"><i class="fa-solid fa-receipt me-2"></i>Tóm Tắt Đơn Hàng</h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Tổng số món:</span>
                            <span class="fw-bold"><span id="cart-summary-count">${cart.totalItems}</span> sản phẩm</span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Hình thức thanh toán:</span>
                            <span class="badge bg-success">COD (Khi nhận hàng)</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="fs-5 fw-bold">Tổng thanh toán:</span>
                            <span id="cart-total" class="fs-4 fw-bold text-danger" aria-live="polite"><fmt:formatNumber value="${cart.totalAmount}" pattern="#,##0"/> VNĐ</span>
                        </div>
                        <p id="cart-update-message" class="small mb-2" role="status" aria-live="polite"></p>
                        <a id="cart-checkout" href="${pageContext.request.contextPath}/checkout" class="btn btn-success btn-lg w-100 fw-bold shadow-sm">
                            <i class="fa-solid fa-truck-fast me-2"></i>Thanh Toán COD
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>
<script>
(() => {
    const inputs = Array.from(document.querySelectorAll('.cart-quantity'));
    const checkout = document.getElementById('cart-checkout');
    if (!checkout) return;
    const message = document.getElementById('cart-update-message');
    const pending = new Map();
    let timer;
    let saving = false;
    const money = value => new Intl.NumberFormat('en-US', { maximumFractionDigits: 0 }).format(value) + ' VNĐ';
    function updateCheckout() {
        const blocked = saving || pending.size > 0 || inputs.some(input => !input.checkValidity());
        checkout.classList.toggle('disabled', blocked);
        checkout.setAttribute('aria-disabled', String(blocked));
    }
    async function savePending() {
        if (saving) return;
        saving = true;
        updateCheckout();
        try {
            while (pending.size) {
                const [input, quantity] = pending.entries().next().value;
                pending.delete(input);
                const row = input.closest('[data-cart-book]');
                message.className = 'small mb-2 text-muted';
                message.textContent = 'Đang cập nhật giỏ hàng…';
                try {
                    const response = await fetch('${pageContext.request.contextPath}/cart/update-quantity', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'Accept': 'application/json' },
                        body: new URLSearchParams({ bookid: row.dataset.cartBook, quantity }),
                        credentials: 'same-origin'
                    });
                    const data = await response.json();
                    if (!response.ok) throw new Error(data.error || 'Không thể cập nhật giỏ hàng.');
                    input.dataset.saved = data.quantity;
                    input.max = data.stock;
                    if (!pending.has(input)) input.value = data.quantity;
                    row.querySelector('.cart-stock').textContent = data.stock;
                    row.querySelector('.cart-price').textContent = money(data.price);
                    row.querySelector('.cart-item-total').textContent = money(data.itemTotal);
                    ['cart-list-count', 'cart-summary-count', 'cart-nav-count'].forEach(id => {
                        const element = document.getElementById(id);
                        if (element) element.textContent = data.totalItems;
                    });
                    document.getElementById('cart-total').textContent = money(data.totalAmount);
                    message.className = 'small mb-2 text-success';
                    message.textContent = 'Đã cập nhật giỏ hàng.';
                } catch (error) {
                    if (!pending.has(input)) input.value = input.dataset.saved;
                    message.className = 'small mb-2 text-danger';
                    message.textContent = error.message;
                }
            }
        } finally {
            saving = false;
            updateCheckout();
        }
    }
    function schedule(input) {
        if (input.checkValidity()) {
            pending.set(input, input.value);
            clearTimeout(timer);
            timer = setTimeout(savePending, 250);
        } else {
            pending.delete(input);
            message.className = 'small mb-2 text-danger';
            message.textContent = 'Vui lòng nhập số lượng từ 1 đến ' + input.max + '.';
        }
        updateCheckout();
    }
    inputs.forEach(input => {
        input.addEventListener('input', () => schedule(input));
        input.addEventListener('change', () => schedule(input));
        input.closest('form').addEventListener('submit', event => {
            event.preventDefault();
            schedule(input);
        });
    });
    checkout.addEventListener('click', event => {
        if (checkout.getAttribute('aria-disabled') === 'true') event.preventDefault();
    });
})();
</script>

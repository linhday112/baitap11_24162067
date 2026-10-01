<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Chi Tiết Sách - <c:out value="${book.title}"/></title>
</head>

<div class="row">
    <div class="col-md-12 mb-3">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
            <i class="fa-solid fa-arrow-left me-1"></i>Quay lại trang chủ
        </a>
    </div>

    <!-- Display Flash Alerts -->
    <c:if test="${not empty success}">
        <div class="col-md-12">
            <div class="alert alert-success alert-dismissible fade show mb-3" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i><c:out value="${success}"/>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="col-md-12">
            <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2"></i><c:out value="${error}"/>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
    </c:if>

    <!-- Book Information Section -->
    <div class="col-md-5">
        <div class="card shadow-sm border-0 mb-4">
            <c:choose>
                <c:when test="${not empty book.coverImage}">
                    <img src="${book.coverImage}" class="card-img-top img-fluid rounded" alt="${book.title}">
                </c:when>
                <c:otherwise>
                    <img src="https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80" class="card-img-top img-fluid rounded" alt="${book.title}">
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <div class="col-md-7">
        <div class="card shadow-sm border-0 p-4 mb-4">
            <h2 class="fw-bold text-dark"><c:out value="${book.title}"/></h2>
            <h4 class="text-danger fw-bold my-2"><fmt:formatNumber value="${book.price}" pattern="#,##0"/> VNĐ</h4>
            <hr>
            <table class="table table-borderless">
                <tr>
                    <th style="width: 140px;">Tiêu đề:</th>
                    <td><c:out value="${book.title}"/></td>
                </tr>
                <tr>
                    <th>Mã isbn:</th>
                    <td><c:out value="${book.isbn}"/></td>
                </tr>
                <tr>
                    <th>Tác giả:</th>
                    <td>
                        <c:forEach var="author" items="${book.authors}" varStatus="status">
                            <c:out value="${author.authorName}"/><c:if test="${!status.last}">, </c:if>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th>Publisher:</th>
                    <td><c:out value="${book.publisher}"/></td>
                </tr>
                <tr>
                    <th>Publisher_date:</th>
                    <td><fmt:formatDate value="${book.publishDate}" pattern="dd/MM/yyyy"/></td>
                </tr>
                <tr>
                    <th>Quantity:</th>
                    <td><span class="badge bg-secondary fs-6"><c:out value="${book.quantity}"/></span></td>
                </tr>
                <tr>
                    <th>Reviews (${reviewCount}):</th>
                    <td>
                        <span class="badge bg-success fs-6"><c:out value="${reviewCount}"/> đánh giá</span>
                    </td>
                </tr>
            </table>

            <!-- Add to Cart Form -->
            <div class="p-3 bg-light rounded border my-3">
                <form action="${pageContext.request.contextPath}/cart/add" method="post" class="row g-3 align-items-center">
                    <input type="hidden" name="bookid" value="${book.bookid}"/>
                    <div class="col-auto">
                        <label for="quantitySelect" class="col-form-label fw-bold">Số lượng chọn mua:</label>
                    </div>
                    <div class="col-auto">
                        <input type="number" id="quantitySelect" name="quantity" value="1" min="1" max="${book.quantity}" class="form-control" style="width: 100px;" ${book.quantity <= 0 ? 'disabled' : ''} required/>
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary px-4" ${book.quantity <= 0 ? 'disabled' : ''}>
                            <i class="fa-solid fa-cart-plus me-2"></i>Thêm Vào Giỏ Hàng
                        </button>
                    </div>
                    <c:if test="${book.quantity <= 0}">
                        <div class="text-danger small mt-1"><i class="fa-solid fa-circle-exclamation me-1"></i>Sản phẩm tạm thời hết hàng.</div>
                    </c:if>
                </form>
            </div>

            <div class="mt-3">
                <h5 class="fw-bold">Mô tả sản phẩm:</h5>
                <p class="text-muted"><c:out value="${book.description}"/></p>
            </div>
        </div>
    </div>
</div>

<!-- Reviews Section -->
<div class="row mt-4">
    <div class="col-md-12">
        <div class="card shadow-sm border-0 p-4 mb-4">
            <h3 class="fw-bold mb-3"><i class="fa-solid fa-comments me-2 text-primary"></i>Reviews</h3>
            
            <div class="review-list mb-4">
                <c:choose>
                    <c:when test="${not empty ratingList}">
                        <c:forEach var="r" items="${ratingList}">
                            <div class="p-3 mb-2 bg-light rounded border">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <strong><i class="fa-solid fa-user-circle me-1 text-secondary"></i>[<c:out value="${r.user.fullname != null ? r.user.fullname : r.user.email}"/>]:</strong>
                                    <span class="text-warning">
                                        <c:forEach begin="1" end="${r.rating}">★</c:forEach>
                                    </span>
                                </div>
                                <p class="mb-0 text-dark me-2">[<c:out value="${r.reviewText}"/>]</p>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted fst-italic">Chưa có đánh giá nào cho cuốn sách này.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Form Thêm Reviews -->
            <div class="border-top pt-4">
                <h4 class="fw-bold mb-3"><i class="fa-solid fa-pen me-2"></i>Form thêm reviews</h4>
                <c:choose>
                    <c:when test="${not empty sessionScope.account_24162067}">
                        <form action="${pageContext.request.contextPath}/add-review" method="post">
                            <input type="hidden" name="bookid" value="${book.bookid}"/>
                            <div class="mb-3">
                                <label for="rating" class="form-label fw-bold">Điểm đánh giá (1-5 sao):</label>
                                <select name="rating" id="rating" class="form-select" style="max-width: 200px;" required>
                                    <option value="5">5 Sao - Rất Tuyệt Vời</option>
                                    <option value="4">4 Sao - Tuyệt Vời</option>
                                    <option value="3">3 Sao - Bình Thường</option>
                                    <option value="2">2 Sao - Tạm Được</option>
                                    <option value="1">1 Sao - Tệ</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="review_text" class="form-label fw-bold">Nội dung đánh giá:</label>
                                <textarea name="review_text" id="review_text" class="form-control" rows="3" placeholder="Nhập cảm nhận của bạn về cuốn sách..." required></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary px-4">[Submit]</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info mb-0">
                            Vui lòng <a href="${pageContext.request.contextPath}/login" class="alert-link">Đăng Nhập</a> để có thể viết đánh giá cho sản phẩm này.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

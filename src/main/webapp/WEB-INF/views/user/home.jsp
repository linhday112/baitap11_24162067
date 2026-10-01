<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Trang Chủ - Danh Sách Sách (MSSV: 24162067)</title>
</head>

<!-- Display Flash Alerts -->
<c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
        <i class="fa-solid fa-circle-check me-2"></i><c:out value="${success}"/>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
        <i class="fa-solid fa-circle-exclamation me-2"></i><c:out value="${error}"/>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="row mb-4 align-items-center">
    <div class="col-md-8">
        <h2 class="fw-bold text-primary"><i class="fa-solid fa-book-open me-2"></i>Danh Sách Sách Nổi Bật</h2>
        <p class="text-muted">Hiển thị 6 sản phẩm mỗi trang (Tổng số sách: ${totalBooks})</p>
    </div>
</div>

<div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
    <c:forEach var="book" items="${bookList}">
        <div class="col">
            <div class="card book-card shadow-sm border-0">
                <div class="bg-light text-center p-3">
                    <c:choose>
                        <c:when test="${not empty book.coverImage}">
                            <img src="${book.coverImage}" class="card-img-top book-img rounded" alt="${book.title}">
                        </c:when>
                        <c:otherwise>
                            <img src="https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=400&q=80" class="card-img-top book-img rounded" alt="${book.title}">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="card-body">
                    <h5 class="card-title fw-bold">
                        <a href="${pageContext.request.contextPath}/book-detail?id=${book.bookid}" class="text-decoration-none text-dark hover-primary">
                            <c:out value="${book.title}"/>
                        </a>
                    </h5>
                    <ul class="list-group list-group-flush mb-3">
                        <li class="list-group-item px-0 py-1"><strong>Mã isbn:</strong> <c:out value="${book.isbn}"/></li>
                        <li class="list-group-item px-0 py-1">
                            <strong>Tác giả:</strong>
                            <c:forEach var="author" items="${book.authors}" varStatus="status">
                                <c:out value="${author.authorName}"/><c:if test="${!status.last}">, </c:if>
                            </c:forEach>
                        </li>
                        <li class="list-group-item px-0 py-1"><strong>Publisher:</strong> <c:out value="${book.publisher}"/></li>
                        <li class="list-group-item px-0 py-1"><strong>Publisher_date:</strong> <fmt:formatDate value="${book.publishDate}" pattern="dd/MM/yyyy"/></li>
                        <li class="list-group-item px-0 py-1"><strong>Giá bán:</strong> <span class="text-danger fw-bold"><fmt:formatNumber value="${book.price}" pattern="#,##0"/> VNĐ</span></li>
                        <li class="list-group-item px-0 py-1"><strong>Quantity:</strong> <span class="badge bg-secondary"><c:out value="${book.quantity}"/></span></li>
                        <li class="list-group-item px-0 py-1">
                            <strong>Review:</strong> 
                            <span class="badge bg-success"><c:out value="${book.ratings.size()}"/> đánh giá</span>
                        </li>
                    </ul>
                </div>
                <div class="card-footer bg-white border-top-0 pb-3 d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/book-detail?id=${book.bookid}" class="btn btn-outline-primary flex-fill">
                        <i class="fa-solid fa-circle-info me-1"></i>Chi tiết
                    </a>
                    <form action="${pageContext.request.contextPath}/cart/add" method="post" class="flex-fill">
                        <input type="hidden" name="bookid" value="${book.bookid}"/>
                        <input type="hidden" name="quantity" value="1"/>
                        <button type="submit" class="btn btn-primary w-100" ${book.quantity <= 0 ? 'disabled' : ''}>
                            <i class="fa-solid fa-cart-plus me-1"></i>Thêm giỏ
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<!-- Pagination Controls -->
<c:if test="${totalPages > 1}">
    <nav class="mt-5">
        <ul class="pagination justify-content-center">
            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}${requestScope.navigationPath_24162067 == '/products' ? '/products' : '/home'}?page=${currentPage - 1}">Trước</a>
            </li>
            <c:forEach var="i" begin="1" end="${totalPages}">
                <li class="page-item ${currentPage == i ? 'active' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}${requestScope.navigationPath_24162067 == '/products' ? '/products' : '/home'}?page=${i}">${i}</a>
                </li>
            </c:forEach>
            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}${requestScope.navigationPath_24162067 == '/products' ? '/products' : '/home'}?page=${currentPage + 1}">Sau</a>
            </li>
        </ul>
    </nav>
</c:if>

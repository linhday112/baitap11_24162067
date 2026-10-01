<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Quản Lý Sách - Admin (MSSV: 24162067)</title>
</head>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-dark"><i class="fa-solid fa-book-open me-2 text-primary"></i>Quản Lý Danh Sách Sách</h3>
    <a href="${pageContext.request.contextPath}/admin/books?action=add" class="btn btn-primary fw-bold">
        <i class="fa-solid fa-plus me-1"></i>Thêm Sách Mới
    </a>
</div>

<div class="card shadow-sm border-0">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Bìa</th>
                        <th>Tiêu đề</th>
                        <th>ISBN</th>
                        <th>NXB</th>
                        <th>Giá bán (VNĐ)</th>
                        <th>Số lượng</th>
                        <th>Tác giả</th>
                        <th class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="b" items="${bookList}">
                        <tr>
                            <td><strong>${b.bookid}</strong></td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty b.coverImage}">
                                        <img src="${b.coverImage}" width="45" height="60" class="rounded object-fit-cover" alt="cover">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=100&q=80" width="45" height="60" class="rounded object-fit-cover" alt="cover">
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><strong class="text-primary"><c:out value="${b.title}"/></strong></td>
                            <td><c:out value="${b.isbn}"/></td>
                            <td><c:out value="${b.publisher}"/></td>
                            <td><span class="text-danger fw-bold"><fmt:formatNumber value="${b.price}" pattern="#,##0"/> VNĐ</span></td>
                            <td><span class="badge bg-secondary"><c:out value="${b.quantity}"/></span></td>
                            <td>
                                <c:forEach var="a" items="${b.authors}" varStatus="st">
                                    <span class="badge bg-info text-dark"><c:out value="${a.authorName}"/></span>
                                </c:forEach>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/books?action=edit&id=${b.bookid}" class="btn btn-sm btn-outline-warning me-1" title="Sửa">
                                    <i class="fa-solid fa-pen-to-square"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/books?action=delete&id=${b.bookid}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa cuốn sách này không?');" title="Xóa">
                                    <i class="fa-solid fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty bookList}">
                        <tr>
                            <td colspan="9" class="text-center py-4 text-muted">Chưa có dữ liệu sách nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- Pagination -->
    <c:if test="${totalPages > 1}">
        <div class="card-footer bg-white py-3">
            <nav>
                <ul class="pagination justify-content-center mb-0">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/books?page=${currentPage - 1}">Trước</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/books?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/books?page=${currentPage + 1}">Sau</a>
                    </li>
                </ul>
            </nav>
        </div>
    </c:if>
</div>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Quản Lý Tác Giả - Admin (MSSV: 24162067)</title>
</head>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-dark"><i class="fa-solid fa-pen-nib me-2 text-success"></i>Quản Lý Danh Sách Tác Giả</h3>
    <a href="${pageContext.request.contextPath}/admin/authors?action=add" class="btn btn-success fw-bold">
        <i class="fa-solid fa-plus me-1"></i>Thêm Tác Giả Mới
    </a>
</div>

<div class="card shadow-sm border-0">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Tên tác giả</th>
                        <th>Ngày sinh</th>
                        <th class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="a" items="${authorList}">
                        <tr>
                            <td><strong>${a.authorId}</strong></td>
                            <td><strong class="text-dark"><c:out value="${a.authorName}"/></strong></td>
                            <td><fmt:formatDate value="${a.dateOfBirth}" pattern="dd/MM/yyyy"/></td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/authors?action=edit&id=${a.authorId}" class="btn btn-sm btn-outline-warning me-1">
                                    <i class="fa-solid fa-pen-to-square"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/authors?action=delete&id=${a.authorId}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa tác giả này không?');">
                                    <i class="fa-solid fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty authorList}">
                        <tr>
                            <td colspan="4" class="text-center py-4 text-muted">Chưa có dữ liệu tác giả nào.</td>
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
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/authors?page=${currentPage - 1}">Trước</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/authors?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/authors?page=${currentPage + 1}">Sau</a>
                    </li>
                </ul>
            </nav>
        </div>
    </c:if>
</div>

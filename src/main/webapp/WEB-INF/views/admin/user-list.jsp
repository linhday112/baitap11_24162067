<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title>Quản Lý Người Dùng - Admin (MSSV: 24162067)</title>
</head>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-dark"><i class="fa-solid fa-users-gear me-2 text-warning"></i>Quản Lý Người Dùng</h3>
    <a href="${pageContext.request.contextPath}/admin/users?action=add" class="btn btn-warning text-dark fw-bold">
        <i class="fa-solid fa-user-plus me-1"></i>Thêm Người Dùng Mới
    </a>
</div>

<div class="card shadow-sm border-0">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Email</th>
                        <th>Họ và tên</th>
                        <th>Số điện thoại</th>
                        <th>Vai trò</th>
                        <th>Ngày đăng ký</th>
                        <th class="text-center">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${userList}">
                        <tr>
                            <td><strong>${u.id}</strong></td>
                            <td><strong class="text-primary"><c:out value="${u.email}"/></strong></td>
                            <td><c:out value="${u.fullname}"/></td>
                            <td><c:out value="${u.phone}"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.isAdmin}">
                                        <span class="badge bg-danger"><i class="fa-solid fa-user-shield me-1"></i>Quản trị viên</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary"><i class="fa-solid fa-user me-1"></i>Khách hàng</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${u.signupDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/users?action=edit&id=${u.id}" class="btn btn-sm btn-outline-warning me-1">
                                    <i class="fa-solid fa-pen-to-square"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/users?action=delete&id=${u.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này không?');">
                                    <i class="fa-solid fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty userList}">
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">Chưa có dữ liệu người dùng nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

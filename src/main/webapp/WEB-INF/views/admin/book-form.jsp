<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
    <title><c:choose><c:when test="${not empty book}">Sửa Thông Tin Sách</c:when><c:otherwise>Thêm Sách Mới</c:otherwise></c:choose> - MSSV 24162067</title>
</head>

<div class="row justify-content-center">
    <div class="col-md-9">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-primary text-white py-3">
                <h4 class="mb-0 fw-bold">
                    <c:choose>
                        <c:when test="${not empty book}"><i class="fa-solid fa-pen-to-square me-2"></i>Cập Nhật Sách ID: ${book.bookid}</c:when>
                        <c:otherwise><i class="fa-solid fa-plus-circle me-2"></i>Thêm Sách Mới</c:otherwise>
                    </c:choose>
                </h4>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin/books" method="post">
                    <c:if test="${not empty book}">
                        <input type="hidden" name="bookid" value="${book.bookid}"/>
                    </c:if>

                    <div class="row g-3">
                        <div class="col-md-8">
                            <label for="title" class="form-label fw-bold">Tiêu đề sách:</label>
                            <input type="text" class="form-control" id="title" name="title" value="<c:out value="${book.title}"/>" required>
                        </div>
                        <div class="col-md-4">
                            <label for="isbn" class="form-label fw-bold">Mã ISBN:</label>
                            <input type="number" class="form-control" id="isbn" name="isbn" value="<c:out value="${book.isbn}"/>" required>
                        </div>

                        <div class="col-md-6">
                            <label for="publisher" class="form-label fw-bold">Nhà xuất bản (Publisher):</label>
                            <input type="text" class="form-control" id="publisher" name="publisher" value="<c:out value="${book.publisher}"/>" required>
                        </div>
                        <div class="col-md-6">
                            <label for="publishDate" class="form-label fw-bold">Ngày xuất bản (Publisher date):</label>
                            <fmt:formatDate var="formattedDate" value="${book.publishDate}" pattern="yyyy-MM-dd"/>
                            <input type="date" class="form-control" id="publishDate" name="publishDate" value="${formattedDate}" required>
                        </div>

                        <div class="col-md-4">
                            <label for="price" class="form-label fw-bold">Giá bán (VNĐ):</label>
                            <input type="number" step="1000" class="form-control" id="price" name="price" value="<c:out value="${book.price}"/>" required placeholder="150000">
                        </div>
                        <div class="col-md-4">
                            <label for="quantity" class="form-label fw-bold">Số lượng (Quantity):</label>
                            <input type="number" class="form-control" id="quantity" name="quantity" value="<c:out value="${book.quantity}"/>" required>
                        </div>
                        <div class="col-md-4">
                            <label for="coverImage" class="form-label fw-bold">URL Ảnh bìa (Cover Image):</label>
                            <input type="text" class="form-control" id="coverImage" name="coverImage" value="<c:out value="${book.coverImage}"/>" placeholder="https://...">
                        </div>

                        <div class="col-md-12">
                            <label class="form-label fw-bold">Tác giả (Chọn nhiều):</label>
                            <div class="border rounded p-3 bg-light" style="max-height: 150px; overflow-y: auto;">
                                <c:forEach var="a" items="${authorList}">
                                    <c:set var="isSelected" value="false"/>
                                    <c:forEach var="ba" items="${book.authors}">
                                        <c:if test="${ba.authorId == a.authorId}">
                                            <c:set var="isSelected" value="true"/>
                                        </c:if>
                                    </c:forEach>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="authorIds" value="${a.authorId}" id="author_${a.authorId}" ${isSelected ? 'checked' : ''}>
                                        <label class="form-check-label" for="author_${a.authorId}">
                                            <c:out value="${a.authorName}"/>
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <label for="description" class="form-label fw-bold">Mô tả sách:</label>
                            <textarea class="form-control" id="description" name="description" rows="4"><c:out value="${book.description}"/></textarea>
                        </div>
                    </div>

                    <div class="mt-4 text-end">
                        <a href="${pageContext.request.contextPath}/admin/books" class="btn btn-secondary me-2">Hủy bỏ</a>
                        <button type="submit" class="btn btn-success px-4 fw-bold">Lưu Thay Đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Order #${order.orderId} - Sync Store</title>
    <jsp:include page="includes/head.jsp" />
</head>

<body class="animsition">

    <jsp:include page="includes/header.jsp">
        <jsp:param name="activeMenu" value="" />
    </jsp:include>

    <!-- Title page -->
    <section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('images/bg-01.jpg');">
        <h2 class="ltext-105 cl0 txt-center">Order Details</h2>
    </section>

    <!-- Content page -->
    <section class="bg0 p-t-40 p-b-116">
        <div class="container">

            <!-- Back Link -->
            <div class="p-b-20">
                <c:choose>
                    <c:when test="${from == 'admin'}">
                        <a href="admin-customer" class="order-back-link">
                            <i class="zmdi zmdi-long-arrow-left"></i> Return to Customer Management
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="profile#order-history" class="order-back-link">
                            <i class="zmdi zmdi-long-arrow-left"></i> Return to Order History
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Order Summary Card -->
            <div class="order-detail-card">

                <!-- Order Header -->
                <div class="order-detail-header">
                    <div class="order-detail-id">
                        <span class="order-detail-label">Order</span>
                        <span class="order-detail-number">#${order.orderId}</span>
                    </div>
                    <div class="order-detail-meta">
                        <div class="order-meta-item">
                            <i class="fa fa-calendar"></i>
                            <div>
                                <span class="order-meta-label">Order Date</span>
                                <span class="order-meta-value">${order.orderedAt}</span>
                            </div>
                        </div>
                        <div class="order-meta-item">
                            <i class="fa fa-credit-card"></i>
                            <div>
                                <span class="order-meta-label">Total Amount</span>
                                <span class="order-meta-value order-total-highlight">
                                    $<fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Purchased Items -->
                <div class="order-detail-section-title">
                    <i class="fa fa-shopping-bag"></i> Purchased Items
                </div>

                <div class="wrap-table-shopping-cart bg0">
                    <table class="table-shopping-cart table-auto-width">
                        <tr class="table_head">
                            <th class="column-1">Product</th>
                            <th class="column-2"></th>
                            <th class="column-3">Price</th>
                            <th class="column-4 text-center-cell">Qty</th>
                            <th class="column-5">Total</th>
                        </tr>

                        <c:choose>
                            <c:when test="${not empty order.items}">
                                <c:forEach var="item" items="${order.items}">
                                    <tr class="table_row">
                                        <td class="column-1">
                                            <a href="product?id=${item.product.productId}">
                                                <div class="how-itemcart1">
                                                    <img src="${item.product.imageUrl}" alt="${item.product.name}">
                                                </div>
                                            </a>
                                        </td>
                                        <td class="column-2">
                                            <a href="product?id=${item.product.productId}" class="hov-cl1 trans-04">
                                                ${item.product.name}
                                            </a>
                                        </td>
                                        <td class="column-3">
                                            $<fmt:formatNumber value="${item.price}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                        </td>
                                        <td class="column-4 text-center-cell">${item.quantity}</td>
                                        <td class="column-5">
                                            $<fmt:formatNumber value="${item.price * item.quantity}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr class="table_row">
                                    <td colspan="5">
                                        <div class="profile-empty">
                                            <i class="fa fa-inbox"></i>
                                            <p>No items found in this order.</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </table>
                </div>

                <!-- Order Total Footer -->
                <div class="order-detail-footer">
                    <div class="order-footer-row">
                        <span>Subtotal</span>
                        <span>
                            $<fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                        </span>
                    </div>
                    <div class="order-footer-row">
                        <span>Shipping</span>
                        <span class="order-free-shipping">Free</span>
                    </div>
                    <div class="order-footer-row order-footer-total">
                        <span>Total Paid</span>
                        <span>
                            $<fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                        </span>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <jsp:include page="includes/footer.jsp" />
    <jsp:include page="includes/scripts.jsp" />
</body>

</html>
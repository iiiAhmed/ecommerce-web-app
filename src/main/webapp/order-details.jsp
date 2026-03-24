<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <title>Order Details - Sync Store</title>
        <jsp:include page="includes/head.jsp" />
    </head>

    <body class="animsition">

        <jsp:include page="includes/header.jsp">
            <jsp:param name="activeMenu" value="" />
        </jsp:include>
        <!-- Title page -->
        <section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('images/bg-01.jpg');">
            <h2 class="ltext-105 cl0 txt-center">
                Order #${order.orderId} Details
            </h2>
        </section>

    <!-- Content page -->
    <section class="bg0 p-t-40 p-b-116">
        <div class="container">
            <div class="flex-w flex-sb-m p-b-20">
                <c:choose>
                    <c:when test="${from == 'admin'}">
                        <a href="admin-customer" class="stext-107 cl2 hov-cl1 trans-04">
                            <i class="zmdi zmdi-long-arrow-left m-r-10"></i> Return to Customer Management
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="profile" class="stext-107 cl2 hov-cl1 trans-04">
                            <i class="zmdi zmdi-long-arrow-left m-r-10"></i> Return to Profile
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>

                <div class="bor10 p-lr-40 p-t-30 p-b-40">
                    <div class="flex-w flex-sb-m p-b-30">
                        <div>
                            <span class="stext-111 cl2 p-r-30">Order Date:</span>
                            <span class="stext-115 cl6">${order.orderedAt}</span>
                        </div>
                        <div>
                            <span class="stext-111 cl2 p-r-30">Total Amount:</span>
                            <span class="stext-115 cl6"
                                style="color: #717fe0; font-weight: bold;">$${order.totalAmount}</span>
                        </div>
                    </div>

                    <h4 class="mtext-109 cl2 p-b-20">
                        Purchased Items
                    </h4>

                    <div class="wrap-table-shopping-cart bg0 bor50">
                        <table class="table-shopping-cart" style="min-width: unset;">
                            <tr class="table_head">
                                <th class="column-1">Product</th>
                                <th class="column-2"></th>
                                <th class="column-3">Price</th>
                                <th class="column-4" style="text-align: center;">Quantity</th>
                                <th class="column-5">Total</th>
                            </tr>

                            <c:choose>
                                <c:when test="${not empty order.items}">
                                    <c:forEach var="item" items="${order.items}">
                                        <tr class="table_row">
                                            <td class="column-1">
                                                <div class="how-itemcart1">
                                                    <img src="${item.product.imageUrl}" alt="${item.product.name}">
                                                </div>
                                            </td>
                                            <td class="column-2">${item.product.name}</td>
                                            <td class="column-3">$${item.price}</td>
                                            <td class="column-4" style="text-align: center;">
                                                <span class="stext-111 cl6">${item.quantity}</span>
                                            </td>
                                            <td class="column-5">$${item.price * item.quantity}</td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="table_row">
                                        <td colspan="5" class="column-1" style="text-align: center; padding: 20px;">
                                            No items found in this order.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </table>
                    </div>

                </div>
            </div>
        </section>

        <jsp:include page="includes/footer.jsp" />

        <jsp:include page="includes/scripts.jsp" />
    </body>

    </html>
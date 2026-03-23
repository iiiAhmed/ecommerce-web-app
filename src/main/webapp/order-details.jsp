<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <title>Order Details</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="images/icons/favicon.png" />
        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" type="text/css" href="fonts/linearicons-v1.0.0/icon-font.min.css">
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
        <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
        <link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">
        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
    </head>

    <body class="animsition">

        <!-- Header (Simplified for brevity, matching profile.jsp style) -->
        <header class="header-v4">
            <div class="container-menu-desktop">
                <div class="wrap-menu-desktop how-shadow1">
                    <nav class="limiter-menu-desktop container">
                        <!-- Logo desktop -->
                        <a href="index.jsp" class="logo">
                            <img src="images/icons/logo-01.png" alt="IMG-LOGO">
                        </a>

                        <!-- Menu desktop -->
                        <div class="menu-desktop">
                            <ul class="main-menu">
                                <li><a href="index.jsp">Home</a></li>
                                <li><a href="store.jsp">Shop</a></li>
                                <li><a href="about.html">About</a></li>
                                <li><a href="contact.html">Contact</a></li>
                            </ul>
                        </div>

                        <!-- Icon header -->
                        <div class="wrap-icon-header flex-w flex-r-m">
                            <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-modal-search">
                                <i class="zmdi zmdi-search"></i>
                            </div>
                            <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti js-show-cart"
                                data-notify="0">
                                <i class="zmdi zmdi-shopping-cart"></i>
                            </div>
                            <a href="#" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti"
                                data-notify="0">
                                <i class="zmdi zmdi-favorite-outline"></i>
                            </a>
                            <a href="profile" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11">
                                <i class="zmdi zmdi-account-circle"></i>
                            </a>
                            <c:choose>
                                <c:when test="${not empty sessionScope.userDto}">
                                    <span class="stext-106 cl2 p-l-22 p-r-11">
                                        Welcome, ${sessionScope.userDto.name}
                                    </span>
                                    <c:if test="${sessionScope.userDto.role == 'ADMIN'}">
                                        <a href="admin-products.jsp"
                                            class="stext-106 cl2 hov-cl1 trans-04 p-l-22 p-r-11">Admin Panel</a>
                                    </c:if>
                                    <a href="logout" class="stext-106 cl2 hov-cl1 trans-04 p-l-22 p-r-11">
                                        Sign Out
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="sign-in.html" class="stext-106 cl2 hov-cl1 trans-04 p-l-22 p-r-11">
                                        Sign In
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </nav>
                </div>
            </div>

            <!-- Header Mobile (Simplified) -->
            <div class="wrap-header-mobile">
                <!-- Logo mobile -->
                <div class="logo-mobile">
                    <a href="index.jsp"><img src="images/icons/logo-01.png" alt="IMG-LOGO"></a>
                </div>

                <!-- Icon header -->
                <div class="wrap-icon-header flex-w flex-r-m m-r-15">
                    <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 js-show-modal-search">
                        <i class="zmdi zmdi-search"></i>
                    </div>
                    <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti js-show-cart"
                        data-notify="0">
                        <i class="zmdi zmdi-shopping-cart"></i>
                    </div>
                    <a href="#" class="dis-block icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti"
                        data-notify="0">
                        <i class="zmdi zmdi-favorite-outline"></i>
                    </a>
                    <a href="profile" class="dis-block icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10">
                        <i class="zmdi zmdi-account-circle"></i>
                    </a>
                </div>

                <!-- Button show menu -->
                <div class="btn-show-menu-mobile hamburger hamburger--squeeze">
                    <span class="hamburger-box">
                        <span class="hamburger-inner"></span>
                    </span>
                </div>
            </div>

            <!-- Menu Mobile -->
            <div class="menu-mobile">
                <ul class="main-menu-m">
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="store.jsp">Shop</a></li>
                    <li><a href="about.html">About</a></li>
                    <li><a href="contact.html">Contact</a></li>
                    <c:choose>
                        <c:when test="${not empty sessionScope.userDto}">
                            <li><span class="stext-106 cl2" style="padding: 10px 20px;">Welcome,
                                    ${sessionScope.userDto.name}</span></li>
                            <c:if test="${sessionScope.userDto.role == 'ADMIN'}">
                                <li><a href="admin-products.jsp">Admin Panel</a></li>
                            </c:if>
                            <li><a href="logout">Sign Out</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="sign-in.html">Sign In</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </header>

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

        <!-- Footer -->
        <footer class="bg3 p-t-75 p-b-32">
            <!-- ... minimalist footer omitted for brevity ... -->
        </footer>

        <!-- Scripts -->
        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
        <script src="vendor/animsition/js/animsition.min.js"></script>
        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
    </body>

    </html>
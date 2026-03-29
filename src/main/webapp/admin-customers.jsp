<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Admin - Review Customers</title>
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
    <link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css" href="css/util.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
</head>

<body class="animsition">

    <!-- Header -->
    <header class="header-v4">
        <div class="container-menu-desktop">
            <div class="wrap-menu-desktop how-shadow1">
                <nav class="limiter-menu-desktop container">
                    <a href="index.jsp" class="logo">
                        <img src="images/icons/logo-01.png" alt="IMG-LOGO">
                    </a>

                    <div class="menu-desktop">
                        <ul class="main-menu">
                            <li><a href="admin-product">Manage Products</a></li>
                            <li class="active-menu"><a href="admin-customer">Review Customers</a></li>
                            <c:if test="${sessionScope.userDto.role == 'SUPER_ADMIN'}">
                                <li><a href="admin-user">Manage Admins</a></li>
                            </c:if>
                            <li><a href="index.jsp" target="_blank">View Store</a></li>
                        </ul>
                    </div>

                    <!-- Admin Identity -->
                    <div class="wrap-icon-header flex-w flex-r-m">
                        <span class="stext-106 cl2 p-r-15" style="font-weight: 500;">Welcome,
                            ${sessionScope.userDto.name}</span>
                        <a href="#" onclick="logout(); return false;" class="stext-106 hov-cl1 trans-04"
                            style="color: #e74c3c;">Logout</a>
                    </div>
                </nav>
            </div>
        </div>
    </header>

    <!-- Title -->
    <div class="bg0 p-t-60 p-b-20" style="background-color: #f7f7f7;">
        <div class="container">
            <h3 class="ltext-103 cl5 txt-center">
                Customer Management
            </h3>
        </div>
    </div>

    <!-- Content page -->
    <section class="bg0 p-t-20 p-b-116" style="background-color: #f7f7f7;">
        <div class="container">
            <div class="bg0 bor10 p-t-30 p-b-40 p-lr-40 p-lr-15-sm">

                <div class="flex-w flex-sb-m p-b-30">
                    <h4 class="mtext-109 cl2">All Registered Customers</h4>
                </div>

                <div class="wrap-table-shopping-cart">
                    <table class="table-shopping-cart">
                        <tr class="table_head">
                            <th class="column-1">Name</th>
                            <th class="column-2">Email</th>
                            <th class="column-3">Actions</th>
                        </tr>

                        <c:forEach items="${customers}" var="customer">
                            <tr class="table_row" id="cust-${customer.id}">
                                <td class="column-1 text-dark" style="font-weight: 500;">
                                    <c:out value="${customer.name}"/>
                                </td>
                                <td class="column-2"><c:out value="${customer.email}"/></td>
                                <td class="column-3">
                                    <button class="stext-106 cl6 hov1 bor3 trans-04 p-lr-15 p-tb-5 m-r-10 text-primary"
                                        onclick="reviewCustomer(${customer.id})">View Profile & Orders</button>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty customers}">
                            <tr class="table_row">
                                <td colspan="3" class="text-center p-t-20 p-b-20 stext-111 cl6">
                                    No registered customers found.
                                </td>
                            </tr>
                        </c:if>
                    </table>
                </div>

            </div>
        </div>
    </section>

    <!-- Modal: Review Customer -->
    <div class="wrap-modal1 js-modal-customer p-t-60 p-b-20">
        <div class="overlay-modal1 js-hide-modal-customer"></div>

        <div class="container">
            <div class="bg0 p-t-60 p-b-30 p-lr-15-lg how-pos3-parent bor10">
                <button class="how-pos3 hov3 trans-04 js-hide-modal-customer">
                    <img src="images/icons/icon-close.png" alt="CLOSE">
                </button>

                <div class="row px-5">
                    <div class="col-12">
                        <h4 class="mtext-105 cl2 txt-center p-b-20" id="modalCustomerTitle">
                            Customer Profile
                        </h4>

                        <!-- Loading indicator -->
                        <div id="profileLoading" class="txt-center p-tb-30" style="display: none;">
                            <span class="stext-111 cl6">Loading profile...</span>
                        </div>

                        <!-- Profile data -->
                        <div id="profileData" class="p-b-30">
                            <strong>Name:</strong> <span id="cName"></span><br>
                            <strong>Email:</strong> <span id="cEmail"></span><br>
                            <strong>Birthday:</strong> <span id="cBday"></span><br>
                            <strong>Phone:</strong> <span id="cPhone"></span><br>
                            <strong>Job:</strong> <span id="cJob"></span><br>
                            <strong>Address:</strong> <span id="cAddr"></span><br>
                            <strong>Interests:</strong> <span id="cInt"></span><br>
                            <strong>Credit Limit:</strong> <span id="cCred" class="text-success"
                                style="font-weight: bold;"></span>
                        </div>

                        <hr>

                        <h4 class="mtext-105 cl2 txt-center p-b-20 p-t-20">
                            Order History
                        </h4>

                        <div class="wrap-table-shopping-cart">
                            <table class="table-shopping-cart">
                                <tr class="table_head">
                                    <th class="column-1">Order #</th>
                                    <th class="column-2">Date</th>
                                    <th class="column-3">Total Amount</th>
                                    <th class="column-4">Details</th>
                                </tr>
                                <tbody id="orderHistoryBody">
                                    <!-- Populated by AJAX -->
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
    <script src="vendor/animsition/js/animsition.min.js"></script>
    <script src="vendor/bootstrap/js/popper.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
    <script>
        $('.js-hide-modal-customer').on('click', function () {
            $('.js-modal-customer').removeClass('show-modal1');
        });

        function reviewCustomer(id) {
            // Clear previous data & show loading
            $('#profileData span').text('');
            $('#orderHistoryBody').empty();
            $('#profileLoading').show();
            $('#profileData').hide();
            $('.js-modal-customer').addClass('show-modal1');

            $.ajax({
                url: 'admin-customer',
                type: 'GET',
                data: { action: 'profile', id: id },
                dataType: 'json',
                success: function (data) {
                    $('#profileLoading').hide();
                    $('#profileData').show();

                    // Populate profile fields
                    $('#cName').text(data.name || '-');
                    $('#cEmail').text(data.email || '-');
                    $('#cBday').text(data.birthday || '-');
                    $('#cPhone').text(data.phone || '-');
                    $('#cJob').text(data.job || '-');
                    $('#cAddr').text(data.address || '-');
                    $('#cInt').text(data.interests || '-');
                    $('#cCred').text('$' + parseFloat(data.creditLimit).toFixed(2));

                    // Color credit limit
                    if (data.creditLimit > 1000) {
                        $('#cCred').removeClass('text-warning').addClass('text-success');
                    } else {
                        $('#cCred').removeClass('text-success').addClass('text-warning');
                    }

                    // Populate order history
                    if (data.orders && data.orders.length > 0) {
                        data.orders.forEach(function (order) {
                            $('#orderHistoryBody').append(
                                '<tr class="table_row">' +
                                '<td class="column-1">#ORD-' + order.orderId + '</td>' +
                                '<td class="column-2">' + order.date + '</td>' +
                                '<td class="column-3">$ ' + parseFloat(order.totalAmount).toFixed(2) + '</td>' +
                                '<td class="column-4"><a href="orderDetails?id=' + order.orderId + '&from=admin" target="_blank" class="stext-106 text-primary hov-cl1 trans-04">View Details</a></td>' +
                                '</tr>'
                            );
                        });
                    } else {
                        $('#orderHistoryBody').append(
                            '<tr class="table_row"><td colspan="4" class="text-center stext-111 cl6 p-tb-15">' +
                            'No orders found for this customer.</td></tr>'
                        );
                    }

                    $('#modalCustomerTitle').text('Profile: ' + data.name);
                },
                error: function () {
                    $('#profileLoading').hide();
                    $('#profileData').show();
                    $('#cName').text('Error loading profile');
                }
            });
        }

        function logout() {
            window.location.href = 'logout';
        }
    </script>
</body>

</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>My Profile</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="images/icons/favicon.png" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="fonts/linearicons-v1.0.0/icon-font.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="css/util.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <!--===============================================================================================-->
</head>

<body class="animsition">

    <!-- Header -->
    <header class="header-v4">
        <!-- Header desktop -->
        <div class="container-menu-desktop">

            <div class="wrap-menu-desktop how-shadow1">
                <nav class="limiter-menu-desktop container">

                    <!-- Logo desktop -->
                    <a href="index.html" class="logo">
                        <img src="images/icons/logo-01.png" alt="IMG-LOGO">
                    </a>

                    <!-- Menu desktop -->
                    <div class="menu-desktop">
                        <ul class="main-menu">
                            <li><a href="index.html">Home</a></li>
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
                    </div>
                </nav>
            </div>
        </div>

        <!-- Header Mobile -->
        <div class="wrap-header-mobile">
            <!-- Logo mobile -->
            <div class="logo-mobile">
                <a href="index.html"><img src="images/icons/logo-01.png" alt="IMG-LOGO"></a>
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
                <li><a href="index.html">Home</a></li>
                <li><a href="store.jsp">Shop</a></li>

                <li><a href="about.html">About</a></li>
                <li><a href="contact.html">Contact</a></li>
            </ul>
        </div>

        <!-- Modal Search -->
        <div class="modal-search-header flex-c-m trans-04 js-hide-modal-search">
            <div class="container-search-header">
                <button class="flex-c-m btn-hide-modal-search trans-04 js-hide-modal-search">
                    <img src="images/icons/icon-close2.png" alt="CLOSE">
                </button>

                <form class="wrap-search-header flex-w p-l-15">
                    <button class="flex-c-m trans-04">
                        <i class="zmdi zmdi-search"></i>
                    </button>
                    <input class="plh3" type="text" name="search" placeholder="Search...">
                </form>
            </div>
        </div>
    </header>

    <!-- Title page -->
    <section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('images/bg-01.jpg');">
        <h2 class="ltext-105 cl0 txt-center">
            My Profile
        </h2>
    </section>

    <!-- Content page -->
    <section class="bg0 p-t-75 p-b-116">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-lg-3 p-b-50">
                    <!-- Sidebar -->
                    <div class="bor10 p-lr-40 p-t-30 p-b-40 m-r-20 m-r-0-sm">
                        <h4 class="mtext-109 cl2 p-b-20">Account Menu</h4>
                        <ul>
                            <li class="p-b-10"><a href="#" class="stext-107 cl2 hov-cl1 trans-04"
                                    style="font-weight: bold; color: #717fe0;">Profile Data</a></li>
                            <li class="p-b-10"><a href="shopping-cart.html" class="stext-107 cl2 hov-cl1 trans-04">My
                                    Cart</a></li>
                            <li class="p-b-10"><a href="#order-history" class="stext-107 cl2 hov-cl1 trans-04">Order History</a></li>
                            <li class="p-t-20"><a href="#" onclick="logout(); return false;"
                                    class="stext-107 cl2 hov-cl1 trans-04 text-danger">Sign Out</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-md-8 col-lg-9 p-b-50">
                    <!-- Profile Forms -->
                    <div class="bor10 p-lr-50 p-t-40 p-b-40 p-lr-15-sm">

                        <!-- Edit Profile Form -->
                        <form id="profileForm"
                            onsubmit="event.preventDefault(); alert('Profile Updated Successfully!');">
                            <h4 class="mtext-105 cl2 p-b-30">
                                Personal Details
                            </h4>

                            <div class="row">
                                <div class="col-sm-6 p-b-20">
                                    <div class="bor8 how-pos4-parent">
                                        <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="text" name="name"
                                            value="John Doe" required>
                                    </div>
                                </div>
                                <div class="col-sm-6 p-b-20">
                                    <div class="bor8 how-pos4-parent">
                                        <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="email"
                                            name="email" value="john.doe@example.com" disabled>
                                    </div>
                                </div>
                                <div class="col-sm-6 p-b-20">
                                    <div class="bor8 how-pos4-parent">
                                        <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="date"
                                            name="birthday" value="1995-05-15" required>
                                    </div>
                                </div>
                                <div class="col-sm-6 p-b-20">
                                    <div class="bor8 how-pos4-parent">
                                        <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="text" name="job"
                                            value="Software Engineer" required>
                                    </div>
                                </div>
                                <div class="col-12 p-b-20">
                                    <div class="bor8">
                                        <textarea class="stext-111 cl2 plh3 size-120 p-lr-20 p-tb-25" name="address"
                                            required>123 Fake Street, Tech City</textarea>
                                    </div>
                                </div>
                                <div class="col-12 p-b-20">
                                    <div class="bor8 how-pos4-parent">
                                        <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="text"
                                            name="interests" value="Technology, E-Commerce, Fashion">
                                    </div>
                                </div>
                            </div>

                            <button type="submit"
                                class="flex-c-m stext-101 cl0 size-112 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
                                Update Details
                            </button>
                        </form>

                        <hr class="m-tb-40">

                        <!-- Update Credit Limit Form -->
                        <form id="creditLimitForm" onsubmit="return updateCredit(event)">
                            <h4 class="mtext-105 cl2 p-b-20">
                                Credit Limit Management
                            </h4>
                            <p class="stext-111 cl6 p-b-15">Current Credit Limit: <span id="currentCredit"
                                    style="font-weight:bold; color: #717fe0;">$5000.00</span></p>

                            <div class="bor8 m-b-20" style="max-width: 300px;">
                                <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="number" id="newCredit"
                                    name="newCredit" placeholder="Set New Credit Limit ($)" required min="0">
                            </div>

                            <button type="submit"
                                class="flex-c-m stext-101 cl0 size-112 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer"
                                style="max-width: 200px;">
                                Update Credit
                            </button>
                        </form>

                        <hr class="m-tb-40">

                        <!-- Order History Table -->
                        <div id="order-history">
                            <h4 class="mtext-105 cl2 p-b-20">
                                Order History
                            </h4>

                            <div class="wrap-table-shopping-cart bg0 bor50">
                                <table class="table-shopping-cart" style="min-width: unset;">
                                    <tr class="table_head">
                                        <th class="column-1" style="padding-left: 20px;">Order ID</th>
                                        <th class="column-2" style="text-align: center;">Date</th>
                                        <th class="column-3" style="text-align: center;">Total Amount</th>
                                        <th class="column-4" style="text-align: center;">Action</th>
                                    </tr>

                                    <c:choose>
                                        <c:when test="${not empty orders}">
                                            <c:forEach var="order" items="${orders}">
                                                <tr class="table_row">
                                                    <td class="column-1" style="padding-left: 20px;">#${order.orderId}</td>
                                                    <td class="column-2" style="text-align: center;">${order.orderedAt}</td>
                                                    <td class="column-3" style="text-align: center;">$${order.totalAmount}</td>
                                                    <td class="column-4" style="text-align: center;">
                                                        <a href="orderDetails?id=${order.orderId}" class="stext-107 cl1 hov-cl1 trans-04">
                                                            View Details
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr class="table_row">
                                                <td colspan="4" class="column-1" style="text-align: center; padding: 20px;">
                                                    You haven't placed any orders yet.
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </table>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg3 p-t-75 p-b-32">
        <!-- ... minimalist footer omitted for brevity ... -->
    </footer>

    <!--===============================================================================================-->
    <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
    <script src="vendor/animsition/js/animsition.min.js"></script>
    <script src="vendor/bootstrap/js/popper.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
    <script>
        // Set mock credit initially
        if (!localStorage.getItem('userCredit')) {
            localStorage.setItem('userCredit', 5000.00);
        }
        $('#currentCredit').text('$' + parseFloat(localStorage.getItem('userCredit')).toFixed(2));

        function updateCredit(e) {
            e.preventDefault();
            const newCredit = $('#newCredit').val();
            localStorage.setItem('userCredit', newCredit);
            $('#currentCredit').text('$' + parseFloat(newCredit).toFixed(2));
            $('#newCredit').val('');
            alert('Credit limit updated to $' + newCredit);
            return false;
        }

        function logout() {
            sessionStorage.removeItem('userRole');
            alert('Logged out successfully');
            window.location.href = 'index.html';
        }
    </script>
</body>

</html>
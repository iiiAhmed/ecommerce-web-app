<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- param: activeMenu (home, shop, about, contact) --%>

<!-- Header -->
<header class="header-v4">
    <!-- Header desktop -->
    <div class="container-menu-desktop">
        <div class="wrap-menu-desktop how-shadow1">
            <nav class="limiter-menu-desktop container">

                <!-- Logo desktop -->
                <a href="index.jsp" class="logo">
                    <img src="images/icons/logo-01.png" alt="Sync Store">
                </a>

                <!-- Menu desktop -->
                <div class="menu-desktop">
                    <ul class="main-menu">
                        <li class="${param.activeMenu == 'home' ? 'active-menu' : ''}">
                            <a href="index.jsp">Home</a>
                        </li>
                        <li class="${param.activeMenu == 'shop' ? 'active-menu' : ''}">
                            <a href="shop">Shop</a>
                        </li>
                        <li class="${param.activeMenu == 'about' ? 'active-menu' : ''}">
                            <a href="about.jsp">About</a>
                        </li>
                        <li class="${param.activeMenu == 'contact' ? 'active-menu' : ''}">
                            <a href="contact.jsp">Contact</a>
                        </li>
                    </ul>
                </div>

                <!-- Icon header -->
                <div class="wrap-icon-header flex-w flex-r-m">
                    <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-modal-search">
                        <i class="zmdi zmdi-search"></i>
                    </div>

                    <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti js-show-cart"
                        data-notify="${cartCount != null ? cartCount : 0}">
                        <i class="zmdi zmdi-shopping-cart"></i>
                    </div>

                    <a href="profile" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11">
                        <i class="zmdi zmdi-account-circle"></i>
                    </a>

                    <c:choose>
                        <c:when test="${not empty sessionScope.userDto}">
                            <span class="stext-106 cl2 p-l-22 p-r-11">
                                Welcome, ${sessionScope.userDto.name}
                            </span>
                            <c:if test="${sessionScope.userDto.role == 'ADMIN'}">
                                <a href="admin-product"
                                    class="stext-106 cl2 hov-cl1 trans-04 p-l-22 p-r-11">Admin Panel</a>
                            </c:if>
                            <a href="logout" class="stext-106 cl2 hov-cl1 trans-04 p-l-22 p-r-11">
                                Sign Out
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="sign-in.jsp" class="stext-106 cl2 hov-cl1 trans-04 p-l-22 p-r-11">
                                Sign In
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </nav>
        </div>
    </div>

    <!-- Header Mobile -->
    <div class="wrap-header-mobile">
        <!-- Logo mobile -->
        <div class="logo-mobile">
            <a href="index.jsp"><img src="images/icons/logo-01.png" alt="Sync Store"></a>
        </div>

        <!-- Icon header -->
        <div class="wrap-icon-header flex-w flex-r-m m-r-15">
            <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 js-show-modal-search">
                <i class="zmdi zmdi-search"></i>
            </div>

            <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti js-show-cart"
                data-notify="${cartCount != null ? cartCount : 0}">
                <i class="zmdi zmdi-shopping-cart"></i>
            </div>

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
            <li><a href="shop">Shop</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="contact.jsp">Contact</a></li>
            <c:choose>
                <c:when test="${not empty sessionScope.userDto}">
                    <li><span class="stext-106 cl2" style="padding: 10px 20px;">Welcome, ${sessionScope.userDto.name}</span></li>
                    <c:if test="${sessionScope.userDto.role == 'ADMIN'}">
                        <li><a href="admin-product">Admin Panel</a></li>
                    </c:if>
                    <li><a href="logout">Sign Out</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="sign-in.jsp">Sign In</a></li>
                </c:otherwise>
            </c:choose>
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

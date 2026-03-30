<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- param: activeMenu (home, shop, about, contact) --%>

<c:if test="${empty cartCount}">
    <c:set var="cartCount" value="0" />
    <c:if test="${not empty sessionScope.cart}">
        <c:forEach var="item" items="${sessionScope.cart}">
            <c:set var="cartCount" value="${cartCount + item.value}" />
        </c:forEach>
    </c:if>
</c:if>

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
                    <!-- Cart -->
                    <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti js-show-cart"
                        data-notify="${cartCount != null ? cartCount : 0}">
                        <i class="zmdi zmdi-shopping-cart"></i>
                    </div>

                    <!-- Theme Toggle -->
                    <button class="theme-toggle" id="themeToggle" aria-label="Toggle theme">
                        <i class="zmdi zmdi-brightness-2"></i>
                    </button>

                    <!-- Auth Section -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.userDto}">
                            <div class="user-dropdown-container p-l-22">
                                <button class="icon-header-item cl2 hov-cl1 trans-04 flex-c-m user-dropdown-trigger">
                                    <i class="zmdi zmdi-account-circle"></i>
                                    <span class="m-l-5 fs-15">Account</span>
                                    <i class="zmdi zmdi-caret-down fs-12 m-l-4"></i>
                                </button>
                                
                                <div class="user-dropdown-menu">
                                    <div class="dropdown-header">
                                        Hi, ${sessionScope.userDto.name}
                                    </div>
                                    <a href="profile" class="dropdown-item">
                                        <i class="zmdi zmdi-account"></i> My Profile
                                    </a>
                                    <a href="profile#order-history" class="dropdown-item">
                                        <i class="zmdi zmdi-shopping-basket"></i> My Orders
                                    </a>
                                    <c:if test="${sessionScope.userDto.role.name() eq 'ADMIN' or sessionScope.userDto.role.name() eq 'SUPER_ADMIN'}">
                                        <div class="dropdown-divider"></div>
                                        <a href="admin-product" class="dropdown-item">
                                            <i class="zmdi zmdi-settings"></i> Admin Panel
                                        </a>
                                    </c:if>
                                    <div class="dropdown-divider"></div>
                                    <a href="logout" class="dropdown-item sign-out">
                                        <i class="zmdi zmdi-run"></i> Sign Out
                                    </a>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="flex-w flex-c-m p-l-30 header-auth-group">
                                <a href="sign-in.jsp" class="stext-106 cl2 hov-cl1 trans-04 p-r-15 header-signin-link">
                                    Sign In
                                </a>
                                <a href="sign-up.jsp" class="header-signup-btn">
                                    Sign Up
                                </a>
                            </div>
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
            <!-- Cart -->
            <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti js-show-cart"
                data-notify="${cartCount != null ? cartCount : 0}">
                <i class="zmdi zmdi-shopping-cart"></i>
            </div>

            <!-- Theme Toggle -->
            <button class="theme-toggle" id="themeToggleMobile" aria-label="Toggle theme">
                <i class="zmdi zmdi-brightness-2"></i>
            </button>
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
                    <li class="mobile-menu-divider"></li>
                    <li><span class="stext-106 cl2 mobile-welcome-text"><i class="zmdi zmdi-account"></i> Hi, ${sessionScope.userDto.name}</span></li>
                    <li><a href="profile">My Profile</a></li>
                    <li><a href="profile#order-history">My Orders</a></li>
                    <c:if test="${sessionScope.userDto.role.name() eq 'ADMIN' or sessionScope.userDto.role.name() eq 'SUPER_ADMIN'}">
                        <li><a href="admin-product">Admin Panel</a></li>
                    </c:if>
                    <li><a href="logout" class="mobile-sign-out">Sign Out</a></li>
                </c:when>
                <c:otherwise>
                    <li class="mobile-menu-divider"></li>
                    <li><a href="sign-in.jsp">Sign In</a></li>
                    <li><a href="sign-up.jsp" class="mobile-signup-link">Sign Up</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>

</header>

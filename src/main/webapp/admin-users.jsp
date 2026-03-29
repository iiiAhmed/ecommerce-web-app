<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Admin - Manage Admins</title>
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
    <style>
        .badge-active {
            background: #eafaf1;
            color: #27ae60;
            border: 1px solid #a9d8b8;
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        .badge-pending {
            background: #fff8e6;
            color: #d4a017;
            border: 1px solid #f0d78c;
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            animation: pulse-badge 2s ease-in-out infinite;
        }
        @keyframes pulse-badge {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.6; }
        }
        .flash-success {
            background: #eafaf1;
            border: 1px solid #a9d8b8;
            color: #27874e;
            border-radius: 6px;
            padding: 12px 18px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .flash-error {
            background: #fdf3f3;
            border: 1px solid #f0b8b8;
            color: #c0392b;
            border-radius: 6px;
            padding: 12px 18px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .create-form-card {
            background: #fff;
            border-radius: 10px;
            border: 1px solid #eee;
            padding: 30px 35px;
            margin-bottom: 30px;
        }
        .field-label {
            font-size: 12px;
            font-weight: 700;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }
        .pw-field-wrap {
            position: relative;
        }
        .pw-field-wrap .toggle-pw {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #999;
            font-size: 14px;
            background: none;
            border: none;
            padding: 4px;
        }
        .pw-field-wrap .toggle-pw:hover { color: #717fe0; }
        .btn-demote {
            background: none;
            border: 1px solid #f39c12;
            color: #f39c12;
            padding: 5px 14px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
            transition: all 0.2s ease;
        }
        .btn-demote:hover {
            background: #f39c12;
            color: #fff;
        }
        .btn-delete {
            background: none;
            border: 1px solid #e74c3c;
            color: #e74c3c;
            padding: 5px 14px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
            transition: all 0.2s ease;
        }
        .btn-delete:hover {
            background: #e74c3c;
            color: #fff;
        }
        .js-error-banner {
            display: none;
            background: #fdf3f3;
            border: 1px solid #f0b8b8;
            color: #c0392b;
            border-radius: 6px;
            padding: 10px 16px;
            margin-bottom: 16px;
            font-size: 13px;
        }
    </style>
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
                            <li><a href="admin-customer">Review Customers</a></li>
                            <c:if test="${sessionScope.userDto.role == 'SUPER_ADMIN'}">
                                <li class="active-menu"><a href="admin-user">Manage Admins</a></li>
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
                Admin Management
            </h3>
        </div>
    </div>

    <!-- Content page -->
    <section class="bg0 p-t-20 p-b-116" style="background-color: #f7f7f7;">
        <div class="container">

            <%-- Flash Messages --%>
            <c:if test="${not empty successMsg}">
                <div class="flash-success">
                    <i class="fa fa-check-circle"></i> <c:out value="${successMsg}"/>
                </div>
            </c:if>
            <c:if test="${not empty errorMsg}">
                <div class="flash-error">
                    <i class="fa fa-exclamation-circle"></i> <c:out value="${errorMsg}"/>
                </div>
            </c:if>

            <%-- ── Create New Admin Form ─────────────────────────────────── --%>
            <div class="create-form-card">
                <h4 class="mtext-109 cl2 p-b-20">
                    <i class="fa fa-user-plus" style="color: #717fe0;"></i> Create New Admin
                </h4>

                <div id="js-create-error" class="js-error-banner"></div>

                <form id="createAdminForm" method="POST" action="admin-user" onsubmit="return validateCreateForm()">
                    <input type="hidden" name="action" value="create">

                    <div class="row">
                        <div class="col-sm-6 p-b-16">
                            <p class="field-label">Full Name <span class="text-danger">*</span></p>
                            <div class="bor8">
                                <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30"
                                       type="text" name="name" id="adminName"
                                       placeholder="Admin's full name" required>
                            </div>
                        </div>
                        <div class="col-sm-6 p-b-16">
                            <p class="field-label">Email Address <span class="text-danger">*</span></p>
                            <div class="bor8">
                                <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30"
                                       type="email" name="email" id="adminEmail"
                                       placeholder="admin@example.com" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6 p-b-16">
                            <p class="field-label">Temporary Password <span class="text-danger">*</span></p>
                            <div class="bor8 pw-field-wrap">
                                <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-45"
                                       type="password" name="tempPassword" id="adminTempPw"
                                       placeholder="Min 6 characters" required minlength="6">
                                <button type="button" class="toggle-pw" onclick="toggleVis('adminTempPw', this)">
                                    <i class="fa fa-eye"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-sm-6 p-b-16">
                            <p class="field-label">Confirm Password <span class="text-danger">*</span></p>
                            <div class="bor8 pw-field-wrap">
                                <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-45"
                                       type="password" name="confirmPassword" id="adminConfirmPw"
                                       placeholder="Repeat password" required minlength="6">
                                <button type="button" class="toggle-pw" onclick="toggleVis('adminConfirmPw', this)">
                                    <i class="fa fa-eye"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <button type="submit"
                        class="flex-c-m stext-101 cl0 size-112 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer m-t-10"
                        style="max-width: 220px;">
                        <i class="fa fa-plus m-r-8"></i> Create Admin
                    </button>
                </form>
            </div>

            <%-- ── Existing Admins Table ─────────────────────────────────── --%>
            <div class="bg0 bor10 p-t-30 p-b-40 p-lr-40 p-lr-15-sm">
                <h4 class="mtext-109 cl2 p-b-20">
                    <i class="fa fa-users" style="color: #717fe0;"></i> Existing Admins
                </h4>

                <div class="wrap-table-shopping-cart">
                    <table class="table-shopping-cart">
                        <tr class="table_head">
                            <th class="column-1">Name</th>
                            <th class="column-2">Email</th>
                            <th class="column-3">Status</th>
                            <th class="column-4">Actions</th>
                        </tr>

                        <c:forEach items="${admins}" var="admin">
                            <tr class="table_row">
                                <td class="column-1" style="font-weight: 500;">
                                    <c:out value="${admin.name}"/>
                                </td>
                                <td class="column-2"><c:out value="${admin.email}"/></td>
                                <td class="column-3">
                                    <c:choose>
                                        <c:when test="${admin.pendingPasswordChange}">
                                            <span class="badge-pending">
                                                <i class="fa fa-clock-o"></i> Pending Password Change
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-active">
                                                <i class="fa fa-check"></i> Active
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="column-4">
                                    <form method="POST" action="admin-user" style="display: inline;">
                                        <input type="hidden" name="action" value="revoke">
                                        <input type="hidden" name="id" value="${admin.id}">
                                        <button type="submit" class="btn-demote"
                                                onclick="return confirm('Demote this admin to regular user?')">
                                            <i class="fa fa-arrow-down"></i> Demote
                                        </button>
                                    </form>
                                    <form method="POST" action="admin-user" style="display: inline; margin-left: 6px;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${admin.id}">
                                        <button type="submit" class="btn-delete"
                                                onclick="return confirm('Permanently delete this admin account? This cannot be undone.')">
                                            <i class="fa fa-trash"></i> Delete
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty admins}">
                            <tr class="table_row">
                                <td colspan="4" class="text-center p-t-20 p-b-20 stext-111 cl6">
                                    No admins created yet. Use the form above to create one.
                                </td>
                            </tr>
                        </c:if>
                    </table>
                </div>
            </div>

        </div>
    </section>

    <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
    <script src="vendor/animsition/js/animsition.min.js"></script>
    <script src="vendor/bootstrap/js/popper.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
    <script>
        function toggleVis(fieldId, btn) {
            var f = document.getElementById(fieldId);
            var icon = btn.querySelector('i');
            if (f.type === 'password') {
                f.type = 'text';
                icon.className = 'fa fa-eye-slash';
            } else {
                f.type = 'password';
                icon.className = 'fa fa-eye';
            }
        }

        function validateCreateForm() {
            var errorBanner = document.getElementById('js-create-error');
            errorBanner.style.display = 'none';

            var name = document.getElementById('adminName').value.trim();
            var email = document.getElementById('adminEmail').value.trim();
            var pw = document.getElementById('adminTempPw').value;
            var cpw = document.getElementById('adminConfirmPw').value;

            if (!name) {
                showError(errorBanner, 'Name is required.');
                return false;
            }
            if (!email || !/^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$/.test(email)) {
                showError(errorBanner, 'Please enter a valid email address.');
                return false;
            }
            if (pw.length < 6) {
                showError(errorBanner, 'Password must be at least 6 characters.');
                return false;
            }
            if (pw !== cpw) {
                showError(errorBanner, 'Passwords do not match.');
                return false;
            }
            return true;
        }

        function showError(banner, message) {
            banner.textContent = '\u26A0 ' + message;
            banner.style.display = 'block';
            banner.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }

        function logout() {
            window.location.href = 'logout';
        }
    </script>
</body>

</html>

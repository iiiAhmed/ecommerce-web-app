<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>My Profile - Sync Store</title>
    <jsp:include page="includes/head.jsp" />
    <style>
        /* ── Interests Checkbox Grid ───────────────────────────────────── */
        .interests-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            padding: 12px 0 4px;
        }
        .interest-label {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            padding: 8px 18px;
            border: 2px solid #e5e5e5;
            border-radius: 30px;
            background: #fafafa;
            transition: all 0.25s ease;
            font-size: 13px;
            font-weight: 600;
            color: #555;
            user-select: none;
        }
        .interest-label input[type="checkbox"] {
            display: none;
        }
        .interest-label .check-icon {
            width: 20px;
            height: 20px;
            min-width: 20px;
            border: 2px solid #ccc;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #fff;
            transition: background 0.2s, border-color 0.2s;
            font-size: 13px;
            font-weight: 900;
            color: transparent;
            line-height: 1;
        }
        .interest-label input:checked ~ .check-icon {
            background: #717fe0;
            border-color: #717fe0;
            color: #ffffff;
        }
        .interest-label input:checked ~ .check-icon::after {
            content: '\2714';
        }
        .interest-label:has(input:checked) {
            border-color: #717fe0;
            background: #eef0ff;
            color: #717fe0;
        }
        .interest-label:hover {
            border-color: #717fe0;
            background: #f0f2ff;
            color: #717fe0;
        }

        /* ── Email read-only display ───────────────────────────────────── */
        .email-readonly {
            background: #f7f7f7;
            border: 1px solid #e5e5e5;
            border-radius: 4px;
            padding: 12px 20px;
            font-size: 14px;
            color: #888;
            display: flex;
            align-items: center;
            gap: 8px;
            height: 50px;
        }
        .email-readonly .lock-icon {
            font-size: 12px;
            opacity: 0.6;
        }

        /* ── Field label ───────────────────────────────────────────────── */
        .field-label {
            font-size: 12px;
            font-weight: 700;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }

        /* ── Alert messages ────────────────────────────────────────────── */
        .profile-alert {
            border-radius: 6px;
            padding: 12px 18px;
            margin-bottom: 20px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .profile-alert.success {
            background: #eafaf1;
            border: 1px solid #a9d8b8;
            color: #27874e;
        }
        .profile-alert.error {
            background: #fdf3f3;
            border: 1px solid #f0b8b8;
            color: #c0392b;
        }

        /* ── Inline validation error ───────────────────────────────────── */
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

    <jsp:include page="includes/header.jsp">
        <jsp:param name="activeMenu" value="" />
    </jsp:include>


    <!-- Title page -->
    <section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('images/bg-01.jpg');">
        <h2 class="ltext-105 cl0 txt-center">My Profile</h2>
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
                            <li class="p-b-10"><a href="profile" class="stext-107 cl2 hov-cl1 trans-04"
                                    style="font-weight: bold; color: #717fe0;">Profile Data</a></li>
                            <li class="p-b-10"><a href="#order-history" class="stext-107 cl2 hov-cl1 trans-04">Order History</a></li>
                            <li class="p-b-10"><a href="shopping-cart.jsp" class="stext-107 cl2 hov-cl1 trans-04">My Cart</a></li>
                            <li class="p-t-20"><a href="#" onclick="logout(); return false;"
                                    class="stext-107 cl2 hov-cl1 trans-04 text-danger">Sign Out</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-md-8 col-lg-9 p-b-50">
                    <!-- Profile Forms -->
                    <div class="bor10 p-lr-50 p-t-40 p-b-40 p-lr-15-sm">

                        <%-- ── Flash / Validation Messages ─────────────────────────── --%>
                        <c:if test="${not empty successMsg}">
                            <div class="profile-alert success">
                                <i class="fa fa-check-circle"></i>
                                <span>${successMsg}</span>
                            </div>
                        </c:if>
                        <c:if test="${not empty errorMsg}">
                            <div class="profile-alert error">
                                <i class="fa fa-exclamation-circle"></i>
                                <span>${errorMsg}</span>
                            </div>
                        </c:if>

                        <%-- ── Edit Profile Form ───────────────────────────────────── --%>
                        <form id="profileForm" method="POST" action="update-profile" onsubmit="return validateProfileForm()">
                            <h4 class="mtext-105 cl2 p-b-30">Personal Details</h4>

                            <!-- JS inline error banner -->
                            <div id="js-error-banner" class="js-error-banner"></div>

                            <div class="row">
                                <%-- Name --%>
                                <div class="col-sm-6 p-b-20">
                                    <p class="field-label">Full Name <span class="text-danger">*</span></p>
                                    <div class="bor8 how-pos4-parent">
                                        <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30"
                                               type="text" name="name" id="nameField"
                                               value="${user.name}" placeholder="Your full name" required>
                                    </div>
                                </div>

                                <%-- Email (read-only, not submitted) --%>
                                <div class="col-sm-6 p-b-20">
                                    <p class="field-label">Email Address <i class="fa fa-lock" style="font-size:11px; color:#bbb;"></i></p>
                                    <div class="email-readonly">
                                        <i class="zmdi zmdi-email lock-icon"></i>
                                        <span>${user.email}</span>
                                    </div>
                                </div>

                                <%-- Birthday --%>
                                <div class="col-sm-6 p-b-20">
                                    <p class="field-label">Date of Birth <span class="text-danger">*</span></p>
                                    <div class="bor8 how-pos4-parent">
                                        <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30"
                                               type="date" name="birthday" id="birthdayField"
                                               value="${user.birthday}" required>
                                    </div>
                                </div>

                                <%-- Phone --%>
                                <div class="col-sm-6 p-b-20">
                                    <p class="field-label">Phone Number</p>
                                    <div class="bor8 d-flex align-items-center">
                                        <span class="stext-111 cl2 p-l-20 p-r-10" style="background-color: #f7f7f7; border-right: 1px solid #e6e6e6; height: 100%; display: flex; align-items: center;">
                                            +20
                                        </span>
                                        <input class="stext-111 cl2 plh3 size-116 p-l-10 p-r-30"
                                               type="tel" name="phone" id="phoneField"
                                               value="${user.phone}" placeholder="10 digits (e.g. 1012345678)"
                                               pattern="[0-9]{10}" maxlength="10" style="border: none; outline: none; flex-grow: 1;">
                                    </div>
                                </div>

                                <%-- Job --%>
                                <div class="col-sm-6 p-b-20">
                                    <p class="field-label">Job / Occupation</p>
                                    <div class="bor8 how-pos4-parent">
                                        <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30"
                                               type="text" name="job"
                                               value="${user.job}" placeholder="Your job title">
                                    </div>
                                </div>

                                <%-- Address --%>
                                <div class="col-12 p-b-20">
                                    <p class="field-label">Address</p>
                                    <div class="bor8">
                                        <textarea class="stext-111 cl2 plh3 size-120 p-lr-20 p-tb-25"
                                                  name="address" placeholder="Your address">${user.address}</textarea>
                                    </div>
                                </div>

                                <%-- Interests – Checkbox grid --%>
                                <div class="col-12 p-b-20">
                                    <p class="field-label">Watch Interests</p>
                                    <%
                                        // Build a Set of currently selected interests for JSTL use
                                        com.watch.model.entities.User profileUser =
                                            (com.watch.model.entities.User) request.getAttribute("user");
                                        String savedInterests = (profileUser != null && profileUser.getInterests() != null)
                                            ? profileUser.getInterests() : "";
                                        request.setAttribute("savedInterests", savedInterests);
                                    %>
                                    <div class="interests-grid">
                                        <%-- Render one checkbox per watch category --%>
                                        <%
                                            String[] cats = {"LUXURY", "SPORT", "CASUAL", "CLASSIC", "DIGITAL", "SMART", "DIVING"};
                                            for (String cat : cats) {
                                        %>
                                        <label class="interest-label">
                                            <input type="checkbox" name="interests" value="<%= cat %>">
                                            <span class="check-icon"></span>
                                            <span><%= cat %></span>
                                        </label>
                                        <% } %>
                                    </div>
                                </div>
                            </div>

                            <button type="submit"
                                class="flex-c-m stext-101 cl0 size-112 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
                                Update Details
                            </button>
                        </form>

                        <hr class="m-tb-40">

                        <%-- ── Credit Limit Form ───────────────────────────────────── --%>
                        <form id="creditLimitForm" method="POST" action="update-profile" onsubmit="return validateCreditForm()">
                            <h4 class="mtext-105 cl2 p-b-20">Credit Limit Management</h4>
                            <p class="stext-111 cl6 p-b-15">Current Credit Limit:
                                <span id="currentCredit" style="font-weight:bold; color: #717fe0;">$${user.creditLimit}</span>
                            </p>

                            <div id="js-credit-error" class="js-error-banner"></div>

                            <div class="bor8 m-b-20" style="max-width: 300px;">
                                <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30"
                                       type="number" id="newCredit" name="newCredit"
                                       placeholder="Set New Credit Limit ($)" min="0" step="0.01">
                            </div>

                            <button type="submit"
                                class="flex-c-m stext-101 cl0 size-112 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer"
                                style="max-width: 200px;">
                                Update Credit
                            </button>
                        </form>

                        <hr class="m-tb-40">

                        <%-- ── Order History ────────────────────────────────────────── --%>
                        <div id="order-history">
                            <h4 class="mtext-105 cl2 p-b-20">Order History</h4>
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

    <jsp:include page="includes/footer.jsp" />

    <jsp:include page="includes/scripts.jsp" />
    <script>
        // ── Pre-check saved interests ──────────────────────────────────────────
        (function () {
            var saved = '${savedInterests}';
            if (!saved) return;
            var selected = saved.split(',').map(function (s) { return s.trim(); });
            document.querySelectorAll('input[name="interests"]').forEach(function (cb) {
                if (selected.indexOf(cb.value) !== -1) {
                    cb.checked = true;
                }
            });
        })();

        // ── Client-side validation for profile form ────────────────────────────
        function validateProfileForm() {
            var errorBanner = document.getElementById('js-error-banner');
            errorBanner.style.display = 'none';
            errorBanner.textContent = '';

            // Name must not be blank
            var name = document.getElementById('nameField').value.trim();
            if (!name) {
                showError(errorBanner, 'Name cannot be empty.');
                return false;
            }

            // Birthday must be in the past
            var birthdayVal = document.getElementById('birthdayField').value;
            if (birthdayVal) {
                var birthday = new Date(birthdayVal);
                var today = new Date();
                today.setHours(0, 0, 0, 0);
                if (birthday >= today) {
                    showError(errorBanner, 'Birthday cannot be today or in the future.');
                    return false;
                }
            }

            // Phone: exactly 10 digits
            var phone = document.getElementById('phoneField').value.trim();
            if (phone) {
                if (!/^[0-9]{10}$/.test(phone)) {
                    showError(errorBanner, 'Phone must be exactly 10 digits (e.g. 1012345678).');
                    return false;
                }
            }

            return true;
        }

        // ── Client-side validation for credit form ─────────────────────────────
        function validateCreditForm() {
            var errorBanner = document.getElementById('js-credit-error');
            errorBanner.style.display = 'none';
            errorBanner.textContent = '';

            var creditVal = document.getElementById('newCredit').value;
            if (!creditVal || isNaN(creditVal)) {
                showError(errorBanner, 'Please enter a valid credit amount.');
                return false;
            }
            if (parseFloat(creditVal) < 0) {
                showError(errorBanner, 'Credit limit cannot be negative.');
                return false;
            }
            return true;
        }

        function showError(banner, message) {
            banner.textContent = '⚠ ' + message;
            banner.style.display = 'block';
            banner.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }

        // ── Logout confirmation ────────────────────────────────────────────────
        function logout() {
            if (confirm('Are you sure you want to sign out?')) {
                window.location.href = 'logout';
            }
        }
    </script>
</body>

</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>My Profile - Sync Store</title>
    <jsp:include page="includes/head.jsp" />
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
    <section class="bg0 p-t-50 p-b-100">
        <div class="container">
            <div class="row">

                <!-- ═══════════════════════════════════════════════════════════
                     SIDEBAR
                     ═══════════════════════════════════════════════════════════ -->
                <div class="col-md-4 col-lg-3 p-b-30">
                    <div class="profile-sidebar">
                        <h4 class="cl2">Account Menu</h4>
                        <ul>
                            <li><a href="#personal-details" class="sidebar-active" data-section="personal-details">
                                <i class="fa fa-user"></i> Personal Details
                            </a></li>
                            <li><a href="#credit-management" data-section="credit-management">
                                <i class="fa fa-credit-card"></i> Credit Limit
                            </a></li>
                            <li><a href="#change-password" data-section="change-password">
                                <i class="fa fa-lock"></i> Change Password
                            </a></li>
                            <li><a href="#order-history" data-section="order-history">
                                <i class="fa fa-shopping-bag"></i> Order History
                            </a></li>
                            <li><a href="shopping-cart.jsp">
                                <i class="fa fa-shopping-cart"></i> My Cart
                            </a></li>
                            <li class="sidebar-divider"></li>
                            <li><a href="#" onclick="logout(); return false;" class="sidebar-signout">
                                <i class="fa fa-sign-out"></i> Sign Out
                            </a></li>
                        </ul>
                    </div>
                </div>

                <!-- ═══════════════════════════════════════════════════════════
                     MAIN CONTENT
                     ═══════════════════════════════════════════════════════════ -->
                <div class="col-md-8 col-lg-9">

                    <%-- FLASH MESSAGES --%>
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

                    <!-- ── Section 1: Personal Details ──────────────────────── -->
                    <div id="personal-details" class="profile-section">
                        <h4 class="profile-section-title">
                            <i class="fa fa-user"></i> Personal Details
                        </h4>

                        <form id="profileForm" method="POST" action="update-profile" onsubmit="return validateProfileForm()">
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

                                <%-- Email (read-only) --%>
                                <div class="col-sm-6 p-b-20">
                                    <p class="field-label">Email Address <i class="fa fa-lock lock-icon-inline"></i></p>
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
                                        <span class="stext-111 cl2 p-l-20 p-r-10 phone-prefix">
                                            +20
                                        </span>
                                        <input class="stext-111 cl2 plh3 size-116 p-l-10 p-r-30 phone-input-bare"
                                               type="tel" name="phone" id="phoneField"
                                               value="${user.phone}" placeholder="10 digits (e.g. 1012345678)"
                                               pattern="[0-9]{10}" maxlength="10">
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

                                <%-- Interests --%>
                                <div class="col-12 p-b-20">
                                    <p class="field-label">Watch Interests</p>
                                    <%
                                        com.watch.model.entities.User profileUser =
                                            (com.watch.model.entities.User) request.getAttribute("user");
                                        String savedInterests = (profileUser != null && profileUser.getInterests() != null)
                                            ? profileUser.getInterests() : "";
                                        request.setAttribute("savedInterests", savedInterests);
                                    %>
                                    <div class="interests-grid">
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

                            <button type="submit" class="profile-btn">
                                <i class="fa fa-save"></i> Update Details
                            </button>
                        </form>
                    </div>

                    <!-- ── Section 2: Credit Limit ──────────────────────────── -->
                    <div id="credit-management" class="profile-section">
                        <h4 class="profile-section-title">
                            <i class="fa fa-credit-card"></i> Credit Limit
                        </h4>

                        <div class="credit-display">
                            <span class="credit-display-label">Current Balance:</span>
                            <span id="currentCredit" class="credit-display-value">
                                $<fmt:formatNumber value="${user.creditLimit}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                            </span>
                        </div>

                        <form id="creditLimitForm" method="POST" action="update-profile" onsubmit="return validateCreditForm()">
                            <div id="js-credit-error" class="js-error-banner"></div>

                            <div class="bor8 m-b-20 max-w-300">
                                <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30"
                                       type="number" id="newCredit" name="newCredit"
                                       placeholder="Set New Credit Limit ($)" min="0" step="0.01">
                            </div>

                            <button type="submit" class="profile-btn">
                                <i class="fa fa-refresh"></i> Update Credit
                            </button>
                        </form>
                    </div>

                    <!-- ── Section 3: Change Password ───────────────────────── -->
                    <div id="change-password" class="profile-section">
                        <form id="passwordForm" method="POST" action="update-profile" onsubmit="return validatePasswordForm()">
                            <h4 class="profile-section-title">
                                <i class="fa fa-lock"></i> Change Password
                            </h4>

                            <div id="js-pw-error" class="js-error-banner"></div>

                            <div class="row">
                                <div class="col-sm-12 p-b-16">
                                    <p class="field-label">Current Password <span class="text-danger">*</span></p>
                                    <div class="bor8 pw-field-wrap">
                                        <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-45"
                                               type="password" name="currentPassword" id="currentPassword"
                                               placeholder="Enter your current password" required>
                                        <button type="button" class="toggle-pw" onclick="togglePwVis('currentPassword', this)">
                                            <i class="fa fa-eye"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6 p-b-16">
                                    <p class="field-label">New Password <span class="text-danger">*</span></p>
                                    <div class="bor8 pw-field-wrap">
                                        <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-45"
                                               type="password" name="newPassword" id="profileNewPw"
                                               placeholder="Min 6 characters" required>
                                        <button type="button" class="toggle-pw" onclick="togglePwVis('profileNewPw', this)">
                                            <i class="fa fa-eye"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-sm-6 p-b-16">
                                    <p class="field-label">Confirm New Password <span class="text-danger">*</span></p>
                                    <div class="bor8 pw-field-wrap">
                                        <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-45"
                                               type="password" name="confirmNewPassword" id="profileConfirmPw"
                                               placeholder="Repeat new password" required>
                                        <button type="button" class="toggle-pw" onclick="togglePwVis('profileConfirmPw', this)">
                                            <i class="fa fa-eye"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- Strength meter -->
                            <div class="strength-bar-wrap">
                                <div class="strength-bar" id="profileStrengthBar"></div>
                            </div>
                            <span class="strength-label" id="profileStrengthLabel">Password Strength</span>

                            <!-- Checklist -->
                            <ul class="pw-checklist" id="profileChecklist">
                                <li id="pck-len"><span class="icon">&#10005;</span> At least 6 characters</li>
                                <li id="pck-upper"><span class="icon">&#10005;</span> Contains uppercase letter</li>
                                <li id="pck-num"><span class="icon">&#10005;</span> Contains a number</li>
                                <li id="pck-match"><span class="icon">&#10005;</span> Passwords match</li>
                            </ul>

                            <button type="submit" id="pwSubmitBtn" class="profile-btn" disabled>
                                <i class="fa fa-shield"></i> Update Password
                            </button>
                        </form>
                    </div>

                    <!-- ── Section 4: Order History ──────────────────────────── -->
                    <div id="order-history" class="profile-section profile-orders">
                        <h4 class="profile-section-title">
                            <i class="fa fa-shopping-bag"></i> Order History
                        </h4>
                        <div class="wrap-table-shopping-cart bg0">
                            <table class="table-shopping-cart table-auto-width">
                                <tr class="table_head">
                                    <th class="column-1 pl-20">Order ID</th>
                                    <th class="column-2 text-center-cell">Date</th>
                                    <th class="column-3 text-center-cell">Total Amount</th>
                                    <th class="column-4 text-center-cell">Action</th>
                                </tr>
                                <c:choose>
                                    <c:when test="${not empty orders}">
                                        <c:forEach var="order" items="${orders}">
                                            <tr class="table_row">
                                                <td class="column-1 pl-20">#${order.orderId}</td>
                                                <td class="column-2 text-center-cell">${order.orderedAt}</td>
                                                <td class="column-3 text-center-cell">
                                                    $<fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                                </td>
                                                <td class="column-4 text-center-cell">
                                                    <a href="orderDetails?id=${order.orderId}" class="order-action-link">
                                                        <i class="fa fa-eye"></i> View
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr class="table_row">
                                            <td colspan="4">
                                                <div class="profile-empty">
                                                    <i class="fa fa-shopping-bag"></i>
                                                    <p>You haven't placed any orders yet.</p>
                                                    <a href="shop">Start Shopping</a>
                                                </div>
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

        // ── Smooth scroll for sidebar links ──────────────────────────────────
        document.querySelectorAll('.profile-sidebar a[data-section]').forEach(function(link) {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                var targetId = this.getAttribute('data-section');
                var target = document.getElementById(targetId);
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    // Update URL hash without jump
                    history.pushState(null, null, '#' + targetId);
                }
            });
        });

        // ── Scroll-spy for sidebar active state ──────────────────────────────
        (function() {
            var sections = document.querySelectorAll('.profile-section[id]');
            var links = document.querySelectorAll('.profile-sidebar a[data-section]');

            function updateActive() {
                var scrollPos = window.scrollY + 120; // offset for header

                var currentSection = null;
                sections.forEach(function(section) {
                    if (section.offsetTop <= scrollPos) {
                        currentSection = section.getAttribute('id');
                    }
                });

                links.forEach(function(link) {
                    link.classList.remove('sidebar-active');
                    if (link.getAttribute('data-section') === currentSection) {
                        link.classList.add('sidebar-active');
                    }
                });
            }

            window.addEventListener('scroll', updateActive);
            updateActive(); // initial call
        })();

        // ── Client-side validation for profile form ────────────────────────────
        function validateProfileForm() {
            var errorBanner = document.getElementById('js-error-banner');
            errorBanner.style.display = 'none';
            errorBanner.textContent = '';

            var name = document.getElementById('nameField').value.trim();
            if (!name) {
                showError(errorBanner, 'Name cannot be empty.');
                return false;
            }

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

        // ── Password toggle visibility ────────────────────────────────────────
        function togglePwVis(fieldId, btn) {
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

        // ── Password strength + checklist ─────────────────────────────────────
        (function () {
            var newPw = document.getElementById('profileNewPw');
            var confirmPw = document.getElementById('profileConfirmPw');
            var currentPw = document.getElementById('currentPassword');
            var submitBtn = document.getElementById('pwSubmitBtn');

            if (!newPw || !confirmPw || !currentPw) return;

            newPw.addEventListener('input', evalPw);
            confirmPw.addEventListener('input', evalPw);
            currentPw.addEventListener('input', evalPw);

            function evalPw() {
                var pw = newPw.value;
                var cpw = confirmPw.value;
                var curPw = currentPw.value;

                var hasLen = pw.length >= 6;
                var hasUpper = /[A-Z]/.test(pw);
                var hasNum = /[0-9]/.test(pw);
                var doesMatch = pw.length > 0 && pw === cpw;

                updatePwCheck('pck-len', hasLen);
                updatePwCheck('pck-upper', hasUpper);
                updatePwCheck('pck-num', hasNum);
                updatePwCheck('pck-match', doesMatch);

                // Strength bar
                var score = 0;
                if (pw.length >= 6) score++;
                if (pw.length >= 10) score++;
                if (hasUpper) score++;
                if (hasNum) score++;
                if (/[^A-Za-z0-9]/.test(pw)) score++;

                var bar = document.getElementById('profileStrengthBar');
                var label = document.getElementById('profileStrengthLabel');

                if (pw.length === 0) {
                    bar.style.width = '0%';
                    bar.style.backgroundColor = '#eee';
                    label.textContent = 'Password Strength';
                    label.style.color = '#999';
                } else if (score <= 2) {
                    bar.style.width = '33%';
                    bar.style.backgroundColor = '#e74c3c';
                    label.textContent = 'Weak';
                    label.style.color = '#e74c3c';
                } else if (score <= 3) {
                    bar.style.width = '66%';
                    bar.style.backgroundColor = '#f39c12';
                    label.textContent = 'Medium';
                    label.style.color = '#f39c12';
                } else {
                    bar.style.width = '100%';
                    bar.style.backgroundColor = '#27ae60';
                    label.textContent = 'Strong';
                    label.style.color = '#27ae60';
                }

                // Enable/disable submit
                if (hasLen && doesMatch && curPw.length > 0) {
                    submitBtn.disabled = false;
                } else {
                    submitBtn.disabled = true;
                }
            }

            function updatePwCheck(id, pass) {
                var el = document.getElementById(id);
                if (pass) {
                    el.classList.add('pass');
                    el.querySelector('.icon').innerHTML = '&#10003;';
                } else {
                    el.classList.remove('pass');
                    el.querySelector('.icon').innerHTML = '&#10005;';
                }
            }
        })();

        // ── Client-side validation for password form ────────────────────────────
        function validatePasswordForm() {
            var errorBanner = document.getElementById('js-pw-error');
            errorBanner.style.display = 'none';

            var curPw = document.getElementById('currentPassword').value;
            var newPw = document.getElementById('profileNewPw').value;
            var confirmPw = document.getElementById('profileConfirmPw').value;

            if (!curPw) {
                showError(errorBanner, 'Current password is required.');
                return false;
            }
            if (newPw.length < 6) {
                showError(errorBanner, 'New password must be at least 6 characters.');
                return false;
            }
            if (newPw !== confirmPw) {
                showError(errorBanner, 'New passwords do not match.');
                return false;
            }
            if (newPw === curPw) {
                showError(errorBanner, 'New password must be different from current password.');
                return false;
            }
            return true;
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
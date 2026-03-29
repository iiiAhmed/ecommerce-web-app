<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Set Your Password - Sync Store</title>
    <jsp:include page="includes/head.jsp" />
    <style>
        .pw-card {
            max-width: 480px;
            margin: 0 auto;
        }
        .pw-warning {
            background: #fff8e6;
            border: 1px solid #f0d78c;
            border-radius: 8px;
            padding: 14px 18px;
            margin-bottom: 24px;
            font-size: 14px;
            color: #856d0e;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .pw-warning i { font-size: 18px; }
        .pw-error {
            background: #fdf3f3;
            border: 1px solid #f0b8b8;
            color: #c0392b;
            border-radius: 8px;
            padding: 12px 16px;
            margin-bottom: 20px;
            font-size: 13px;
        }
        .pw-field-wrap {
            position: relative;
            margin-bottom: 16px;
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

        /* Strength meter */
        .strength-bar-wrap {
            height: 6px;
            background: #eee;
            border-radius: 3px;
            margin-bottom: 6px;
            overflow: hidden;
        }
        .strength-bar {
            height: 100%;
            width: 0%;
            border-radius: 3px;
            transition: width 0.3s ease, background-color 0.3s ease;
        }
        .strength-label {
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 14px;
            display: block;
        }

        /* Checklist */
        .pw-checklist {
            list-style: none;
            padding: 0;
            margin: 0 0 20px 0;
        }
        .pw-checklist li {
            font-size: 13px;
            padding: 3px 0;
            color: #999;
            transition: color 0.2s ease;
        }
        .pw-checklist li.pass { color: #27ae60; }
        .pw-checklist li .icon {
            display: inline-block;
            width: 18px;
            font-weight: 700;
        }

        .field-label {
            font-size: 12px;
            font-weight: 700;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }
    </style>
</head>

<body class="animsition">

    <!-- Title page -->
    <section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('images/bg-01.jpg');">
        <h2 class="ltext-105 cl0 txt-center">Set Your Password</h2>
    </section>

    <!-- Content -->
    <section class="bg0 p-t-75 p-b-116">
        <div class="container">
            <div class="pw-card">
                <div class="bor10 p-lr-50 p-t-40 p-b-40 p-lr-15-sm">

                    <div class="pw-warning">
                        <i class="fa fa-exclamation-triangle"></i>
                        <span>You must change your temporary password before continuing.</span>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="pw-error">
                            <i class="fa fa-exclamation-circle"></i> <c:out value="${error}"/>
                        </div>
                    </c:if>

                    <form id="changePwForm" method="POST" action="change-password" onsubmit="return validateForm()">

                        <p class="field-label">New Password <span class="text-danger">*</span></p>
                        <div class="pw-field-wrap bor8">
                            <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-45"
                                   type="password" name="newPassword" id="newPassword"
                                   placeholder="Enter new password" required>
                            <button type="button" class="toggle-pw" onclick="toggleVis('newPassword', this)">
                                <i class="fa fa-eye"></i>
                            </button>
                        </div>

                        <!-- Strength meter -->
                        <div class="strength-bar-wrap">
                            <div class="strength-bar" id="strengthBar"></div>
                        </div>
                        <span class="strength-label" id="strengthLabel" style="color: #999;">Password Strength</span>

                        <!-- Checklist -->
                        <ul class="pw-checklist" id="checklist">
                            <li id="ck-len"><span class="icon">&#10005;</span> At least 6 characters</li>
                            <li id="ck-upper"><span class="icon">&#10005;</span> Contains uppercase letter</li>
                            <li id="ck-num"><span class="icon">&#10005;</span> Contains a number</li>
                            <li id="ck-match"><span class="icon">&#10005;</span> Passwords match</li>
                        </ul>

                        <p class="field-label">Confirm Password <span class="text-danger">*</span></p>
                        <div class="pw-field-wrap bor8 m-b-30">
                            <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-45"
                                   type="password" name="confirmPassword" id="confirmPassword"
                                   placeholder="Confirm new password" required>
                            <button type="button" class="toggle-pw" onclick="toggleVis('confirmPassword', this)">
                                <i class="fa fa-eye"></i>
                            </button>
                        </div>

                        <button type="submit" id="submitBtn"
                            class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer"
                            disabled style="opacity: 0.5; cursor: not-allowed;">
                            Set Password
                        </button>

                        <div class="p-t-20 txt-center">
                            <a href="logout" class="stext-111 cl6 hov-cl1 trans-04" style="font-size: 13px;">
                                <i class="fa fa-sign-out"></i> Sign out instead
                            </a>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </section>

    <jsp:include page="includes/scripts.jsp" />
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

        var newPw = document.getElementById('newPassword');
        var confirmPw = document.getElementById('confirmPassword');
        var submitBtn = document.getElementById('submitBtn');

        newPw.addEventListener('input', evaluate);
        confirmPw.addEventListener('input', evaluate);

        function evaluate() {
            var pw = newPw.value;
            var cpw = confirmPw.value;

            var hasLen = pw.length >= 6;
            var hasUpper = /[A-Z]/.test(pw);
            var hasNum = /[0-9]/.test(pw);
            var doesMatch = pw.length > 0 && pw === cpw;

            updateCheck('ck-len', hasLen);
            updateCheck('ck-upper', hasUpper);
            updateCheck('ck-num', hasNum);
            updateCheck('ck-match', doesMatch);

            // Strength bar
            var score = 0;
            if (pw.length >= 6) score++;
            if (pw.length >= 10) score++;
            if (hasUpper) score++;
            if (hasNum) score++;
            if (/[^A-Za-z0-9]/.test(pw)) score++;

            var bar = document.getElementById('strengthBar');
            var label = document.getElementById('strengthLabel');

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
            if (hasLen && doesMatch) {
                submitBtn.disabled = false;
                submitBtn.style.opacity = '1';
                submitBtn.style.cursor = 'pointer';
            } else {
                submitBtn.disabled = true;
                submitBtn.style.opacity = '0.5';
                submitBtn.style.cursor = 'not-allowed';
            }
        }

        function updateCheck(id, pass) {
            var el = document.getElementById(id);
            if (pass) {
                el.classList.add('pass');
                el.querySelector('.icon').innerHTML = '&#10003;';
            } else {
                el.classList.remove('pass');
                el.querySelector('.icon').innerHTML = '&#10005;';
            }
        }

        function validateForm() {
            var pw = newPw.value;
            if (pw.length < 6) { alert('Password must be at least 6 characters.'); return false; }
            if (pw !== confirmPw.value) { alert('Passwords do not match.'); return false; }
            return true;
        }
    </script>
</body>

</html>

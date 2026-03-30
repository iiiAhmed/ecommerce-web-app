<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Sign In - Sync Store</title>
    <jsp:include page="includes/head.jsp" />
</head>

<body class="animsition">

    <jsp:include page="includes/header.jsp">
        <jsp:param name="activeMenu" value="" />
    </jsp:include>

    <jsp:include page="includes/cart-sidebar.jsp" />

    <!-- Title page -->
    <section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('images/bg-01.jpg');">
        <h2 class="ltext-105 cl0 txt-center">
            Welcome Back
        </h2>
    </section>

    <!-- Content page -->
    <section class="bg0 p-t-104 p-b-116">
        <div class="container">
            <div class="flex-w flex-tr justify-content-center">
                <div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md">
                    <form id="signInForm" method="POST" action="login" onsubmit="return validateLogin()">
                        <h4 class="mtext-105 cl2 txt-center p-b-30">
                            Sign In
                        </h4>

                        <div id="loginMessage" class="txt-center p-b-15" style="display:none;"></div>

                        <div class="bor8 m-b-20 how-pos4-parent">
                            <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="email" id="loginEmail"
                                   name="email" placeholder="Email Address" required maxlength="100">
                        </div>

                        <div class="bor8 m-b-30">
                            <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="password" id="loginPassword"
                                   name="password" placeholder="Password" required maxlength="100">
                        </div>

                        <button type="submit"
                            class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
                            Login
                        </button>

                        <div class="p-t-20 txt-center">
                            <span class="stext-111 cl2">Don't have an account?</span>
                            <a href="sign-up.jsp" class="stext-111 cl1 hov-cl1 trans-04">Click here to sign up</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="includes/footer.jsp" />

    <jsp:include page="includes/scripts.jsp" />
    <script>
        $(document).ready(function () {
            var params = new URLSearchParams(window.location.search);
            var msgDiv = $('#loginMessage');

            if (params.get('error') === 'invalid') {
                msgDiv.text('Invalid email or password. Please try again.')
                    .css('color', 'red').show();
            }
            if (params.get('registered') === 'true') {
                msgDiv.text('Registration successful! Please sign in.')
                    .css('color', 'green').show();
            }
        });

        function validateLogin() {
            var email = $('#loginEmail').val().trim();
            var password = $('#loginPassword').val();
            var msgDiv = $('#loginMessage');

            if (!email) {
                msgDiv.text('Please enter your email address.').css('color', 'red').show();
                return false;
            }
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                msgDiv.text('Please enter a valid email address.').css('color', 'red').show();
                return false;
            }
            if (!password) {
                msgDiv.text('Please enter your password.').css('color', 'red').show();
                return false;
            }
            return true;
        }
    </script>
</body>

</html>
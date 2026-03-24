<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Sign Up - Sync Store</title>
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
	</style>
</head>

<body class="animsition">

	<jsp:include page="includes/header.jsp">
		<jsp:param name="activeMenu" value="" />
	</jsp:include>

	<jsp:include page="includes/cart-sidebar.jsp" />

	<!-- Title page -->
	<section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('images/bg-01.jpg');">
		<h2 class="ltext-105 cl0 txt-center">
			Create an Account
		</h2>
	</section>

	<!-- Content page -->
	<section class="bg0 p-t-104 p-b-116">
		<div class="container">
			<div class="flex-w flex-tr justify-content-center">
				<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md">
					<form id="signupForm" method="POST" action="register" onsubmit="return validateSignUp(event)">
						<h4 class="mtext-105 cl2 txt-center p-b-30">
							Sign Up
						</h4>

						<div id="signupMessage" class="txt-center p-b-15" style="display:none;"></div>

						<div class="bor8 m-b-20 how-pos4-parent">
							<input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="text" id="name" name="name"
								placeholder="Full Name *" required>
						</div>

						<div class="bor8 m-b-20 how-pos4-parent">
							<input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="email" id="email"
								name="email" placeholder="Email Address *" required>
							<span id="emailFeedback" class="stext-115 cl1 p-l-20 p-t-5"
								style="display:none; color: red;"></span>
						</div>

						<div class="bor8 m-b-20 how-pos4-parent">
							<input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="password" id="password"
								name="password" placeholder="Password (min 6 characters) *" required minlength="6">
						</div>

						<div class="bor8 m-b-20 how-pos4-parent">
							<input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="date" id="birthday"
								name="birthday" placeholder="Birthday *" required>
						</div>

						<div class="bor8 m-b-20 how-pos4-parent">
							<input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="text" id="job" name="job"
								placeholder="Job Title *" required>
						</div>

						<div class="bor8 m-b-20 how-pos4-parent">
							<input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="number" id="credit_limit"
								name="credit_limit" placeholder="Credit Limit ($) * (min 100)" required min="100" step="0.01">
						</div>

						<div class="bor8 m-b-20">
							<textarea class="stext-111 cl2 plh3 size-120 p-lr-20 p-tb-25" id="address" name="address"
								placeholder="Shipping Address *" required></textarea>
						</div>

						<!-- Egyptian Phone Number -->
						<div class="bor8 m-b-20 d-flex align-items-center">
							<span class="stext-111 cl2 p-l-20 p-r-10" style="background-color: #f7f7f7; border-right: 1px solid #e6e6e6; height: 100%; display: flex; align-items: center;">
								+20
							</span>
							<input class="stext-111 cl2 plh3 size-116 p-l-10 p-r-30" type="tel" id="phone"
								name="phone" placeholder="10 digits (e.g. 1012345678) *"
								pattern="[0-9]{10}" maxlength="10" required style="border: none; outline: none; flex-grow: 1;">
						</div>
						<div class="m-b-20">
							<span id="phoneFeedback" class="stext-115 p-l-20 p-t-5"
								style="display:none; color: red; font-size:12px;"></span>
						</div>

						<!-- Interests -->
						<div class="m-b-30">
							<p class="stext-111 cl2 p-b-10"><b>Interests *</b> (select at least one)</p>
							<div class="interests-grid">
								<label class="interest-label">
									<input type="checkbox" name="interests" value="LUXURY">
									<span class="check-icon"></span>
									<span>Luxury</span>
								</label>
								<label class="interest-label">
									<input type="checkbox" name="interests" value="SPORT">
									<span class="check-icon"></span>
									<span>Sport</span>
								</label>
								<label class="interest-label">
									<input type="checkbox" name="interests" value="CASUAL">
									<span class="check-icon"></span>
									<span>Casual</span>
								</label>
								<label class="interest-label">
									<input type="checkbox" name="interests" value="CLASSIC">
									<span class="check-icon"></span>
									<span>Classic</span>
								</label>
								<label class="interest-label">
									<input type="checkbox" name="interests" value="DIGITAL">
									<span class="check-icon"></span>
									<span>Digital</span>
								</label>
								<label class="interest-label">
									<input type="checkbox" name="interests" value="SMART">
									<span class="check-icon"></span>
									<span>Smart</span>
								</label>
								<label class="interest-label">
									<input type="checkbox" name="interests" value="DIVING">
									<span class="check-icon"></span>
									<span>Diving</span>
								</label>
							</div>
							<span id="interestsFeedback" class="stext-115 p-l-10" style="display:none; color:red;"></span>
						</div>

						<button type="submit"
							class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
							Register Now
						</button>

						<div class="p-t-20 txt-center">
							<span class="stext-111 cl2">Already have an account?</span>
							<a href="sign-in.jsp" class="stext-111 cl1 hov-cl1 trans-04">Sign In</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>

	<jsp:include page="includes/footer.jsp" />

	<jsp:include page="includes/scripts.jsp" />
	<script>
		// Show error from URL params
		$(document).ready(function () {
			var params = new URLSearchParams(window.location.search);
			if (params.get('error') === 'email_taken') {
				$('#signupMessage').text('This email is already registered. Please use a different one.')
					.css('color', 'red').show();
			} else if (params.get('error') === 'invalid_phone') {
				$('#signupMessage').text('Invalid phone number. Egyptian numbers must start with +20 followed by 10 digits.')
					.css('color', 'red').show();
			}
		});

		// AJAX email availability check
		$('#email').on('blur', function () {
			var emailInput = $(this).val();
			var feedbackElem = $('#emailFeedback');
			if (!emailInput) return;
			feedbackElem.text('Checking availability...').css('color', 'blue').show();
			$.ajax({
				url: 'check-email',
				type: 'GET',
				data: { email: emailInput },
				dataType: 'json',
				success: function (data) {
					if (data.available) {
						feedbackElem.text('Email is available!').css('color', 'green');
					} else {
						feedbackElem.text('This email is already registered.').css('color', 'red');
					}
				},
				error: function () {
					feedbackElem.text('Could not check email. Please try again.').css('color', 'orange');
				}
			});
		});

		function validateSignUp(e) {
			var name = $('#name').val().trim();
			if (!/^[A-Za-z\s]+$/.test(name)) { alert('Name must contain only letters and spaces.'); e.preventDefault(); return false; }
			var email = $('#email').val().trim();
			if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) { alert('Please enter a valid email address.'); e.preventDefault(); return false; }
			var emailFeedback = $('#emailFeedback').text();
			if (emailFeedback === 'This email is already registered.') { alert('Please use a different email address.'); e.preventDefault(); return false; }
			var password = $('#password').val();
			if (password.length < 6) { alert('Password must be at least 6 characters.'); e.preventDefault(); return false; }
			var birthday = $('#birthday').val();
			if (!birthday) { alert('Please enter your birthday.'); e.preventDefault(); return false; }
			if (new Date(birthday) >= new Date()) { alert('Birthday must be a date in the past.'); e.preventDefault(); return false; }
			var creditLimit = parseFloat($('#credit_limit').val());
			if (isNaN(creditLimit) || creditLimit < 100) { alert('Credit limit must be at least $100.'); e.preventDefault(); return false; }
			var checkedInterests = $('input[name="interests"]:checked');
			if (checkedInterests.length === 0) { $('#interestsFeedback').text('Please select at least one interest.').show(); alert('Please select at least one interest.'); e.preventDefault(); return false; }
			var phone = $('#phone').val().trim();
			var phoneFeedback = $('#phoneFeedback');
			if (!/^[0-9]{10}$/.test(phone)) { phoneFeedback.text('Phone must be exactly 10 digits (e.g. 1012345678)').show(); alert('Phone must be exactly 10 digits.'); e.preventDefault(); return false; } else { phoneFeedback.hide(); }
			return true;
		}
	</script>

</body>

</html>
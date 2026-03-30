<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Sign Up - Sync Store</title>
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
								   placeholder="Full Name *" required maxlength="100">
						</div>

						<div class="bor8 m-b-20 how-pos4-parent">
							<input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="email" id="email"
								   name="email" placeholder="Email Address *" required maxlength="100">
							<span id="emailFeedback" class="stext-115 cl1 p-l-20 p-t-5"
								class="feedback-hidden"></span>
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
								   placeholder="Job Title *" required maxlength="50">
						</div>

						<div class="bor8 m-b-20 how-pos4-parent">
							<input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="number" id="credit_limit"
								   name="credit_limit" placeholder="Credit Limit ($) * (100 - 99,999)" required min="100" max="99999" step="0.01">
						</div>

						<div class="bor8 m-b-20">
							<textarea class="stext-111 cl2 plh3 size-120 p-lr-20 p-tb-25" id="address" name="address"
									  placeholder="Shipping Address *" required maxlength="500"></textarea>
						</div>

						<!-- Egyptian Phone Number -->
						<div class="bor8 m-b-20 d-flex align-items-center">
							<span class="stext-111 cl2 p-l-20 p-r-10 phone-prefix">
								+20
							</span>
							<input class="stext-111 cl2 plh3 size-116 p-l-10 p-r-30" type="tel" id="phone"
								name="phone" placeholder="10 digits (e.g. 1012345678) *"
								pattern="[0-9]{10}" maxlength="10" required class="phone-input-bare">
						</div>
						<div class="m-b-20">
							<span id="phoneFeedback" class="stext-115 p-l-20 p-t-5"
								class="feedback-hidden"></span>
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
							<span id="interestsFeedback" class="stext-115 p-l-10 feedback-hidden"></span>
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
			// Clear previous errors
			$('.field-error').text('').hide();
			$('.bor8').removeClass('is-invalid');

			var valid = true;

			// Name
			var name = $('#name').val().trim();
			if (!/^[A-Za-z\s]+$/.test(name)) {
				showFieldError('#name', 'Name must contain only letters and spaces.');
				valid = false;
			}

			// Email
			var email = $('#email').val().trim();
			if (email.length > 100) {
				showFieldError('#email', 'Email cannot exceed 100 characters.');
				valid = false;
			} else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
				showFieldError('#email', 'Please enter a valid email address.');
				valid = false;
			}
			var emailFeedback = $('#emailFeedback').text();
			if (emailFeedback === 'This email is already registered.') {
				showFieldError('#email', 'This email is already taken. Please use a different one.');
				valid = false;
			}

			// Password
			var password = $('#password').val();
			if (password.length < 6) {
				showFieldError('#password', 'Password must be at least 6 characters.');
				valid = false;
			}

			// Birthday
			var birthday = $('#birthday').val();
			if (!birthday) {
				showFieldError('#birthday', 'Please enter your birthday.');
				valid = false;
			} else {
				var bDate = new Date(birthday);
				var today = new Date();
				today.setHours(0,0,0,0);
				if (bDate >= today) {
					showFieldError('#birthday', 'Birthday must be a date in the past.');
					valid = false;
				} else {
					var age = today.getFullYear() - bDate.getFullYear();
					var m = today.getMonth() - bDate.getMonth();
					if (m < 0 || (m === 0 && today.getDate() < bDate.getDate())) age--;
					if (age < 18) {
						showFieldError('#birthday', 'You must be at least 18 years old.');
						valid = false;
					} else if (age > 120) {
						showFieldError('#birthday', 'Please enter a realistic date of birth.');
						valid = false;
					}
				}
			}

			var job = $('#job').val().trim();
			if (job.length === 0) {
				showFieldError('#job', 'Job title is required.');
				valid = false;
			} else if (job.length > 50) {
				showFieldError('#job', 'Job title cannot exceed 50 characters.');
				valid = false;
			}

			// Credit Limit
			var creditLimit = parseFloat($('#credit_limit').val());
			if (isNaN(creditLimit) || creditLimit < 100) {
				showFieldError('#credit_limit', 'Credit limit must be at least $100.');
				valid = false;
			}else if (creditLimit > 99999) {
				showFieldError('#credit_limit', 'Credit limit cannot exceed $99,999.');
				valid = false;
			}

			var address = $('#address').val().trim();
			if (address.length === 0) {
				showFieldError('#address', 'Address is required.');
				valid = false;
			} else if (address.length > 500) {
				showFieldError('#address', 'Address cannot exceed 500 characters.');
				valid = false;
			}

			// Interests
			var checkedInterests = $('input[name="interests"]:checked');
			if (checkedInterests.length === 0) {
				$('#interestsFeedback').text('Please select at least one interest.').show();
				valid = false;
			}

			// Phone
			var phone = $('#phone').val().trim();
			if (!/^[0-9]{10}$/.test(phone)) {
				$('#phoneFeedback').text('Phone must be exactly 10 digits (e.g. 1012345678)').show();
				valid = false;
			} else {
				$('#phoneFeedback').hide();
			}

			if (!valid) {
				e.preventDefault();
				// Scroll to first error
				var firstError = $('.is-invalid, .field-error:visible').first();
				if (firstError.length) {
					$('html, body').animate({ scrollTop: firstError.offset().top - 120 }, 300);
				}
				return false;
			}
			return true;
		}

		function showFieldError(fieldSelector, message) {
			var field = $(fieldSelector);
			field.closest('.bor8, .bor8.how-pos4-parent').addClass('is-invalid');
			// Find or create error span after the field's parent
			var parent = field.closest('.m-b-20, .m-b-30');
			var errorSpan = parent.find('.field-error');
			if (errorSpan.length === 0) {
				errorSpan = $('<span class="field-error"></span>');
				parent.append(errorSpan);
			}
			errorSpan.text(message).show();
		}
	</script>

</body>

</html>
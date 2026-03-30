<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Contact - Sync Store</title>
	<jsp:include page="includes/head.jsp" />
</head>

<body class="animsition">

	<jsp:include page="includes/header.jsp">
		<jsp:param name="activeMenu" value="contact" />
	</jsp:include>

	<jsp:include page="includes/cart-sidebar.jsp" />

	<!-- Title page -->
	<section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('images/bg-01.jpg');">
		<h2 class="ltext-105 cl0 txt-center">
			Contact
		</h2>
	</section>


	<!-- Content page -->
	<section class="bg0 p-t-104 p-b-116">
		<div class="container">
			<div class="flex-w flex-tr">
				<div class="size-210 bor10 p-lr-70 p-t-55 p-b-70 p-lr-15-lg w-full-md">
					<form id="contactForm" onsubmit="return handleContactSubmit(event)">
						<h4 class="mtext-105 cl2 txt-center p-b-30">
							Send Us A Message
						</h4>

						<div id="contactSuccess" class="profile-alert success" style="display: none;">
							<i class="fa fa-check-circle"></i>
							<span>Thank you! Your message has been received.</span>
						</div>

						<div class="bor8 m-b-20 how-pos4-parent">
							<input class="stext-111 cl2 plh3 size-116 p-l-62 p-r-30" type="email" name="email"
								placeholder="Your Email Address" required id="contactEmail">
							<img class="how-pos4 pointer-none" src="images/icons/icon-email.png" alt="ICON">
							<span class="field-error" id="contactEmailError"></span>
						</div>

						<div class="bor8 m-b-30">
							<textarea class="stext-111 cl2 plh3 size-120 p-lr-28 p-tb-25" name="msg"
								placeholder="How Can We Help?" required id="contactMsg" minlength="10"></textarea>
							<span class="field-error" id="contactMsgError"></span>
						</div>

						<button type="submit" class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
							Submit
						</button>
					</form>
				</div>

				<div class="size-210 bor10 flex-w flex-col-m p-lr-93 p-tb-30 p-lr-15-lg w-full-md">
					<div class="flex-w w-full p-b-42">
						<span class="fs-18 cl5 txt-center size-211">
							<span class="lnr lnr-map-marker"></span>
						</span>

						<div class="size-212 p-t-2">
							<span class="mtext-110 cl2">
								Address
							</span>

							<p class="stext-115 cl6 size-213 p-t-18">
								Smart Village building B148 - 28 Km by Cairo / Alexandria Desert road- 6 October
							</p>
						</div>
					</div>

					<div class="flex-w w-full p-b-42">
						<span class="fs-18 cl5 txt-center size-211">
							<span class="lnr lnr-phone-handset"></span>
						</span>

						<div class="size-212 p-t-2">
							<span class="mtext-110 cl2">
								Lets Talk
							</span>

							<p class="stext-115 cl1 size-213 p-t-18">
								+20-2-353-55656
							</p>
						</div>
					</div>

					<div class="flex-w w-full">
						<span class="fs-18 cl5 txt-center size-211">
							<span class="lnr lnr-envelope"></span>
						</span>

						<div class="size-212 p-t-2">
							<span class="mtext-110 cl2">
								Sale Support
							</span>

							<p class="stext-115 cl1 size-213 p-t-18">
								itiinfo@iti.gov.eg
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>


	<jsp:include page="includes/footer.jsp" />

	<jsp:include page="includes/scripts.jsp" />

	<script>
		function handleContactSubmit(e) {
			e.preventDefault();
			var email = document.getElementById('contactEmail');
			var msg = document.getElementById('contactMsg');
			var emailErr = document.getElementById('contactEmailError');
			var msgErr = document.getElementById('contactMsgError');
			var valid = true;

			emailErr.textContent = '';
			msgErr.textContent = '';
			email.closest('.bor8').classList.remove('is-invalid');
			msg.closest('.bor8').classList.remove('is-invalid');

			if (!email.value || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
				emailErr.textContent = 'Please enter a valid email address.';
				emailErr.style.display = 'block';
				email.closest('.bor8').classList.add('is-invalid');
				valid = false;
			}

			if (!msg.value || msg.value.trim().length < 10) {
				msgErr.textContent = 'Please enter a message (at least 10 characters).';
				msgErr.style.display = 'block';
				msg.closest('.bor8').classList.add('is-invalid');
				valid = false;
			}

			if (valid) {
				document.getElementById('contactSuccess').style.display = 'flex';
				document.getElementById('contactForm').reset();
				setTimeout(function() {
					document.getElementById('contactSuccess').style.display = 'none';
				}, 5000);
			}
			return false;
		}
	</script>

</body>

</html>
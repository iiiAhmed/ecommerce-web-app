<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>About - Sync Store</title>
	<jsp:include page="includes/head.jsp" />
</head>

<body class="animsition">

	<jsp:include page="includes/header.jsp">
		<jsp:param name="activeMenu" value="about" />
	</jsp:include>

	<jsp:include page="includes/cart-sidebar.jsp" />

	<!-- Title page -->
	<section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('images/bg-01.jpg');">
		<h2 class="ltext-105 cl0 txt-center">
			About
		</h2>
	</section>


	<!-- Meet the Team -->
	<section class="bg0 p-t-45 p-b-100" style="background: linear-gradient(180deg, #f7f7f7 0%, #ffffff 100%);">
		<div class="container">
			<div class="txt-center p-b-60">
				<span class="stext-107 cl7" style="text-transform: uppercase; letter-spacing: 4px; font-size: 12px;">
					Who we are
				</span>
				<h3 class="ltext-103 cl2 p-t-12">
					Meet the Creators
				</h3>
				<div style="width: 50px; height: 3px; background: #717fe0; margin: 18px auto 0; border-radius: 2px;"></div>
			</div>

			<div class="row justify-content-center" style="gap: 0;">

				<!-- Member 1 -->
				<div class="col-md-4 col-lg-3 p-b-30 txt-center team-member">
					<div class="team-photo-wrap m-lr-auto">
						<div class="team-photo">
							<img src="images/member-01.jpg" alt="Team Member">
						</div>
					</div>
					<h5 class="mtext-108 cl2 p-t-24 p-b-4">Member Name</h5>
					<span class="stext-107 cl7" style="letter-spacing: 1.5px; text-transform: uppercase; font-size: 11px;">
						Co-Founder
					</span>
					<div class="team-social p-t-14">
						<a href="#" class="fs-16 cl7 hov-cl1 trans-04 m-lr-8"><i class="fa fa-linkedin"></i></a>
						<a href="#" class="fs-16 cl7 hov-cl1 trans-04 m-lr-8"><i class="fa fa-github"></i></a>
					</div>
				</div>

				<!-- Member 2 -->
				<div class="col-md-4 col-lg-3 p-b-30 txt-center team-member">
					<div class="team-photo-wrap m-lr-auto">
						<div class="team-photo">
							<img src="images/member-02.jpg" alt="Team Member">
						</div>
					</div>
					<h5 class="mtext-108 cl2 p-t-24 p-b-4">Member Name</h5>
					<span class="stext-107 cl7" style="letter-spacing: 1.5px; text-transform: uppercase; font-size: 11px;">
						Co-Founder
					</span>
					<div class="team-social p-t-14">
						<a href="#" class="fs-16 cl7 hov-cl1 trans-04 m-lr-8"><i class="fa fa-linkedin"></i></a>
						<a href="#" class="fs-16 cl7 hov-cl1 trans-04 m-lr-8"><i class="fa fa-github"></i></a>
					</div>
				</div>

				<!-- Member 3 -->
				<div class="col-md-4 col-lg-3 p-b-30 txt-center team-member">
					<div class="team-photo-wrap m-lr-auto">
						<div class="team-photo">
							<img src="images/member-03.jpg" alt="Team Member">
						</div>
					</div>
					<h5 class="mtext-108 cl2 p-t-24 p-b-4">Member Name</h5>
					<span class="stext-107 cl7" style="letter-spacing: 1.5px; text-transform: uppercase; font-size: 11px;">
						Co-Founder
					</span>
					<div class="team-social p-t-14">
						<a href="#" class="fs-16 cl7 hov-cl1 trans-04 m-lr-8"><i class="fa fa-linkedin"></i></a>
						<a href="#" class="fs-16 cl7 hov-cl1 trans-04 m-lr-8"><i class="fa fa-github"></i></a>
					</div>
				</div>

			</div>
		</div>
	</section>

	<style>
		.team-photo-wrap {
			width: 180px;
			height: 180px;
			border-radius: 50%;
			padding: 4px;
			background: linear-gradient(135deg, #717fe0, #a8b1ff);
			transition: transform 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94), box-shadow 0.4s ease;
		}

		.team-photo-wrap:hover {
			transform: translateY(-8px);
			box-shadow: 0 18px 40px rgba(113, 127, 224, 0.25);
		}

		.team-photo {
			width: 100%;
			height: 100%;
			border-radius: 50%;
			overflow: hidden;
			border: 3px solid #fff;
		}

		.team-photo img {
			width: 100%;
			height: 100%;
			object-fit: cover;
			transition: transform 0.5s ease;
		}

		.team-photo-wrap:hover .team-photo img {
			transform: scale(1.08);
		}

		.team-member {
			transition: transform 0.3s ease;
		}

		.team-social a {
			display: inline-flex;
			width: 32px;
			height: 32px;
			align-items: center;
			justify-content: center;
			border-radius: 50%;
			border: 1px solid #e5e5e5;
			transition: all 0.3s ease;
		}

		.team-social a:hover {
			background: #717fe0;
			border-color: #717fe0;
			color: #fff !important;
		}
	</style>


	<!-- Content page -->
	<section class="bg0 p-t-75 p-b-120">
		<div class="container">
			<div class="row p-b-148">
				<div class="col-md-7 col-lg-8">
					<div class="p-t-7 p-r-85 p-r-15-lg p-r-0-md">
						<h3 class="mtext-111 cl2 p-b-16">
							Our Story
						</h3>

						<p class="stext-113 cl6 p-b-26">
							At Sync Store, we believe that a watch is more than just a timepiece it's a statement
							of style, craftsmanship, and precision. Founded with a passion for horology, our mission
							is to bring the world's finest watches to discerning customers who appreciate quality
							and design.
						</p>

						<p class="stext-113 cl6 p-b-26">
							From luxury Swiss movements to cutting-edge smartwatches, our curated collection spans
							every category - sport, classic, casual, diving, and digital. Each watch in our catalog
							is handpicked by our team of experts to ensure it meets our exacting standards of
							quality and elegance.
						</p>

					</div>
				</div>

				<div class="col-11 col-md-5 col-lg-4 m-lr-auto">
					<div class="how-bor1 ">
						<div class="hov-img0">
							<img src="images/about-01.jpg" alt="IMG">
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="order-md-2 col-md-7 col-lg-8 p-b-30">
					<div class="p-t-7 p-l-85 p-l-15-lg p-l-0-md">
						<h3 class="mtext-111 cl2 p-b-16">
							Our Mission
						</h3>

						<p class="stext-113 cl6 p-b-26">
							We are committed to providing an exceptional shopping experience  from the moment you
							browse our collection to the unboxing of your new timepiece. Our team provides expert
							guidance, ensuring you find the perfect watch for every occasion, whether it's a gift,
							a milestone celebration, or your daily companion. Every detail matters to us, just
							as every second matters to you.
						</p>

						<div class="bor16 p-l-29 p-b-9 m-t-22">
							<p class="stext-114 cl6 p-r-40 p-b-11">
								Time is the most valuable thing a man can spend. A fine watch reminds us
								to make every moment count.
							</p>

							<span class="stext-111 cl8">
								- Theophrastus
							</span>
						</div>
					</div>
				</div>

				<div class="order-md-1 col-11 col-md-5 col-lg-4 m-lr-auto p-b-30">
					<div class="how-bor2">
						<div class="hov-img0">
							<img src="images/about-02.jpg" alt="IMG">
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>




	<jsp:include page="includes/footer.jsp" />

	<jsp:include page="includes/scripts.jsp" />

</body>

</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Sync Store - Premium Watches</title>
	<jsp:include page="includes/head.jsp" />

</head>

<body class="animsition">

	<!-- Header -->
	<jsp:include page="includes/header.jsp">
		<jsp:param name="activeMenu" value="home" />
	</jsp:include>

	<jsp:include page="includes/cart-sidebar.jsp" />


	<!-- Slider -->
	<section class="section-slide">
		<div class="wrap-slick1">
			<div class="slick1">

				<div class="item-slick1" style="background-image: url(images/slide-01.jpg);">
					<div class="container h-full">
						<div class="flex-col-l-m h-full p-t-100 p-b-30 respon5">
							<div class="layer-slick1 animated visible-false" data-appear="fadeInDown" data-delay="0">
								<span class="ltext-101 cl2 respon2">
									Premium Watches
								</span>
							</div>

							<div class="layer-slick1 animated visible-false" data-appear="fadeInUp" data-delay="800">
								<h2 class="ltext-201 cl2 p-t-19 p-b-43 respon1">
									NEW COLLECTION 2026
								</h2>
							</div>

							<div class="layer-slick1 animated visible-false" data-appear="fadeInUp" data-delay="1600">
								<a href="shop"
									class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04">
									Shop Now
								</a>
							</div>
						</div>
					</div>
				</div>

				<div class="item-slick1" style="background-image: url(images/slide-02.jpg);">
					<div class="container h-full">
						<div class="flex-col-l-m h-full p-t-100 p-b-30 respon5">
							<div class="layer-slick1 animated visible-false" data-appear="fadeInDown" data-delay="0">
								<span class="ltext-101 cl2 respon2">
									Luxury Timepieces
								</span>
							</div>

							<div class="layer-slick1 animated visible-false" data-appear="fadeInUp" data-delay="800">
								<h2 class="ltext-201 cl2 p-t-19 p-b-43 respon1">
									CRAFTED FOR EXCELLENCE
								</h2>
							</div>

							<div class="layer-slick1 animated visible-false" data-appear="fadeInUp" data-delay="1600">
								<a href="shop"
									class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04">
									Shop Now
								</a>
							</div>
						</div>
					</div>
				</div>

				<div class="item-slick1" style="background-image: url(images/slide-03.jpg);">
					<div class="container h-full">
						<div class="flex-col-l-m h-full p-t-100 p-b-30 respon5">
							<div class="layer-slick1 animated visible-false" data-appear="fadeInDown" data-delay="0">
								<span class="ltext-101 cl2 respon2">
									Smart Collection
								</span>
							</div>

							<div class="layer-slick1 animated visible-false" data-appear="fadeInUp" data-delay="800">
								<h2 class="ltext-201 cl2 p-t-19 p-b-43 respon1">
									BUILT TO PERFORM
								</h2>
							</div>

							<div class="layer-slick1 animated visible-false" data-appear="fadeInUp" data-delay="1600">
								<a href="shop"
									class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04">
									Shop Now
								</a>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</section>


	<!-- Banner -->
	<div class="sec-banner bg0 p-t-80 p-b-50">
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-xl-4 p-b-30 m-lr-auto">
					<!-- Banner  -->
					<div class="block1 wrap-pic-w">
						<img src="images/banner-01.jpg" alt="Luxury Watches">

						<a href="shop?category=LUXURY"
							class="block1-txt ab-t-l s-full flex-col-l-sb p-lr-38 p-tb-34 trans-03 respon3">
							<div class="block1-txt-child1 flex-col-l">
								<span class="block1-name ltext-102 trans-04 p-b-8">
									Luxury
								</span>

								<span class="block1-info stext-102 trans-04">
									Premium Collection
								</span>
							</div>

							<div class="block1-txt-child2 p-b-4 trans-05">
								<div class="block1-link stext-101 cl0 trans-09">
									Shop Now
								</div>
							</div>
						</a>
					</div>
				</div>

				<div class="col-md-6 col-xl-4 p-b-30 m-lr-auto">
					<!-- Banner  -->
					<div class="block1 wrap-pic-w">
						<img src="images/banner-02.jpg" alt="Sport Watches">

						<a href="shop?category=SPORT"
							class="block1-txt ab-t-l s-full flex-col-l-sb p-lr-38 p-tb-34 trans-03 respon3">
							<div class="block1-txt-child1 flex-col-l">
								<span class="block1-name ltext-102 trans-04 p-b-8">
									Sport
								</span>

								<span class="block1-info stext-102 trans-04">
									Active Collection
								</span>
							</div>

							<div class="block1-txt-child2 p-b-4 trans-05">
								<div class="block1-link stext-101 cl0 trans-09">
									Shop Now
								</div>
							</div>
						</a>
					</div>
				</div>

				<div class="col-md-6 col-xl-4 p-b-30 m-lr-auto">
					<!-- Banner  -->
					<div class="block1 wrap-pic-w">
						<img src="images/banner-03.jpg" alt="Classic Watches">

						<a href="shop?category=CLASSIC"
							class="block1-txt ab-t-l s-full flex-col-l-sb p-lr-38 p-tb-34 trans-03 respon3">
							<div class="block1-txt-child1 flex-col-l">
								<span class="block1-name ltext-102 trans-04 p-b-8">
									Classic
								</span>

								<span class="block1-info stext-102 trans-04">
									Timeless Collection
								</span>
							</div>

							<div class="block1-txt-child2 p-b-4 trans-05">
								<div class="block1-link stext-101 cl0 trans-09">
									Shop Now
								</div>
							</div>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Trust Badges -->
	<section class="trust-badges bg0 p-t-60 p-b-60">
		<div class="container">
			<div class="row">
				<div class="col-6 col-md-3 p-b-20">
					<div class="trust-badge">
						<i class="fa fa-truck"></i>
						<h5>Free Shipping</h5>
						<p>On all orders over $100</p>
					</div>
				</div>
				<div class="col-6 col-md-3 p-b-20">
					<div class="trust-badge">
						<i class="fa fa-lock"></i>
						<h5>Secure Payment</h5>
						<p>100% protected checkout</p>
					</div>
				</div>
				<div class="col-6 col-md-3 p-b-20">
					<div class="trust-badge">
						<i class="fa fa-refresh"></i>
						<h5>Easy Returns</h5>
						<p>30-day return policy</p>
					</div>
				</div>
				<div class="col-6 col-md-3 p-b-20">
					<div class="trust-badge">
						<i class="fa fa-shield"></i>
						<h5>2-Year Warranty</h5>
						<p>Manufacturer guarantee</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<jsp:include page="includes/footer.jsp" />


	<jsp:include page="includes/scripts.jsp" />

	<!-- Page-specific: Slider & Parallax -->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
	<script src="vendor/slick/slick.min.js"></script>
	<script src="js/slick-custom.js"></script>
	<script src="vendor/parallax100/parallax100.js"></script>
	<script>
		$('.parallax100').parallax100();
	</script>

</body>

</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="jakarta.tags.core" %>
		<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
			<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
				<!DOCTYPE html>
				<html lang="en">

				<head>
					<title>Store</title>
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
					<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
					<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
					<link rel="stylesheet" type="text/css" href="vendor/slick/slick.css">
					<link rel="stylesheet" type="text/css" href="vendor/MagnificPopup/magnific-popup.css">
					<link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">
					<link rel="stylesheet" type="text/css" href="css/util.css">
					<link rel="stylesheet" type="text/css" href="css/main.css">
					<style>
						.block2-pic {
							width: 100%;
							height: 280px;
							overflow: hidden;
						}

						.block2-pic img {
							width: 100%;
							height: 100%;
							object-fit: cover;
							object-position: center;
							transition: transform 0.4s ease;
						}

						.block2-pic:hover img {
							transform: scale(1.05);
						}

						.stock-out {
							color: #e74c3c;
							font-weight: bold;
							font-size: 12px;
						}

						.stock-low {
							color: #e67e22;
							font-size: 12px;
						}
					</style>
				</head>

				<body class="animsition">

					<!-- Header -->
					<header class="header-v4">
						<!-- Header desktop -->
						<div class="container-menu-desktop">
							<div class="wrap-menu-desktop how-shadow1">
								<nav class="limiter-menu-desktop container">

									<!-- Logo desktop -->
									<a href="index.jsp" class="logo">
										<img src="images/icons/logo-01.png" alt="IMG-LOGO">
									</a>

									<!-- Menu desktop -->
									<div class="menu-desktop">
										<ul class="main-menu">
											<li><a href="index.jsp">Home</a></li>
											<li class="active-menu"><a href="shop">Shop</a></li>
											<li><a href="about.html">About</a></li>
											<li><a href="contact.html">Contact</a></li>
										</ul>
									</div>

									<!-- Icon header -->
									<div class="wrap-icon-header flex-w flex-r-m">
										<div
											class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-modal-search">
											<i class="zmdi zmdi-search"></i>
										</div>
										<div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti js-show-cart"
											data-notify="0">
											<i class="zmdi zmdi-shopping-cart"></i>
										</div>
										<a href="#"
											class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti"
											data-notify="0">
											<i class="zmdi zmdi-favorite-outline"></i>
										</a>
										<a href="profile" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11">
											<i class="zmdi zmdi-account-circle"></i>
										</a>
									</div>
								</nav>
							</div>
						</div>

						<!-- Header Mobile -->
						<div class="wrap-header-mobile">
							<div class="logo-mobile">
								<a href="index.jsp"><img src="images/icons/logo-01.png" alt="IMG-LOGO"></a>
							</div>
							<div class="wrap-icon-header flex-w flex-r-m m-r-15">
								<div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 js-show-modal-search">
									<i class="zmdi zmdi-search"></i>
								</div>
								<div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti js-show-cart"
									data-notify="0">
									<i class="zmdi zmdi-shopping-cart"></i>
								</div>
								<a href="#"
									class="dis-block icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti"
									data-notify="0">
									<i class="zmdi zmdi-favorite-outline"></i>
								</a>
								<a href="profile" class="dis-block icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10">
									<i class="zmdi zmdi-account-circle"></i>
								</a>
							</div>
							<div class="btn-show-menu-mobile hamburger hamburger--squeeze">
								<span class="hamburger-box"><span class="hamburger-inner"></span></span>
							</div>
						</div>

						<!-- Menu Mobile -->
						<div class="menu-mobile">
							<ul class="main-menu-m">
								<li><a href="index.jsp">Home</a></li>
								<li><a href="shop">Shop</a></li>
								<li><a href="about.html">About</a></li>
								<li><a href="contact.html">Contact</a></li>
							</ul>
						</div>

						<!-- Modal Search -->
						<div class="modal-search-header flex-c-m trans-04 js-hide-modal-search">
							<div class="container-search-header">
								<button class="flex-c-m btn-hide-modal-search trans-04 js-hide-modal-search">
									<img src="images/icons/icon-close2.png" alt="CLOSE">
								</button>
								<form class="wrap-search-header flex-w p-l-15">
									<button class="flex-c-m trans-04">
										<i class="zmdi zmdi-search"></i>
									</button>
									<input class="plh3" type="text" name="search" placeholder="Search...">
								</form>
							</div>
						</div>
					</header>

					<!-- Cart -->
					<div class="wrap-header-cart js-panel-cart">
						<div class="s-full js-hide-cart"></div>
						<div class="header-cart flex-col-l p-l-65 p-r-25">
							<div class="header-cart-title flex-w flex-sb-m p-b-8">
								<span class="mtext-103 cl2">Your Cart</span>
								<div class="fs-35 lh-10 cl2 p-lr-5 pointer hov-cl1 trans-04 js-hide-cart">
									<i class="zmdi zmdi-close"></i>
								</div>
							</div>
							<div class="header-cart-content flex-w js-pscroll">
								<ul class="header-cart-wrapitem w-full">
									<li class="header-cart-item flex-w flex-t m-b-12">
										<div class="header-cart-item-img">
											<img src="images/item-cart-01.jpg" alt="IMG">
										</div>
										<div class="header-cart-item-txt p-t-8">
											<a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">White
												Shirt Pleat</a>
											<span class="header-cart-item-info">1 x $19.00</span>
										</div>
									</li>
								</ul>
								<div class="w-full">
									<div class="header-cart-total w-full p-tb-40">Total: $19.00</div>
									<div class="header-cart-buttons flex-w w-full">
										<a href="shopping-cart.html"
											class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-r-8 m-b-10">
											View Cart
										</a>
										<a href="shopping-cart.html"
											class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-b-10">
											Check Out
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Product -->
					<div class="bg0 m-t-23 p-b-140">
						<div class="container">
							<div class="flex-w flex-sb-m p-b-52">

								<div class="flex-w flex-l-m filter-tope-group m-tb-10">
									<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 how-active1"
										data-filter="*">
										All Products
									</button>
									<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".male">
										Men
									</button>
									<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5"
										data-filter=".female">
										Women
									</button>
									<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".sport">
										Sport
									</button>
									<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5"
										data-filter=".luxury">
										Luxury
									</button>
									<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5"
										data-filter=".classic">
										Classic
									</button>
									<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5"
										data-filter=".casual">
										Casual
									</button>
								</div>

								<div class="flex-w flex-c-m m-tb-10">
									<div
										class="flex-c-m stext-106 cl6 size-104 bor4 pointer hov-btn3 trans-04 m-r-8 m-tb-4 js-show-filter">
										<i class="icon-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-filter-list"></i>
										<i
											class="icon-close-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
										Filter
									</div>
									<div
										class="flex-c-m stext-106 cl6 size-105 bor4 pointer hov-btn3 trans-04 m-tb-4 js-show-search">
										<i class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-search"></i>
										<i
											class="icon-close-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
										Search
									</div>
								</div>

								<!-- Search product -->
								<div class="dis-none panel-search w-full p-t-10 p-b-15">
									<div class="bor8 dis-flex p-l-15">
										<button class="size-113 flex-c-m fs-16 cl2 hov-cl1 trans-04">
											<i class="zmdi zmdi-search"></i>
										</button>
										<input class="mtext-107 cl2 size-114 plh2 p-r-15" type="text"
											name="search-product" placeholder="Search">
									</div>
								</div>

								<!-- Filter panel -->
								<div class="dis-none panel-filter w-full p-t-10">
									<div class="wrap-filter flex-w bg6 w-full p-lr-40 p-t-27 p-lr-15-sm">
										<div class="filter-col1 p-r-15 p-b-27">
											<div class="mtext-102 cl2 p-b-15">Sort By</div>
											<ul>
												<li class="p-b-6"><a href="#"
														class="filter-link stext-106 trans-04">Default</a></li>
												<li class="p-b-6"><a href="#"
														class="filter-link stext-106 trans-04">Popularity</a></li>
												<li class="p-b-6"><a href="#"
														class="filter-link stext-106 trans-04 filter-link-active">Newness</a>
												</li>
												<li class="p-b-6"><a href="#"
														class="filter-link stext-106 trans-04">Price: Low to High</a>
												</li>
												<li class="p-b-6"><a href="#"
														class="filter-link stext-106 trans-04">Price: High to Low</a>
												</li>
											</ul>
										</div>

										<div class="filter-col2 p-r-15 p-b-27">
											<div class="mtext-102 cl2 p-b-15">Price</div>
											<ul>
												<li class="p-b-6"><a href="#"
														class="filter-link stext-106 trans-04 filter-link-active">All</a>
												</li>
												<li class="p-b-6"><a href="#"
														class="filter-link stext-106 trans-04">$0.00 - $500.00</a></li>
												<li class="p-b-6"><a href="#"
														class="filter-link stext-106 trans-04">$500.00 - $2000.00</a>
												</li>
												<li class="p-b-6"><a href="#"
														class="filter-link stext-106 trans-04">$2000.00 - $5000.00</a>
												</li>
												<li class="p-b-6"><a href="#"
														class="filter-link stext-106 trans-04">$5000.00+</a></li>
											</ul>
										</div>

										<div class="filter-col3 p-r-15 p-b-27">
											<div class="mtext-102 cl2 p-b-15">Tags</div>
											<div class="flex-w p-t-4 m-r--5">
												<a href="#"
													class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">Sport</a>
												<a href="#"
													class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">Luxury</a>
												<a href="#"
													class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">Classic</a>
												<a href="#"
													class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">Casual</a>
												<a href="#"
													class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">Smart</a>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="row isotope-grid">
								<c:choose>
									<c:when test="${not empty products}">
										<c:forEach var="product" items="${products}">
											<div
												class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item ${fn:toLowerCase(product.gender.name())} ${fn:toLowerCase(product.category.name())}">
												<div class="block2">
													<div class="block2-pic hov-img0">
														<img src="${empty product.imageUrl ? 'images/product-01.jpg' : product.imageUrl}"
															alt="${product.name}">

														<div class="block2-qty flex-c-m trans-04">
															<button type="button" class="block2-qty-btn"
																onclick="changeQty(this, -1)">&minus;</button>
															<span class="block2-qty-num">0</span>
															<button type="button" class="block2-qty-btn"
																onclick="changeQty(this, 1)">+</button>
														</div>
													</div>

													<div class="block2-txt flex-w flex-t p-t-14">
														<div class="block2-txt-child1 flex-col-l">
															<a href="product?id=${product.productId}"
																class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
																${product.name}
															</a>

															<span class="stext-105 cl3">
																$
																<fmt:formatNumber value="${product.price}"
																	minFractionDigits="2" maxFractionDigits="2" />
															</span>

															<span class="stext-102 cl3 p-t-4">
																${product.brand}
															</span>

															<c:choose>
																<c:when test="${product.quantity == 0}">
																	<span class="stock-out p-t-4">Out of stock</span>
																</c:when>
																<c:when test="${product.quantity <= 5}">
																	<span class="stock-low p-t-4">Only
																		${product.quantity} left!</span>
																</c:when>
															</c:choose>
														</div>

														<div class="block2-txt-child2 flex-r p-t-3">
															<a href="#"
																class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
																<img class="icon-heart1 dis-block trans-04"
																	src="images/icons/icon-heart-01.png" alt="ICON">
																<img class="icon-heart2 dis-block trans-04 ab-t-l"
																	src="images/icons/icon-heart-02.png" alt="ICON">
															</a>
														</div>
													</div>
												</div>
											</div>
										</c:forEach>
									</c:when>

									<c:otherwise>
										<div class="col-12 text-center p-t-50 p-b-50">
											<i class="zmdi zmdi-time-restore fs-60 cl3"></i>
											<p class="stext-107 cl6 p-t-20">No products available right now.</p>
										</div>
									</c:otherwise>
								</c:choose>
							</div>

							<!-- Load more -->
							<div class="flex-c-m flex-w w-full p-t-45">
								<a href="#" class="flex-c-m stext-101 cl5 size-103 bg2 bor1 hov-btn1 p-lr-15 trans-04">
									Load More
								</a>
							</div>
						</div>
					</div>

					<!-- Footer -->
					<footer class="bg3 p-t-75 p-b-32">
						<div class="container">
							<div class="row">
								<div class="col-sm-6 col-lg-3 p-b-50">
									<h4 class="stext-301 cl0 p-b-30">Categories</h4>
									<ul>
										<li class="p-b-10"><a href="shop?gender=MALE"
												class="stext-107 cl7 hov-cl1 trans-04">Men</a></li>
										<li class="p-b-10"><a href="shop?gender=FEMALE"
												class="stext-107 cl7 hov-cl1 trans-04">Women</a></li>
										<li class="p-b-10"><a href="shop?category=SPORT"
												class="stext-107 cl7 hov-cl1 trans-04">Sport</a></li>
										<li class="p-b-10"><a href="shop?category=LUXURY"
												class="stext-107 cl7 hov-cl1 trans-04">Luxury</a></li>
									</ul>
								</div>

								<div class="col-sm-6 col-lg-3 p-b-50">
									<h4 class="stext-301 cl0 p-b-30">Help</h4>
									<ul>
										<li class="p-b-10"><a href="#" class="stext-107 cl7 hov-cl1 trans-04">Track
												Order</a></li>
										<li class="p-b-10"><a href="#"
												class="stext-107 cl7 hov-cl1 trans-04">Returns</a></li>
										<li class="p-b-10"><a href="#"
												class="stext-107 cl7 hov-cl1 trans-04">Shipping</a></li>
										<li class="p-b-10"><a href="#" class="stext-107 cl7 hov-cl1 trans-04">FAQs</a>
										</li>
									</ul>
								</div>

								<div class="col-sm-6 col-lg-3 p-b-50">
									<h4 class="stext-301 cl0 p-b-30">GET IN TOUCH</h4>
									<p class="stext-107 cl7 size-201">
										Any questions? Let us know in store at 8th floor, 379 Hudson St, New York, NY
										10018
										or call us on (+1) 96 716 6879
									</p>
									<div class="p-t-27">
										<a href="#" class="fs-18 cl7 hov-cl1 trans-04 m-r-16"><i
												class="fa fa-facebook"></i></a>
										<a href="#" class="fs-18 cl7 hov-cl1 trans-04 m-r-16"><i
												class="fa fa-instagram"></i></a>
										<a href="#" class="fs-18 cl7 hov-cl1 trans-04 m-r-16"><i
												class="fa fa-pinterest-p"></i></a>
									</div>
								</div>

								<div class="col-sm-6 col-lg-3 p-b-50">
									<h4 class="stext-301 cl0 p-b-30">Newsletter</h4>
									<form>
										<div class="wrap-input1 w-full p-b-4">
											<input class="input1 bg-none plh1 stext-107 cl7" type="text" name="email"
												placeholder="email@example.com">
											<div class="focus-input1 trans-04"></div>
										</div>
										<div class="p-t-18">
											<button
												class="flex-c-m stext-101 cl0 size-103 bg1 bor1 hov-btn2 p-lr-15 trans-04">
												Subscribe
											</button>
										</div>
									</form>
								</div>
							</div>

							<div class="p-t-40">
								<div class="flex-c-m flex-w p-b-18">
									<a href="#" class="m-all-1"><img src="images/icons/icon-pay-01.png"
											alt="ICON-PAY"></a>
									<a href="#" class="m-all-1"><img src="images/icons/icon-pay-02.png"
											alt="ICON-PAY"></a>
									<a href="#" class="m-all-1"><img src="images/icons/icon-pay-03.png"
											alt="ICON-PAY"></a>
									<a href="#" class="m-all-1"><img src="images/icons/icon-pay-04.png"
											alt="ICON-PAY"></a>
									<a href="#" class="m-all-1"><img src="images/icons/icon-pay-05.png"
											alt="ICON-PAY"></a>
								</div>
								<p class="stext-107 cl6 txt-center">
									Copyright &copy;
									<script>document.write(new Date().getFullYear());</script>
									All rights reserved | Made with <i class="fa fa-heart-o" aria-hidden="true"></i> by
									<a href="https://colorlib.com" target="_blank">Colorlib</a>
								</p>
							</div>
						</div>
					</footer>

					<!-- Back to top -->
					<div class="btn-back-to-top" id="myBtn">
						<span class="symbol-btn-back-to-top">
							<i class="zmdi zmdi-chevron-up"></i>
						</span>
					</div>

					<!--===============================================================================================-->
					<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
					<script src="vendor/animsition/js/animsition.min.js"></script>
					<script src="vendor/bootstrap/js/popper.js"></script>
					<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
					<script src="vendor/select2/select2.min.js"></script>
					<script>
						$(".js-select2").each(function () {
							$(this).select2({
								minimumResultsForSearch: 20,
								dropdownParent: $(this).next('.dropDownSelect2')
							});
						});
					</script>
					<script src="vendor/daterangepicker/moment.min.js"></script>
					<script src="vendor/daterangepicker/daterangepicker.js"></script>
					<script src="vendor/slick/slick.min.js"></script>
					<script src="js/slick-custom.js"></script>
					<script src="vendor/parallax100/parallax100.js"></script>
					<script>$('.parallax100').parallax100();</script>
					<script src="vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
					<script>
						$('.gallery-lb').each(function () {
							$(this).magnificPopup({
								delegate: 'a',
								type: 'image',
								gallery: { enabled: true },
								mainClass: 'mfp-fade'
							});
						});
					</script>
					<script src="vendor/isotope/isotope.pkgd.min.js"></script>
					<script src="vendor/sweetalert/sweetalert.min.js"></script>
					<script>
						// Wishlist
						$('.js-addwish-b2, .js-addwish-detail').on('click', function (e) {
							e.preventDefault();
						});

						$('.js-addwish-b2').each(function () {
							var nameProduct = $(this).parent().parent().find('.js-name-b2').html();
							$(this).on('click', function () {
								swal(nameProduct, "is added to wishlist !", "success");
								$(this).addClass('js-addedwish-b2');
								$(this).off('click');
							});
						});
					</script>
					<script src="vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
					<script>
						$('.js-pscroll').each(function () {
							$(this).css('position', 'relative');
							$(this).css('overflow', 'hidden');
							var ps = new PerfectScrollbar(this, {
								wheelSpeed: 1,
								scrollingThreshold: 1000,
								wheelPropagation: false,
							});
							$(window).on('resize', function () {
								ps.update();
							});
						});
					</script>
					<script src="js/main.js"></script>

					<script>
						$(document).ready(function () {

							var $grid = $('.isotope-grid');
							$grid.isotope({
								itemSelector: '.isotope-item',
								layoutMode: 'fitRows'
							});

							$('.filter-tope-group button').on('click', function () {
								$('.filter-tope-group button').removeClass('how-active1');
								$(this).addClass('how-active1');

								var filterValue = $(this).attr('data-filter');
								$grid.isotope({ filter: filterValue });

								// clear search input when filter changes
								$('input[name="search-product"]').val('');
							});

							$('input[name="search-product"]').on('keyup', function () {
								var searchVal = $(this).val().toLowerCase().trim();

								$('.filter-tope-group button').removeClass('how-active1');
								$('.filter-tope-group button[data-filter="*"]').addClass('how-active1');

								$grid.isotope({
									filter: function () {
										if (searchVal === '') return true;
										var title = $(this).find('.js-name-b2').text().toLowerCase();
										var brand = $(this).find('.stext-102').text().toLowerCase();
										return title.indexOf(searchVal) > -1 || brand.indexOf(searchVal) > -1;
									}
								});
							});

						});

						function changeQty(btn, delta) {
							var numEl = btn.parentNode.querySelector('.block2-qty-num');
							var val = parseInt(numEl.textContent) + delta;
							if (val < 0) val = 0;
							numEl.textContent = val;
						}
					</script>

				</body>

				</html>
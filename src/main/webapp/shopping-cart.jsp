<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Shopping Cart</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/png" href="images/icons/favicon.png"/>
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/linearicons-v1.0.0/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<style>
		.table_row.removing {
			opacity: 0.4;
			pointer-events: none;
			transition: opacity 0.2s;
		}
		.cart-error-msg {
			margin-bottom: 20px;
		}
		.empty-cart-msg {
			text-align: center;
			padding: 60px 20px;
		}
		.empty-cart-msg i {
			font-size: 60px;
			color: #ccc;
			display: block;
			margin-bottom: 16px;
		}
		#btnCheckout:disabled {
			opacity: 0.5;
			cursor: not-allowed;
			pointer-events: none;
		}
		.credit-danger {
			color: #e74c3c !important;
		}
		.credit-warning {
			color: #e67e22 !important;
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
				<a href="index.html" class="logo">
					<img src="images/icons/logo-01.png" alt="IMG-LOGO">
				</a>
				<div class="menu-desktop">
					<ul class="main-menu">
						<li><a href="index.html">Home</a></li>
						<li><a href="shop">Shop</a></li>
						<li><a href="about.html">About</a></li>
						<li><a href="contact.html">Contact</a></li>
					</ul>
				</div>
				<div class="wrap-icon-header flex-w flex-r-m">
					<div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-modal-search">
						<i class="zmdi zmdi-search"></i>
					</div>
					<div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti js-show-cart"
						 data-notify="${cartCount}">
						<i class="zmdi zmdi-shopping-cart"></i>
					</div>
					<a href="#" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti"
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
			<a href="index.html"><img src="images/icons/logo-01.png" alt="IMG-LOGO"></a>
		</div>
		<div class="wrap-icon-header flex-w flex-r-m m-r-15">
			<div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 js-show-modal-search">
				<i class="zmdi zmdi-search"></i>
			</div>
			<div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti js-show-cart"
				 data-notify="${cartCount}">
				<i class="zmdi zmdi-shopping-cart"></i>
			</div>
			<a href="#" class="dis-block icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti"
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
			<li><a href="index.html">Home</a></li>
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

<!-- breadcrumb -->
<div class="container">
	<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
		<a href="index.html" class="stext-109 cl8 hov-cl1 trans-04">
			Home <i class="fa fa-angle-right m-l-9 m-r-10"></i>
		</a>
		<span class="stext-109 cl4">Shopping Cart</span>
	</div>
</div>

<!-- success message -->
<c:if test="${param.success == 'true'}">
	<div class="container m-t-20">
		<div class="alert alert-success">
			<i class="zmdi zmdi-check-circle m-r-8"></i>
			Purchase successful! Your cart has been cleared and your credit updated.
		</div>
	</div>
</c:if>

<!-- error message from checkout -->
<c:if test="${not empty error}">
	<div class="container m-t-20">
		<div class="alert alert-danger">
			<i class="zmdi zmdi-alert-circle m-r-8"></i>
				${error}
		</div>
	</div>
</c:if>

<!-- Shopping Cart -->
<form class="bg0 p-t-75 p-b-85" action="shopping-cart" method="post">
	<div class="container">
		<div class="row">

			<!-- Cart Table -->
			<div class="col-lg-10 col-xl-7 m-lr-auto m-b-50">
				<div class="m-l-25 m-r--38 m-lr-0-xl">

					<!-- inline AJAX errors appear here -->
					<div id="cart-error-container"></div>

					<div class="wrap-table-shopping-cart">
						<table class="table-shopping-cart" id="cartTable">
							<tr class="table_head">
								<th class="column-1">Product</th>
								<th class="column-2"></th>
								<th class="column-3">Price</th>
								<th class="column-4">Quantity</th>
								<th class="column-5">Total</th>
								<th class="column-6">Remove</th>
							</tr>

							<c:choose>
								<c:when test="${not empty cartItems}">
									<c:forEach var="item" items="${cartItems}">
										<tr class="table_row"
											data-product-id="${item.productId}"
											data-price="${item.price}">
											<td class="column-1">
												<div class="how-itemcart1">
													<img src="${empty item.productImageUrl
                                                                ? 'images/product-01.jpg'
                                                                : item.productImageUrl}"
														 alt="${item.productName}">
												</div>
											</td>
											<td class="column-2">${item.productName}</td>
											<td class="column-3">
												$<fmt:formatNumber value="${item.price}"
																   minFractionDigits="2"
																   maxFractionDigits="2"/>
											</td>
											<td class="column-4">
												<div class="wrap-num-product flex-w m-l-auto m-r-0">
													<button type="button" class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m"
															onclick="changeQty(this, -1, '${item.productId}')">
														<i class="fs-16 zmdi zmdi-minus"></i>
													</button>
													<input class="mtext-104 cl3 txt-center num-product"
														   type="number" value="${item.quantity}" min="0" readonly>
													<button type="button" class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m"
															onclick="changeQty(this, 1, '${item.productId}')">
														<i class="fs-16 zmdi zmdi-plus"></i>
													</button>
												</div>
											</td>
											<td class="column-5 item-total">
												$<fmt:formatNumber value="${item.totalPrice}"
																   minFractionDigits="2"
																   maxFractionDigits="2"/>
											</td>
											<td class="column-6 p-r-20">
												<button type="button"
														class="stext-106 cl6 hov1 bor3 trans-04 p-tb-5 p-lr-15 text-danger"
														onclick="removeItem(this, '${item.productId}')">
													Remove
												</button>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr id="emptyRow">
										<td colspan="6">
											<div class="empty-cart-msg">
												<i class="zmdi zmdi-shopping-cart"></i>
												Your cart is empty.
												<a href="shop">Continue shopping</a>
											</div>
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
				</div>
			</div>

			<!-- Cart Totals -->
			<div class="col-sm-10 col-lg-7 col-xl-5 m-lr-auto m-b-50">
				<div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
					<h4 class="mtext-109 cl2 p-b-30">Cart Totals</h4>

					<div class="flex-w flex-t bor12 p-b-13">
						<div class="size-208">
							<span class="stext-110 cl2">Subtotal:</span>
						</div>
						<div class="size-209">
                            <span class="mtext-110 cl2" id="cartSubtotal">
                                $<fmt:formatNumber value="${subtotal}"
												   minFractionDigits="2"
												   maxFractionDigits="2"/>
                            </span>
						</div>
					</div>

					<div class="flex-w flex-t bor12 p-t-15 p-b-30">
						<div class="size-208 w-full-ssm">
							<span class="stext-110 cl2">Available Credit:</span>
						</div>
						<div class="size-209 w-full-ssm">
                            <span class="mtext-110 cl2 text-success" id="availableCredit">
                                $<fmt:formatNumber value="${creditLimit}"
												   minFractionDigits="2"
												   maxFractionDigits="2"/>
                            </span>
						</div>
					</div>

					<div class="flex-w flex-t p-t-27 p-b-33">
						<div class="size-208">
							<span class="mtext-101 cl2">Total:</span>
						</div>
						<div class="size-209 p-t-1">
                            <span class="mtext-110 cl2" id="cartTotal">
                                $<fmt:formatNumber value="${subtotal}"
												   minFractionDigits="2"
												   maxFractionDigits="2"/>
                            </span>
						</div>
					</div>

					<button type="submit" id="btnCheckout"
					${empty cartItems ? 'disabled' : ''}
							class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer">
						Proceed to Checkout
					</button>
				</div>
			</div>

		</div>
	</div>
</form>

<!-- Footer -->
<footer class="bg3 p-t-75 p-b-32">
	<div class="container">
		<div class="row">
			<div class="col-sm-6 col-lg-3 p-b-50">
				<h4 class="stext-301 cl0 p-b-30">Categories</h4>
				<ul>
					<li class="p-b-10"><a href="shop?gender=MALE"     class="stext-107 cl7 hov-cl1 trans-04">Men</a></li>
					<li class="p-b-10"><a href="shop?gender=FEMALE"   class="stext-107 cl7 hov-cl1 trans-04">Women</a></li>
					<li class="p-b-10"><a href="shop?category=SPORT"  class="stext-107 cl7 hov-cl1 trans-04">Sport</a></li>
					<li class="p-b-10"><a href="shop?category=LUXURY" class="stext-107 cl7 hov-cl1 trans-04">Luxury</a></li>
				</ul>
			</div>
			<div class="col-sm-6 col-lg-3 p-b-50">
				<h4 class="stext-301 cl0 p-b-30">Help</h4>
				<ul>
					<li class="p-b-10"><a href="#" class="stext-107 cl7 hov-cl1 trans-04">Track Order</a></li>
					<li class="p-b-10"><a href="#" class="stext-107 cl7 hov-cl1 trans-04">Returns</a></li>
					<li class="p-b-10"><a href="#" class="stext-107 cl7 hov-cl1 trans-04">Shipping</a></li>
					<li class="p-b-10"><a href="#" class="stext-107 cl7 hov-cl1 trans-04">FAQs</a></li>
				</ul>
			</div>
			<div class="col-sm-6 col-lg-3 p-b-50">
				<h4 class="stext-301 cl0 p-b-30">Get in touch</h4>
				<p class="stext-107 cl7 size-201">
					Any questions? Let us know in store at 8th floor,
					379 Hudson St, New York, NY 10018 or call us on (+1) 96 716 6879
				</p>
				<div class="p-t-27">
					<a href="#" class="fs-18 cl7 hov-cl1 trans-04 m-r-16"><i class="fa fa-facebook"></i></a>
					<a href="#" class="fs-18 cl7 hov-cl1 trans-04 m-r-16"><i class="fa fa-instagram"></i></a>
					<a href="#" class="fs-18 cl7 hov-cl1 trans-04 m-r-16"><i class="fa fa-pinterest-p"></i></a>
				</div>
			</div>
			<div class="col-sm-6 col-lg-3 p-b-50">
				<h4 class="stext-301 cl0 p-b-30">Newsletter</h4>
				<form>
					<div class="wrap-input1 w-full p-b-4">
						<input class="input1 bg-none plh1 stext-107 cl7" type="text"
							   name="email" placeholder="email@example.com">
						<div class="focus-input1 trans-04"></div>
					</div>
					<div class="p-t-18">
						<button class="flex-c-m stext-101 cl0 size-103 bg1 bor1 hov-btn2 p-lr-15 trans-04">
							Subscribe
						</button>
					</div>
				</form>
			</div>
		</div>
		<div class="p-t-40">
			<div class="flex-c-m flex-w p-b-18">
				<a href="#" class="m-all-1"><img src="images/icons/icon-pay-01.png" alt="ICON-PAY"></a>
				<a href="#" class="m-all-1"><img src="images/icons/icon-pay-02.png" alt="ICON-PAY"></a>
				<a href="#" class="m-all-1"><img src="images/icons/icon-pay-03.png" alt="ICON-PAY"></a>
				<a href="#" class="m-all-1"><img src="images/icons/icon-pay-04.png" alt="ICON-PAY"></a>
				<a href="#" class="m-all-1"><img src="images/icons/icon-pay-05.png" alt="ICON-PAY"></a>
			</div>
			<p class="stext-107 cl6 txt-center">
				Copyright &copy;
				<script>document.write(new Date().getFullYear());</script>
				All rights reserved | Made with <i class="fa fa-heart-o"></i> by
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

<!-- Scripts -->
<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="vendor/animsition/js/animsition.min.js"></script>
<script src="vendor/bootstrap/js/popper.js"></script>
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="vendor/select2/select2.min.js"></script>
<script src="vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script src="js/main.js"></script>

<script>
	var creditLimit = ${creditLimit};

	function changeQty(btn, delta, productId) {
		if (btn.disabled) return;
		btn.disabled = true;

		var row     = $(btn).closest('.table_row');
		var input   = row.find('.num-product');
		var current = parseInt(input.val());
		var expectedQty = current + delta;

		if (expectedQty < 0) {
			btn.disabled = false;
			return;
		}

		var price = parseFloat(row.data('price'));

		$.ajax({
			url: 'cart',
			type: 'POST',
			dataType: 'json',
			data: { productId: productId, delta: delta },

			success: function(res) {
				if (res.status === 'success') {

					let actualQty = res.updatedQty;

					if (actualQty === 0) {
						row.fadeOut(300, function() {
							$(this).remove();
							recalculate();
							checkEmpty();
						});

					} else {
						input.val(actualQty);
						row.find('.item-total')
								.text('$' + (price * actualQty).toFixed(2));

						recalculate();
					}

					$('.icon-header-noti')
							.attr('data-notify', res.totalCartItems);

					if (actualQty < expectedQty) {
						showCartError('Quantity adjusted to available stock');
					}

				} else {
					showCartError(res.message);
				}
			},

			error: function() {
				showCartError('Could not connect to server. Please try again.');
			},

			complete: function() {
				btn.disabled = false;
			}
		});
	}
	function removeItem(btn, productId) {
		var row = $(btn).closest('.table_row');
		var qty = parseInt(row.find('.num-product').val());

		row.fadeOut(200);

		$.ajax({
			url: 'cart',
			type: 'POST',
			data: { productId: productId, delta: -qty },
			success: function(res) {
				if (res.status === 'success') {
					row.remove();
					recalculate();
					checkEmpty();
					$('.icon-header-noti').attr('data-notify', res.totalCartItems);
				} else {
					row.fadeIn(200);
					showCartError(res.message);
				}
			},
			error: function() {
				row.fadeIn(200);
				showCartError('Could not connect to server. Please try again.');
			}
		});
	}

	function revertRow(row, input, oldQty, price) {
		row.removeClass('removing');
		row.css('opacity', '1').css('pointer-events', 'auto');
		input.val(oldQty);
		row.find('.item-total').text('$' + (price * oldQty).toFixed(2));
		recalculate();
	}

	function recalculate() {
		var total = 0;
		$('.table_row').each(function() {
			var price = parseFloat($(this).data('price'));
			var qty   = parseInt($(this).find('.num-product').val());
			if (!isNaN(price) && !isNaN(qty)) {
				total += price * qty;
			}
		});

		$('#cartSubtotal, #cartTotal').text('$' + total.toFixed(2));

		var credit = parseFloat($('#availableCredit').text().replace('$', '').trim());
		if (total > creditLimit) {
			$('#cartTotal').addClass('credit-danger');
			$('#btnCheckout')
					.prop('disabled', true)
					.attr('title', 'Total exceeds your available credit');
		} else {
			$('#cartTotal').removeClass('credit-danger');
			$('#btnCheckout').prop('disabled', false).removeAttr('title');
		}
	}

	function checkEmpty() {
		if ($('.table_row').length === 0) {
			$('#cartTable').html(
					'<tr id="emptyRow"><td colspan="6">' +
					'<div class="empty-cart-msg">' +
					'<i class="zmdi zmdi-shopping-cart"></i>' +
					'Your cart is empty. <a href="shop">Continue shopping</a>' +
					'</div></td></tr>'
			);
			$('#btnCheckout').prop('disabled', true);
		}
	}

	function showCartError(message) {
		$('#cart-error-container').html(
				'<div class="alert alert-danger cart-error-msg">' +
				'<i class="zmdi zmdi-alert-circle m-r-8"></i>' +
				message + '</div>'
		);
		setTimeout(function() {
			$('#cart-error-container').find('.cart-error-msg')
					.fadeOut(400, function() { $(this).remove(); });
		}, 4000);
	}

	recalculate();
</script>

</body>
</html>
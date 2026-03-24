<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Shop - Sync Store</title>
	<jsp:include page="includes/head.jsp" />
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
		#toast-container {
			position: fixed;
			bottom: 24px;
			right: 24px;
			z-index: 9999;
			display: flex;
			flex-direction: column;
			gap: 10px;
			pointer-events: none;
		}

		.toast-item {
			display: flex;
			align-items: center;
			gap: 12px;
			background: #fff;
			border-radius: 10px;
			box-shadow: 0 4px 20px rgba(0,0,0,0.13);
			padding: 14px 18px;
			min-width: 240px;
			max-width: 320px;
			pointer-events: all;
			animation: toastIn 0.3s ease forwards;
			border-left: 4px solid #ccc;
		}

		.toast-item.success { border-left-color: #2ecc71; }
		.toast-item.remove  { border-left-color: #e74c3c; }
		.toast-item.error   { border-left-color: #e67e22; }

		.toast-icon {
			font-size: 20px;
			flex-shrink: 0;
		}

		.toast-item.success .toast-icon { color: #2ecc71; }
		.toast-item.remove  .toast-icon { color: #e74c3c; }
		.toast-item.error   .toast-icon { color: #e67e22; }

		.toast-body { flex: 1; }

		.toast-title {
			font-size: 13px;
			font-weight: 600;
			color: #333;
			margin-bottom: 2px;
		}

		.toast-msg {
			font-size: 12px;
			color: #888;
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
			max-width: 220px;
		}

		@keyframes toastIn {
			from { opacity: 0; transform: translateX(40px); }
			to   { opacity: 1; transform: translateX(0); }
		}

		@keyframes toastOut {
			from { opacity: 1; transform: translateX(0); }
			to   { opacity: 0; transform: translateX(40px); }
		}
	</style>
</head>

<body class="animsition">

<jsp:include page="includes/header.jsp">
	<jsp:param name="activeMenu" value="shop" />
</jsp:include>

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
						<a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">White Shirt Pleat</a>
						<span class="header-cart-item-info">1 x $19.00</span>
					</div>
				</li>
			</ul>
			<div class="w-full">
				<div class="header-cart-total w-full p-tb-40">Total: $19.00</div>
				<div class="header-cart-buttons flex-w w-full">
					<a href="shopping-cart"
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
				<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 how-active1" data-filter="*">
					All Products
				</button>
				<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".male">
					Men
				</button>
				<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".female">
					Women
				</button>
				<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".sport">
					Sport
				</button>
				<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".luxury">
					Luxury
				</button>
				<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".classic">
					Classic
				</button>
				<button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".casual">
					Casual
				</button>
			</div>

			<div class="flex-w flex-c-m m-tb-10">
				<div class="flex-c-m stext-106 cl6 size-104 bor4 pointer hov-btn3 trans-04 m-r-8 m-tb-4 js-show-filter">
					<i class="icon-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-filter-list"></i>
					<i class="icon-close-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
					Filter
				</div>
				<div class="flex-c-m stext-106 cl6 size-105 bor4 pointer hov-btn3 trans-04 m-tb-4 js-show-search">
					<i class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-search"></i>
					<i class="icon-close-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
					Search
				</div>
			</div>

			<!-- Search product -->
			<div class="dis-none panel-search w-full p-t-10 p-b-15">
				<div class="bor8 dis-flex p-l-15">
					<button class="size-113 flex-c-m fs-16 cl2 hov-cl1 trans-04">
						<i class="zmdi zmdi-search"></i>
					</button>
					<input class="mtext-107 cl2 size-114 plh2 p-r-15" type="text" name="search-product"
						   placeholder="Search">
				</div>
			</div>

			<!-- Filter panel -->
			<div class="dis-none panel-filter w-full p-t-10">
				<div class="wrap-filter flex-w bg6 w-full p-lr-40 p-t-27 p-lr-15-sm">
					<div class="filter-col1 p-r-15 p-b-27">
						<div class="mtext-102 cl2 p-b-15">Sort By</div>
						<ul>
							<li class="p-b-6"><a href="#" class="filter-link stext-106 trans-04">Default</a></li>
							<li class="p-b-6"><a href="#" class="filter-link stext-106 trans-04">Popularity</a></li>
							<li class="p-b-6"><a href="#" class="filter-link stext-106 trans-04 filter-link-active">Newness</a></li>
							<li class="p-b-6"><a href="#" class="filter-link stext-106 trans-04">Price: Low to High</a></li>
							<li class="p-b-6"><a href="#" class="filter-link stext-106 trans-04">Price: High to Low</a></li>
						</ul>
					</div>

					<div class="filter-col2 p-r-15 p-b-27">
						<div class="mtext-102 cl2 p-b-15">Price</div>
						<ul>
							<li class="p-b-6"><a href="#" class="filter-link stext-106 trans-04 filter-link-active">All</a></li>
							<li class="p-b-6"><a href="#" class="filter-link stext-106 trans-04">$0.00 - $500.00</a></li>
							<li class="p-b-6"><a href="#" class="filter-link stext-106 trans-04">$500.00 - $2000.00</a></li>
							<li class="p-b-6"><a href="#" class="filter-link stext-106 trans-04">$2000.00 - $5000.00</a></li>
							<li class="p-b-6"><a href="#" class="filter-link stext-106 trans-04">$5000.00+</a></li>
						</ul>
					</div>

					<div class="filter-col3 p-r-15 p-b-27">
						<div class="mtext-102 cl2 p-b-15">Tags</div>
						<div class="flex-w p-t-4 m-r--5">
							<a href="#" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">Sport</a>
							<a href="#" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">Luxury</a>
							<a href="#" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">Classic</a>
							<a href="#" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">Casual</a>
							<a href="#" class="flex-c-m stext-107 cl6 size-301 bor7 p-lr-15 hov-tag1 trans-04 m-r-5 m-b-5">Smart</a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row isotope-grid">
			<c:choose>
				<c:when test="${not empty products}">
					<c:forEach var="product" items="${products}">
						<div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item ${fn:toLowerCase(product.gender.name())} ${fn:toLowerCase(product.category.name())}">
							<div class="block2">
								<div class="block2-pic hov-img0">
									<img src="${empty product.imageUrl ? 'images/product-01.jpg' : product.imageUrl}"
										 alt="${product.name}">

									<div class="block2-qty flex-c-m trans-04">
										<button type="button" class="block2-qty-btn"
												onclick="changeQty(this, -1, '${product.productId}')">&minus;</button>
										<c:set var="qtyInCart" value="${cartQuantities[product.productId]}"/>
										<span class="block2-qty-num">${empty qtyInCart ? 0 : qtyInCart}</span>
										<button type="button" class="block2-qty-btn"
												onclick="changeQty(this, 1, '${product.productId}')">+</button>
									</div>
								</div>

								<div class="block2-txt flex-w flex-t p-t-14">
									<div class="block2-txt-child1 flex-col-l">
										<a href="product?id=${product.productId}"
										   class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
												${product.name}
										</a>

										<span class="stext-105 cl3">
                                            $<fmt:formatNumber value="${product.price}"
															   minFractionDigits="2"
															   maxFractionDigits="2"/>
                                        </span>

										<span class="stext-102 cl3 p-t-4">
												${product.brand}
										</span>

										<c:choose>
											<c:when test="${product.quantity == 0}">
												<span class="stock-out p-t-4">Out of stock</span>
											</c:when>
											<c:when test="${product.quantity <= 5}">
												<span class="stock-low p-t-4">Only ${product.quantity} left!</span>
											</c:when>
										</c:choose>
									</div>

									<div class="block2-txt-child2 flex-r p-t-3">
										<a href="#" class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
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
<jsp:include page="includes/footer.jsp" />

<jsp:include page="includes/scripts.jsp" />

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

	function changeQty(btn, delta, productId) {
		var numEl = btn.parentNode.querySelector('.block2-qty-num');
		var currentVal = parseInt(numEl.textContent);
		var val = currentVal + delta;
		if (val < 0) return;

		var buttons = btn.parentNode.parentNode.querySelectorAll('button');
		buttons.forEach(function(b) { b.disabled = true; });

		$.ajax({
			url: 'cart',
			type: 'POST',
			data: { productId: productId, delta: delta },
			success: function(response) {
				if (response.status === 'success') {
					numEl.textContent = val;
					$('.icon-header-noti').attr('data-notify', response.totalCartItems);

					var productName = $(btn).closest('.block2').find('.js-name-b2').text().trim();
					if (delta > 0) {
						showToast('Added to cart', productName, 'success');
					} else if (val === 0) {
						showToast('Removed from cart', productName, 'remove');
					} else {
						showToast('Cart updated', productName, 'success');
					}
				} else {
					showToast('Error', response.message, 'error');
				}
			},
			error: function() {
				showToast('Error', 'Could not connect to server', 'error');
			},
			complete: function() {
				buttons.forEach(function(b) { b.disabled = false; });
			}
		});
	}

	$('body').append('<div id="toast-container"></div>');

	function showToast(title, message, type) {
		var icons = {
			success: 'zmdi-check-circle',
			remove:  'zmdi-minus-circle',
			error:   'zmdi-alert-circle'
		};

		var toast = $(
				'<div class="toast-item ' + type + '">' +
				'<i class="toast-icon zmdi ' + icons[type] + '"></i>' +
				'<div class="toast-body">' +
				'<div class="toast-title">' + title + '</div>' +
				'<div class="toast-msg">' + message + '</div>' +
				'</div>' +
				'</div>'
		);

		$('#toast-container').append(toast);

		setTimeout(function() {
			toast.css('animation', 'toastOut 0.3s ease forwards');
			setTimeout(function() { toast.remove(); }, 300);
		}, 3000);
	}
</script>

</body>
</html>

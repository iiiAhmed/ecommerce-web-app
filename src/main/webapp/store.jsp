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

		/* Filter Sidebar */

		.filter-card {
			background: #fff;
			border-radius: 14px;
			padding: 24px 22px;
			box-shadow: 0 2px 16px rgba(0,0,0,0.06);
			border: 1px solid #f0f0f0;
		}

		.filter-title {
			font-size: 13px;
			font-weight: 700;
			text-transform: uppercase;
			letter-spacing: 0.8px;
			margin-bottom: 14px;
			color: #222;
			position: relative;
			padding-bottom: 8px;
		}

		.filter-title::after {
			content: '';
			position: absolute;
			bottom: 0;
			left: 0;
			width: 28px;
			height: 2px;
			background: #111;
			border-radius: 2px;
		}

		.filter-group {
			margin-bottom: 6px;
		}

		.filter-item {
			display: flex;
			align-items: center;
			gap: 10px;
			margin-bottom: 2px;
			cursor: pointer;
			font-size: 13.5px;
			color: #666;
			padding: 6px 8px;
			border-radius: 6px;
			transition: all 0.2s ease;
		}

		.filter-item:hover {
			background: #f8f8f8;
			color: #111;
		}

		.filter-item input[type="checkbox"],
		.filter-item input[type="radio"] {
			width: 16px;
			height: 16px;
			accent-color: #111;
			cursor: pointer;
			flex-shrink: 0;
		}

		.filter-divider {
			height: 1px;
			background: linear-gradient(to right, transparent, #e0e0e0, transparent);
			margin: 16px 0;
		}

		.filter-price input {
			margin-bottom: 10px;
			border: 1px solid #e0e0e0;
			border-radius: 8px;
			padding: 9px 12px;
			font-size: 13px;
			transition: border-color 0.2s ease;
		}

		.filter-price input:focus {
			border-color: #111;
			outline: none;
			box-shadow: 0 0 0 3px rgba(17,17,17,0.06);
		}

		.filter-btn {
			background: #111;
			color: #fff;
			border-radius: 8px;
			padding: 11px;
			width: 100%;
			border: none;
			font-size: 13px;
			font-weight: 600;
			letter-spacing: 0.5px;
			text-transform: uppercase;
			cursor: pointer;
			transition: all 0.25s ease;
		}

		.filter-btn:hover {
			background: #333;
			transform: translateY(-1px);
			box-shadow: 0 4px 12px rgba(0,0,0,0.15);
		}

		.filter-btn:active {
			transform: translateY(0);
		}


		.sort-bar-label span {
			color: #222;
			font-weight: 700;
		}

		.sort-bar-select {
			display: flex;
			align-items: center;
			gap: 8px;
			flex-wrap: wrap;
		}

		.sort-bar-select label {
			font-size: 13px;
			font-weight: 600;
			color: #444;
		}

		.sort-bar-select select {
			appearance: none;
			-webkit-appearance: none;

			background: #f7f7f7 url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23666' stroke-width='2'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E") no-repeat right 10px center;

			border: 1px solid #e0e0e0;
			border-radius: 6px;

			padding: 6px 30px 6px 10px;
			font-size: 13px;

			cursor: pointer;
			width: auto;
			max-width: 100%;
		}

		.sort-bar-select select:hover {
			border-color: #bbb;
		}

		.sort-bar-select select:focus {
			outline: none;
			border-color: #111;
			box-shadow: 0 0 0 3px rgba(17,17,17,0.06);
		}

		.block2-pic {
			width: 100%;
			height: 280px;
			overflow: hidden;
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
		<div class="row">

			<!-- FILTER SIDEBAR -->
			<div class="col-md-3 p-b-30">
				<div class="filter-card">

					<form method="get" action="shop">

						<!-- CATEGORY -->
						<div class="filter-group">
							<div class="filter-title">Category</div>

							<c:forEach var="cat" items="${categories}">
								<label class="filter-item">
									<input type="checkbox" name="category" value="${cat.name()}"
										${selectedCategories.contains(cat.name()) ? 'checked' : ''}>
										${cat.displayName}
								</label>
							</c:forEach>
						</div>

						<div class="filter-divider"></div>

						<!-- BRAND -->
						<div class="filter-group">
							<div class="filter-title">Brand</div>

							<c:forEach var="brand" items="${brands}">
								<label class="filter-item">
									<input type="checkbox" name="brand" value="${brand.name()}"
										${selectedBrands.contains(brand.name()) ? 'checked' : ''}>
										${brand.displayName}
								</label>
							</c:forEach>
						</div>

						<div class="filter-divider"></div>

						<!-- GENDER -->
						<div class="filter-group">
							<div class="filter-title">Gender</div>

							<c:forEach var="g" items="${genders}">
								<label class="filter-item">
									<input type="radio" name="gender" value="${g.name()}"
										${param.gender == g.name() ? 'checked' : ''}>
										${g.displayName}
								</label>
							</c:forEach>
						</div>

						<div class="filter-divider"></div>

						<!-- PRICE -->
						<div class="filter-group filter-price">
							<div class="filter-title">Price</div>

							<input type="number" name="minPrice" value="${param.minPrice}"
								   placeholder="Min price" class="form-control">

							<input type="number" name="maxPrice" value="${param.maxPrice}"
								   placeholder="Max price" class="form-control">
						</div>

						<button type="submit" class="filter-btn">Search</button>

					</form>
				</div>
			</div>
			<div class="col-md-9">

			<!-- SORT BAR -->

				<div class="sort-bar-select">
					<label>Sort by:</label>
					<form id="sortForm" method="get" action="shop" style="margin:0;">
						<c:forEach var="c" items="${paramValues.category}">
							<input type="hidden" name="category" value="${c}">
						</c:forEach>
						<c:forEach var="b" items="${paramValues.brand}">
							<input type="hidden" name="brand" value="${b}">
						</c:forEach>
						<c:if test="${param.gender != null}">
							<input type="hidden" name="gender" value="${param.gender}">
						</c:if>
						<c:if test="${param.minPrice != null}">
							<input type="hidden" name="minPrice" value="${param.minPrice}">
						</c:if>
						<c:if test="${param.maxPrice != null}">
							<input type="hidden" name="maxPrice" value="${param.maxPrice}">
						</c:if>

						<select name="sortBy" id="sortBySelect" onchange="document.getElementById('sortForm').submit();">
							<option value="newest" ${param.sortBy == 'newest' || empty param.sortBy ? 'selected' : ''}>Default (Newest)</option>
							<option value="price_asc" ${param.sortBy == 'price_asc' ? 'selected' : ''}>Price: Low to High</option>
							<option value="price_desc" ${param.sortBy == 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
							<option value="best_sellers" ${param.sortBy == 'best_sellers' ? 'selected' : ''}>Best Sellers</option>
						</select>
					</form>
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

		<!-- Pages -->
				<c:set var="queryParams" value="" />

				<c:forEach var="c" items="${paramValues.category}">
					<c:set var="queryParams" value="${queryParams}&category=${c}" />
				</c:forEach>

				<c:forEach var="b" items="${paramValues.brand}">
					<c:set var="queryParams" value="${queryParams}&brand=${b}" />
				</c:forEach>

				<c:if test="${param.gender != null}">
					<c:set var="queryParams" value="${queryParams}&gender=${param.gender}" />
				</c:if>

				<c:if test="${param.minPrice != null}">
					<c:set var="queryParams" value="${queryParams}&minPrice=${param.minPrice}" />
				</c:if>

				<c:if test="${param.maxPrice != null}">
					<c:set var="queryParams" value="${queryParams}&maxPrice=${param.maxPrice}" />
				</c:if>

				<c:if test="${param.sortBy != null}">
					<c:set var="queryParams" value="${queryParams}&sortBy=${param.sortBy}" />
				</c:if>
				<div class="flex-c-m flex-w w-full p-t-45">

					<!-- PREVIOUS -->
					<c:if test="${currentPage > 1}">
						<a href="shop?page=${currentPage - 1}${queryParams}"
						   class="btn btn-light m-1">
							← Prev
						</a>
					</c:if>

					<!-- PAGE NUMBERS -->
					<c:forEach begin="1" end="${totalPages}" var="i">
						<a href="shop?page=${i}${queryParams}"
						   class="btn ${i == currentPage ? 'btn-dark' : 'btn-light'} m-1">
								${i}
						</a>
					</c:forEach>

					<!-- NEXT -->
					<c:if test="${currentPage < totalPages}">
						<a href="shop?page=${currentPage + 1}${queryParams}"
						   class="btn btn-light m-1">
							Next →
						</a>
					</c:if>

				</div>
	</div>
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
			// swal(nameProduct, "is added to wishlist !", "success");
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

		var buttons = btn.parentNode.parentNode.querySelectorAll('button');
		buttons.forEach(function(b) { b.disabled = true; });

		$.ajax({
			url: 'cart',
			type: 'POST',
			data: { productId: productId, delta: delta },
			success: function(response) {
				if (response.status === 'success') {

					let expectedQty = currentVal + delta;
					let actualQty = response.updatedQty;

					numEl.textContent = actualQty;

					$('.icon-header-noti').attr('data-notify', response.totalCartItems);

					var productName = $(btn).closest('.block2').find('.js-name-b2').text().trim();

					if (actualQty === 0) {
						showToast('Removed from cart', productName, 'remove');

					} else if (actualQty < expectedQty) {
						showToast('Stock limit reached', 'Adjusted to available quantity', 'error');

					} else if (delta > 0) {
						showToast('Added to cart', productName, 'success');

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

	// $('input').on('change', function () {
	// 	$(this).closest('form').submit();
	// });
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

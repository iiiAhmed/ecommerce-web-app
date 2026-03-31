<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Shop - Sync Store</title>
	<jsp:include page="includes/head.jsp" />
</head>

<body class="animsition">

<jsp:include page="includes/header.jsp">
	<jsp:param name="activeMenu" value="shop" />
</jsp:include>

<jsp:include page="includes/cart-sidebar.jsp" />

<!-- Hero Breadcrumb -->
<section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('images/bg-01.jpg');">
	<h2 class="ltext-105 cl0 txt-center">Shop</h2>
</section>

<!-- Product -->
<div class="bg0 p-t-30 p-b-140">
	<div class="container">
		<div class="row">

			<!-- FILTER SIDEBAR -->
			<div class="col-md-3 p-b-30">

				<!-- Mobile Filter Toggle -->
				<button class="filter-toggle-btn" onclick="document.getElementById('filterSidebar').classList.toggle('show')">
					<i class="zmdi zmdi-filter-list"></i> Filters
				</button>

				<div id="filterSidebar" class="filter-card filter-sidebar-collapsible">

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

							<input type="number" name="minPrice" id="minPrice" value="${param.minPrice}"
								   placeholder="Min price" class="form-control" min="0" max="1000000" step="0.01">

							<input type="number" name="maxPrice" id="maxPrice" value="${param.maxPrice}"
								   placeholder="Max price" class="form-control" min="0" max="1000000" step="0.01">
						</div>

						<button type="submit" class="filter-btn">Search</button>

					</form>
				</div>
			</div>

			<!-- PRODUCT AREA -->
			<div class="col-md-9">

				<!-- Active Filter Chips -->
				<c:set var="hasFilters" value="${not empty paramValues.category || not empty paramValues.brand || not empty param.gender || not empty param.minPrice || not empty param.maxPrice}" />
				<c:if test="${hasFilters}">
					<div class="active-filters">
						<span class="active-filters-label">Filters:</span>

						<c:forEach var="c" items="${paramValues.category}">
							<span class="filter-chip">${c}</span>
						</c:forEach>

						<c:forEach var="b" items="${paramValues.brand}">
							<span class="filter-chip">${b}</span>
						</c:forEach>

						<c:if test="${not empty param.gender}">
							<span class="filter-chip">${param.gender}</span>
						</c:if>

						<c:if test="${not empty param.minPrice}">
							<span class="filter-chip">Min: $${param.minPrice}</span>
						</c:if>

						<c:if test="${not empty param.maxPrice}">
							<span class="filter-chip">Max: $${param.maxPrice}</span>
						</c:if>

						<a href="shop" class="clear-filters-link">Clear All</a>
					</div>
				</c:if>

				<!-- Store Toolbar -->
				<div class="store-toolbar">
					<div class="product-count">
						<c:choose>
							<c:when test="${not empty products}">
								Showing <strong>${(currentPage - 1) * pageSize + 1}–${(currentPage - 1) * pageSize + fn:length(products)}</strong>
								of <strong>${totalProducts}</strong> products
							</c:when>
							<c:otherwise>
								<strong>0</strong> products found
							</c:otherwise>
						</c:choose>
					</div>

					<div class="sort-bar-select">
						<label>Sort by:</label>
						<form id="sortForm" method="get" action="shop">
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
				</div>

				<!-- Product Grid -->
				<div class="row isotope-grid">
					<c:choose>
						<c:when test="${not empty products}">
							<c:forEach var="product" items="${products}">
								<div class="col-sm-6 col-md-6 col-lg-4 p-b-35 isotope-item ${fn:toLowerCase(product.gender.name())} ${fn:toLowerCase(product.category.name())}">
									<div class="block2">
										<div class="block2-pic hov-img0">
											<img src="${empty product.imageUrl ? 'images/product-01.jpg' : product.imageUrl}"
												 alt="${product.name}">

											<div class="block2-qty flex-c-m trans-04">
												<button type="button" class="block2-qty-btn"
														onclick="changeQty(this, -1, '${product.productId}')">&#8722;</button>
												<c:set var="qtyInCart" value="${cartQuantities[product.productId]}"/>
												<span class="block2-qty-num">${empty qtyInCart ? 0 : qtyInCart}</span>
												<button type="button" class="block2-qty-btn"
														onclick="changeQty(this, 1, '${product.productId}')">+</button>
											</div>
										</div>

										<div class="block2-txt flex-w flex-t p-t-14">
											<div class="block2-txt-child1 flex-col-l">
												<span class="product-brand">${product.brand}</span>

												<a href="product?id=${product.productId}"
												   class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
														${product.name}
												</a>

												<span class="product-price">
                                                    $<fmt:formatNumber value="${product.price}"
															   minFractionDigits="2"
															   maxFractionDigits="2"/>
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
							<div class="col-12">
								<div class="store-empty">
									<i class="zmdi zmdi-shopping-cart"></i>
									<p>No products match your filters.</p>
									<a href="shop">Browse All Products</a>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>

				<!-- Pagination -->
				<c:if test="${totalPages > 1}">
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

					<div class="store-pagination">
						<!-- Previous -->
						<c:if test="${currentPage > 1}">
							<a href="shop?page=${currentPage - 1}${queryParams}" class="page-prev">← Prev</a>
						</c:if>

						<!-- Page Numbers -->
						<c:forEach begin="1" end="${totalPages}" var="i">
							<c:choose>
								<c:when test="${i == currentPage}">
									<span class="page-current">${i}</span>
								</c:when>
								<c:otherwise>
									<a href="shop?page=${i}${queryParams}">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<!-- Next -->
						<c:if test="${currentPage < totalPages}">
							<a href="shop?page=${currentPage + 1}${queryParams}" class="page-next">Next →</a>
						</c:if>
					</div>
				</c:if>

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
					var brand = $(this).find('.product-brand').text().toLowerCase();
					return title.indexOf(searchVal) > -1 || brand.indexOf(searchVal) > -1;
				}
			});
		});

	});

	function changeQty(btn, delta, productId) {
		var numEl = btn.parentNode.querySelector('.block2-qty-num');
		var currentVal = parseInt(numEl.textContent);
		var expectedQty = currentVal + delta;

		if (expectedQty < 0) {
			return;
		}

		if (expectedQty > 5) {
			showToast('Error', 'You can\'t buy more that 5 items', 'error');
			return;
		}

		if (!productId || isNaN(productId) || productId < 0) {
			showToast('Error', 'Invalid product', 'error');
			return;
		}

		if (isNaN(delta) || Math.abs(delta) > 5) {
			showToast('Error', 'Invalid quantity change', 'error');
			return;
		}

		var buttons = btn.parentNode.parentNode.querySelectorAll('button');
		buttons.forEach(function(b) { b.disabled = true; });

		$.ajax({
			url: 'cart',
			type: 'POST',
			data: { productId: productId, delta: delta },
			success: function(response) {
				if (response.status === 'success') {

					let actualQty = response.updatedQty;

					numEl.textContent = actualQty;

					$('.icon-header-noti').attr('data-notify', response.totalCartItems);

					var productName = $(btn).closest('.block2').find('.js-name-b2').text().trim();

					if (actualQty === 0 && delta < 0) {
						showToast('Removed from cart', productName, 'remove');

					} else if (actualQty === 0 && delta > 0) {
						showToast('Out of stock', productName, 'error');
					} else if (actualQty < expectedQty) {
						showToast('Stock limit reached', 'Adjusted to available quantity', 'error');

					} else if (delta > 0) {
						showToast('Added to cart', productName, 'success');

					} else {
						showToast('Cart updated', productName, 'success');
					}
				} else {
					showToast('Error', response.message || 'Failed to update cart', 'error');
				}
			},
			error: function(xhr, status, error) {
				if (xhr.responseJSON && xhr.responseJSON.message) {
					showToast('Error', xhr.responseJSON.message, 'error');
				} else {
					showToast('Error', 'Could not connect to server', 'error');
				}
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

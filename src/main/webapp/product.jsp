<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="jakarta.tags.core" %>
		<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
			<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
			<!DOCTYPE html>
			<html lang="en">

			<head>
				<title>${product.name} - Product Detail</title>
				<jsp:include page="includes/head.jsp" />

				<style>
					/* ── Product Gallery ── */
					.pd-gallery {
						position: relative;
						width: 100%;
						user-select: none;
					}

					.pd-gallery__main {
						position: relative;
						width: 100%;
						aspect-ratio: 1 / 1;
						overflow: hidden;
						border-radius: 12px;
						background: #f5f5f5;
					}

					.pd-gallery__main img {
						position: absolute;
						inset: 0;
						width: 100%;
						height: 100%;
						object-fit: cover;
						opacity: 0;
						transition: opacity .4s ease, transform .4s ease;
						will-change: opacity, transform;
						transform: scale(1.03);
					}

					.pd-gallery__main img.active {
						opacity: 1;
						transform: scale(1);
						z-index: 1;
					}

					/* Arrows */
					.pd-gallery__arrow {
						position: absolute;
						top: 50%;
						transform: translateY(-50%);
						z-index: 5;
						width: 44px;
						height: 44px;
						border: none;
						border-radius: 50%;
						background: rgba(255,255,255,.85);
						backdrop-filter: blur(6px);
						box-shadow: 0 2px 12px rgba(0,0,0,.12);
						cursor: pointer;
						display: flex;
						align-items: center;
						justify-content: center;
						font-size: 18px;
						color: #222;
						opacity: 0;
						transition: opacity .3s, background .2s, transform .2s;
					}

					.pd-gallery:hover .pd-gallery__arrow {
						opacity: 1;
					}

					.pd-gallery__arrow:hover {
						background: #fff;
						transform: translateY(-50%) scale(1.08);
					}

					.pd-gallery__arrow--prev { left: 14px; }
					.pd-gallery__arrow--next { right: 14px; }

					/* Counter badge */
					.pd-gallery__counter {
						position: absolute;
						bottom: 14px;
						right: 14px;
						z-index: 5;
						background: rgba(0,0,0,.55);
						backdrop-filter: blur(4px);
						color: #fff;
						font-size: 13px;
						font-weight: 500;
						padding: 4px 12px;
						border-radius: 20px;
						letter-spacing: .3px;
						pointer-events: none;
					}

					/* Thumbnail strip */
					.pd-gallery__thumbs {
						display: flex;
						gap: 10px;
						margin-top: 14px;
						overflow-x: auto;
						padding-bottom: 4px;
						scrollbar-width: thin;
					}

					.pd-gallery__thumb {
						flex: 0 0 68px;
						height: 68px;
						border-radius: 8px;
						overflow: hidden;
						cursor: pointer;
						border: 2px solid transparent;
						opacity: .55;
						transition: opacity .25s, border-color .25s, transform .2s;
					}

					.pd-gallery__thumb:hover {
						opacity: .85;
						transform: translateY(-2px);
					}

					.pd-gallery__thumb.active {
						opacity: 1;
						border-color: #222;
					}

					.pd-gallery__thumb img {
						width: 100%;
						height: 100%;
						object-fit: cover;
					}

					/* Hide gallery controls when single image */
					.pd-gallery--single .pd-gallery__arrow,
					.pd-gallery--single .pd-gallery__counter,
					.pd-gallery--single .pd-gallery__thumbs {
						display: none;
					}

					@media (max-width: 767px) {
						.pd-gallery__arrow { opacity: 1; width: 38px; height: 38px; font-size: 15px; }
						.pd-gallery__thumb { flex: 0 0 56px; height: 56px; }
					}
				</style>

			</head>

			<body class="animsition">

				<!-- Header -->
				<jsp:include page="includes/header.jsp" />


				<!-- breadcrumb -->
				<div class="container">
					<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
						<a href="index.jsp" class="stext-109 cl8 hov-cl1 trans-04">
							Home
							<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
						</a>

						<a href="shop" class="stext-109 cl8 hov-cl1 trans-04">
							Shop
							<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
						</a>

						<span class="stext-109 cl4">
							${product.name}
						</span>
					</div>
				</div>


				<!-- Product Detail -->
				<section class="sec-product-detail bg0 p-t-65 p-b-60">
					<div class="container">
						<div class="row">
							<div class="col-md-6 col-lg-7 p-b-30">
								<div class="p-l-25 p-r-30 p-lr-0-lg">

									<%-- Build image list: use product.images if available, fall back to imageUrl or placeholder --%>
									<c:set var="imageList" value="${product.images}" />
									<c:if test="${empty imageList}">
										<c:set var="imageList" value="${empty product.imageUrl ? 'images/product-detail-01.jpg' : product.imageUrl}" />
									</c:if>

									<div class="pd-gallery${fn:length(imageList) <= 1 ? ' pd-gallery--single' : ''}" id="pdGallery">

										<!-- Main image viewport -->
										<div class="pd-gallery__main">
											<c:forEach var="img" items="${imageList}" varStatus="st">
												<img src="${img}" alt="${product.name} - Image ${st.index + 1}"
													 class="${st.index == 0 ? 'active' : ''}"
													 data-index="${st.index}">
											</c:forEach>
										</div>

										<!-- Arrows -->
										<button type="button" class="pd-gallery__arrow pd-gallery__arrow--prev"
												onclick="pdGalleryNav(-1)" aria-label="Previous image">
											<i class="fa fa-angle-left"></i>
										</button>
										<button type="button" class="pd-gallery__arrow pd-gallery__arrow--next"
												onclick="pdGalleryNav(1)" aria-label="Next image">
											<i class="fa fa-angle-right"></i>
										</button>

										<!-- Counter -->
										<span class="pd-gallery__counter">
											<span id="pdCurrentIdx">1</span> / ${fn:length(imageList)}
										</span>

										<!-- Thumbnails -->
										<c:if test="${fn:length(imageList) > 1}">
											<div class="pd-gallery__thumbs">
												<c:forEach var="img" items="${imageList}" varStatus="st">
													<div class="pd-gallery__thumb ${st.index == 0 ? 'active' : ''}"
														 onclick="pdGalleryGo(${st.index})">
														<img src="${img}" alt="Thumbnail ${st.index + 1}">
													</div>
												</c:forEach>
											</div>
										</c:if>
									</div>

								</div>
							</div>

							<div class="col-md-6 col-lg-5 p-b-30">
								<div class="p-r-50 p-t-5 p-lr-0-lg">
									<h4 class="mtext-105 cl2 p-b-14">
										${product.name}
									</h4>

									<span class="mtext-106 cl2">
										$
										<fmt:formatNumber value="${product.price}" pattern="#,##0.00" />
									</span>


									<div class="p-t-23">
										<p class="stext-102 cl3"><strong>Brand:</strong> ${product.brand}</p>
										<p class="stext-102 cl3"><strong>Category:</strong> ${product.category}</p>
										<p class="stext-102 cl3"><strong>Gender:</strong> ${product.gender}</p>
										<p class="stext-102 cl3"><strong>Age:</strong> ${product.age}</p>
										<c:choose>
											<c:when test="${product.quantity > 0}">
												<p class="stext-102 cl3 stock-in">In stock</p>
											</c:when>
											<c:otherwise>
												<p class="stext-102 cl3 stock-out-text">Out of stock</p>
											</c:otherwise>
										</c:choose>
									</div>

									<div class="p-t-33">
										<c:if test="${product.quantity > 0}">
											<div class="flex-w flex-r-m p-b-10">
												<div class="size-204 flex-w flex-m respon6-next">
													<div class="wrap-num-product flex-w m-r-20 m-tb-10">
														<div class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m"
															onclick="changeQty(this, -1, '${product.productId}')">
															<i class="fs-16 zmdi zmdi-minus"></i>
														</div>

														<c:set var="qtyInCart"
															value="${cartQuantities[product.productId]}" />
														<input class="mtext-104 cl3 txt-center num-product"
															type="number" name="num-product"
															value="${empty qtyInCart ? 0 : qtyInCart}" readonly>

														<div class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m"
															onclick="changeQty(this, 1, '${product.productId}')">
															<i class="fs-16 zmdi zmdi-plus"></i>
														</div>
													</div>
												</div>
											</div>
										</c:if>
									</div>
								</div>
							</div>
						</div>
						<div class="product-description-section p-t-50">

							<h4 class="mtext-105 cl2 p-b-16">
								Product Description
							</h4>

							<div class="stext-102 cl3">
								<c:choose>
									<c:when test="${not empty product.description}">
										${product.description}
									</c:when>
									<c:otherwise>
										Premium quality ${product.brand} watch for ${product.gender}.
										Part of our ${product.category} collection.
									</c:otherwise>
								</c:choose>
							</div>

						</div>

					</div>
				</section>

				<!-- Cart Sidebar -->
				<jsp:include page="includes/cart-sidebar.jsp" />

				<!-- Footer -->
				<jsp:include page="includes/footer.jsp" />

				<!-- Scripts -->
				<jsp:include page="includes/scripts.jsp" />

				<script>
					/* ── Product Gallery Navigation ── */
					(function () {
						var gallery = document.getElementById('pdGallery');
						if (!gallery) return;

						var imgs = gallery.querySelectorAll('.pd-gallery__main img');
						var thumbs = gallery.querySelectorAll('.pd-gallery__thumb');
						var counter = document.getElementById('pdCurrentIdx');
						var total = imgs.length;
						var current = 0;

						if (total <= 1) return;

						window.pdGalleryGo = function (idx) {
							if (idx < 0) idx = total - 1;
							if (idx >= total) idx = 0;
							if (idx === current) return;

							imgs[current].classList.remove('active');
							if (thumbs.length) thumbs[current].classList.remove('active');

							current = idx;

							imgs[current].classList.add('active');
							if (thumbs.length) {
								thumbs[current].classList.add('active');
								thumbs[current].scrollIntoView({ behavior: 'smooth', inline: 'center', block: 'nearest' });
							}

							if (counter) counter.textContent = current + 1;
						};

						window.pdGalleryNav = function (dir) {
							window.pdGalleryGo(current + dir);
						};

						/* Keyboard: left / right arrows */
						document.addEventListener('keydown', function (e) {
							if (e.key === 'ArrowLeft') pdGalleryNav(-1);
							else if (e.key === 'ArrowRight') pdGalleryNav(1);
						});

						/* Swipe support for mobile */
						var startX = 0;
						var mainEl = gallery.querySelector('.pd-gallery__main');
						mainEl.addEventListener('touchstart', function (e) { startX = e.touches[0].clientX; }, { passive: true });
						mainEl.addEventListener('touchend', function (e) {
							var diff = e.changedTouches[0].clientX - startX;
							if (Math.abs(diff) > 40) pdGalleryNav(diff < 0 ? 1 : -1);
						}, { passive: true });
					})();
				</script>

				<script>
					$('body').append('<div id="toast-container"></div>');

					function changeQty(btn, delta, productId) {
						var numEl = btn.parentNode.querySelector('.num-product');
						var currentVal = parseInt(numEl.value);
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
						var buttons = btn.parentNode.querySelectorAll('div[class^="btn-num-product"]');
						buttons.forEach(function (b) { b.style.pointerEvents = 'none'; });

						$.ajax({
							url: 'cart',
							type: 'POST',
							data: { productId: productId, delta: delta },
							success: function (response) {
								if (response.status === 'success') {

									let actualQty = response.updatedQty;

									numEl.value = actualQty;

									$('.icon-header-noti').attr('data-notify', response.totalCartItems);

									var productName = document.querySelector('h4.mtext-105').textContent.trim();

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
							error: function () {
								showToast('Error', 'Could not connect to server', 'error');
							},
							complete: function () {
								buttons.forEach(function (b) { b.style.pointerEvents = 'auto'; });
							}
						});
					}

					function showToast(title, message, type) {
						var icons = {
							success: 'zmdi-check-circle',
							remove: 'zmdi-minus-circle',
							error: 'zmdi-alert-circle'
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

						setTimeout(function () {
							toast.css('animation', 'toastOut 0.3s ease forwards');
							setTimeout(function () { toast.remove(); }, 300);
						}, 3000);
					}
				</script>

			</body>

			</html>
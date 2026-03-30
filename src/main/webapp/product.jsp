<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="jakarta.tags.core" %>
		<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
			<!DOCTYPE html>
			<html lang="en">

			<head>
				<title>${product.name} - Product Detail</title>
				<jsp:include page="includes/head.jsp" />


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
									<div class="wrap-pic-w pos-relative">
										<c:choose>
											<c:when test="${not empty product.imageUrl}">
												<img src="${product.imageUrl}" alt="${product.name}"
													class="product-image">
											</c:when>
											<c:otherwise>
												<img src="images/product-detail-01.jpg" alt="${product.name}"
													class="product-detail-img">
											</c:otherwise>
										</c:choose>
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
					$('body').append('<div id="toast-container"></div>');

					function changeQty(btn, delta, productId) {
						var numEl = btn.parentNode.querySelector('.num-product');
						var currentVal = parseInt(numEl.value);

						var buttons = btn.parentNode.querySelectorAll('div[class^="btn-num-product"]');
						buttons.forEach(function (b) { b.style.pointerEvents = 'none'; });

						$.ajax({
							url: 'cart',
							type: 'POST',
							data: { productId: productId, delta: delta },
							success: function (response) {
								if (response.status === 'success') {

									let expectedQty = currentVal + delta;
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
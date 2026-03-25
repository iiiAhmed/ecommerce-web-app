<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>${product.name} - Product Detail</title>
	<jsp:include page="includes/head.jsp" />
	<style>
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
									<img src="${product.imageUrl}" alt="${product.name}" style="width: 100%; height: auto;">
								</c:when>
								<c:otherwise>
									<img src="images/product-detail-01.jpg" alt="${product.name}" style="width: 100%; height: auto;">
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
							$<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/>
						</span>

						<p class="stext-102 cl3 p-t-23">
							<c:choose>
								<c:when test="${not empty product.description}">
									${product.description}
								</c:when>
								<c:otherwise>
									Premium quality ${product.brand} watch for ${product.gender}. Part of our ${product.category} collection.
								</c:otherwise>
							</c:choose>
						</p>

						<div class="p-t-23">
							<p class="stext-102 cl3"><strong>Brand:</strong> ${product.brand}</p>
							<p class="stext-102 cl3"><strong>Category:</strong> ${product.category}</p>
							<p class="stext-102 cl3"><strong>Gender:</strong> ${product.gender}</p>
							<p class="stext-102 cl3"><strong>Age:</strong> ${product.age}</p>
							<c:choose>
								<c:when test="${product.quantity > 0}">
									<p class="stext-102 cl3"><strong>Stock:</strong> <span style="color: #28a745;">${product.quantity} available</span></p>
								</c:when>
								<c:otherwise>
									<p class="stext-102 cl3"><strong>Stock:</strong> <span style="color: #dc3545;">Out of stock</span></p>
								</c:otherwise>
							</c:choose>
						</div>

						<div class="p-t-33">
							<c:if test="${product.quantity > 0}">
								<div class="flex-w flex-r-m p-b-10">
									<div class="size-204 flex-w flex-m respon6-next">
										<div class="wrap-num-product flex-w m-r-20 m-tb-10">
											<div class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m">
												<i class="fs-16 zmdi zmdi-minus"></i>
											</div>

											<input class="mtext-104 cl3 txt-center num-product" type="number"
												name="num-product" value="1" min="1" max="${product.quantity}">

											<div class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m">
												<i class="fs-16 zmdi zmdi-plus"></i>
											</div>
										</div>

										<button
											class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04"
											data-product-id="${product.productId}"
											data-product-name="${product.name}"
											onclick="addToCart(${product.productId}, '${product.name}', ${product.price}, ${product.quantity})">
											Add to cart
										</button>
									</div>
								</div>
							</c:if>
						</div>
					</div>
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

		function addToCart(productId, productName, price, maxQuantity) {
			var quantity = parseInt($('.num-product').val());

			if (quantity <= 0 || quantity > maxQuantity) {
				showToast('Invalid quantity', 'Please select a valid quantity', 'error');
				return;
			}

			var $btn = $(event.target);
			$btn.prop('disabled', true);

			$.ajax({
				url: 'cart',
				type: 'POST',
				data: { productId: productId, delta: quantity },
				success: function(response) {
					if (response.status === 'success') {
						$('.icon-header-noti').attr('data-notify', response.totalCartItems);

						if (response.updatedQty < quantity) {
							showToast('Stock limit reached', 'Adjusted to available quantity', 'error');
						} else {
							showToast('Added to cart', productName, 'success');
						}
					} else {
						showToast('Error', response.message || 'Could not add to cart', 'error');
					}
				},
				error: function() {
					showToast('Error', 'Could not connect to server', 'error');
				},
				complete: function() {
					$btn.prop('disabled', false);
				}
			});
		}

		$('.btn-num-product-down').on('click', function() {
			var input = $('.num-product');
			var currentValue = parseInt(input.val());
			if (currentValue > 1) {
				input.val(currentValue - 1);
			}
		});

		$('.btn-num-product-up').on('click', function() {
			var input = $('.num-product');
			var currentValue = parseInt(input.val());
			var maxValue = parseInt(input.attr('max'));
			if (currentValue < maxValue) {
				input.val(currentValue + 1);
			}
		});

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
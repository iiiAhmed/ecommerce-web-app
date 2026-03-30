<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Shopping Cart - Sync Store</title>
	<jsp:include page="includes/head.jsp" />
</head>
<body class="animsition">

<jsp:include page="includes/header.jsp">
	<jsp:param name="activeMenu" value="" />
</jsp:include>

<!-- Hero Breadcrumb -->
<section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('images/bg-01.jpg');">
	<h2 class="ltext-105 cl0 txt-center">Shopping Cart</h2>
</section>

<!-- Flash Messages -->
<c:if test="${param.success == 'true'}">
	<div class="container m-t-20">
		<div class="profile-alert success">
			<i class="fa fa-check-circle"></i>
			<span>Purchase successful! Your cart has been cleared and your credit updated.</span>
		</div>
	</div>
</c:if>
<c:if test="${not empty error}">
	<div class="container m-t-20">
		<div class="profile-alert error">
			<i class="fa fa-exclamation-circle"></i>
			<span>${error}</span>
		</div>
	</div>
</c:if>

<!-- Shopping Cart -->
<form class="bg0 p-t-40 p-b-85" action="shopping-cart" method="post">
	<div class="container">
		<div class="row">

			<!-- Cart Table -->
			<div class="col-lg-8 m-b-40">
				<div class="cart-card">
					<div class="cart-card-header">
						<h4><i class="fa fa-shopping-cart"></i> Your Items</h4>
						<c:if test="${not empty cartItems}">
							<span class="cart-item-count">${cartItems.size()} item${cartItems.size() > 1 ? 's' : ''}</span>
						</c:if>
					</div>

					<!-- inline AJAX errors -->
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
												<a href="product?id=${item.productId}" target="_blank">
													<div class="how-itemcart1">
														<img src="${empty item.productImageUrl
                                                                ? 'images/product-01.jpg'
                                                                : item.productImageUrl}"
															 alt="${item.productName}">
													</div>
												</a>
											</td>
											<td class="column-2">
												<a href="product?id=${item.productId}" target="_blank" class="cart-product-name">
													${item.productName}
												</a>
											</td>
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
											<td class="column-6">
												<button type="button"
														class="cart-remove-btn"
														onclick="removeItem(this, '${item.productId}')">
													<i class="fa fa-trash-o"></i>
												</button>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr id="emptyRow">
										<td colspan="6">
											<div class="profile-empty">
												<i class="fa fa-shopping-cart"></i>
												<p>Your cart is empty.</p>
												<a href="shop">Continue Shopping</a>
											</div>
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</table>
					</div>

					<c:if test="${not empty cartItems}">
						<div class="cart-continue-link">
							<a href="shop"><i class="zmdi zmdi-long-arrow-left"></i> Continue Shopping</a>
						</div>
					</c:if>
				</div>
			</div>

			<!-- Cart Summary -->
			<div class="col-lg-4 m-b-40">
				<div class="cart-summary-card">
					<h4 class="cart-summary-title">Order Summary</h4>

					<div class="cart-summary-row">
						<span>Subtotal</span>
						<span id="cartSubtotal">
							$<fmt:formatNumber value="${subtotal}"
											   minFractionDigits="2"
											   maxFractionDigits="2"/>
						</span>
					</div>

					<div class="cart-summary-row">
						<span>Shipping</span>
						<span class="order-free-shipping">Free</span>
					</div>

					<div class="cart-summary-divider"></div>

					<div class="cart-summary-row cart-summary-credit">
						<span><i class="fa fa-credit-card"></i> Available Credit</span>
						<span id="availableCredit" class="cart-credit-value">
							$<fmt:formatNumber value="${creditLimit}"
											   minFractionDigits="2"
											   maxFractionDigits="2"/>
						</span>
					</div>

					<div class="cart-summary-divider"></div>

					<div class="cart-summary-row cart-summary-total">
						<span>Total</span>
						<span id="cartTotal">
							$<fmt:formatNumber value="${subtotal}"
											   minFractionDigits="2"
											   maxFractionDigits="2"/>
						</span>
					</div>

					<button type="submit" id="btnCheckout"
						${empty cartItems ? 'disabled' : ''}
							class="cart-checkout-btn">
						<i class="fa fa-lock"></i> Proceed to Checkout
					</button>

					<div class="cart-secure-note">
						<i class="fa fa-shield"></i> Secure checkout — your credit will be charged upon confirmation.
					</div>
				</div>
			</div>

		</div>
	</div>
</form>

<jsp:include page="includes/footer.jsp" />

<jsp:include page="includes/scripts.jsp" />

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
		if (expectedQty > 5) {
			showCartError('Quantity cannot exceed 5 items');
			btn.disabled = false;
			return;
		}

		if (!productId || isNaN(productId) || productId < 0) {
			showCartError('Invalid product identifier');
			btn.disabled = false;
			return;
		}

		if (isNaN(delta) || Math.abs(delta) > 1000) {
			showCartError('Invalid quantity change');
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

			error: function(xhr, status, error) {
				if (xhr.responseJSON && xhr.responseJSON.message) {
					showCartError(xhr.responseJSON.message);
				} else {
					showCartError('Could not connect to server. Please try again.');
				}
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

		if (total > creditLimit) {
			$('#cartTotal').addClass('credit-danger');
			$('#btnCheckout')
					.prop('disabled', true)
					.attr('title', 'Total exceeds your available credit');
		} else {
			$('#cartTotal').removeClass('credit-danger');
			if ($('.table_row').length > 0) {
				$('#btnCheckout').prop('disabled', false).removeAttr('title');
			}
		}
	}

	function checkEmpty() {
		if ($('.table_row').length === 0) {
			$('#cartTable').html(
					'<tr id="emptyRow"><td colspan="6">' +
					'<div class="profile-empty">' +
					'<i class="fa fa-shopping-cart"></i>' +
					'<p>Your cart is empty.</p>' +
					'<a href="shop">Continue Shopping</a>' +
					'</div></td></tr>'
			);
			$('#btnCheckout').prop('disabled', true);
		}
	}

	function showCartError(message) {
		$('#cart-error-container').html(
				'<div class="profile-alert error cart-error-msg">' +
				'<i class="fa fa-exclamation-circle"></i> ' +
				'<span>' + message + '</span></div>'
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
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Shopping Cart - Sync Store</title>
	<jsp:include page="includes/head.jsp" />
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

<jsp:include page="includes/header.jsp">
	<jsp:param name="activeMenu" value="" />
</jsp:include>

<!-- breadcrumb -->
<div class="container">
	<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
		<a href="index.jsp" class="stext-109 cl8 hov-cl1 trans-04">
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
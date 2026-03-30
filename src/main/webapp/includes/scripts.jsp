<!--===============================================================================================-->
<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
<script src="vendor/bootstrap/js/popper.js"></script>
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
<script src="vendor/select2/select2.min.js"></script>
<script>
	$(".js-select2").each(function () {
		$(this).select2({
			minimumResultsForSearch: 20,
			dropdownParent: $(this).next('.dropDownSelect2')
		});
	})
</script>
<!--===============================================================================================-->
<script src="vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
<!--===============================================================================================-->
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
		})
	});
</script>
<!--===============================================================================================-->
<script src="js/main.js"></script>
<!--===============================================================================================-->
<script>
	// Dark Mode Toggle Functionality
	(function() {
		const themeToggle = document.getElementById('themeToggle');
		const themeToggleMobile = document.getElementById('themeToggleMobile');
		const htmlElement = document.documentElement;

		// Load saved theme from localStorage or default to light
		const savedTheme = localStorage.getItem('theme') || 'light';
		htmlElement.setAttribute('data-theme', savedTheme);
		updateThemeIcon(savedTheme);

		function toggleTheme() {
			const currentTheme = htmlElement.getAttribute('data-theme');
			const newTheme = currentTheme === 'light' ? 'dark' : 'light';

			htmlElement.setAttribute('data-theme', newTheme);
			localStorage.setItem('theme', newTheme);
			updateThemeIcon(newTheme);
		}

		function updateThemeIcon(theme) {
			const iconClass = theme === 'dark' ? 'zmdi-brightness-7' : 'zmdi-brightness-2';

			if (themeToggle) {
				const icon = themeToggle.querySelector('i');
				icon.className = 'zmdi ' + iconClass;
			}

			if (themeToggleMobile) {
				const iconMobile = themeToggleMobile.querySelector('i');
				iconMobile.className = 'zmdi ' + iconClass;
			}
		}

		if (themeToggle) {
			themeToggle.addEventListener('click', toggleTheme);
		}

		if (themeToggleMobile) {
			themeToggleMobile.addEventListener('click', toggleTheme);
		}
	})();

	// Side Cart Functionality
	function loadSideCart() {
		$('#side-cart-loading').show();
		$('#side-cart-items .header-cart-item').remove();
		$('#side-cart-footer').hide();
		$('#side-cart-empty-msg').hide();

		$.ajax({
			url: 'cart',
			type: 'GET',
			dataType: 'json',
			success: function(response) {
				$('#side-cart-loading').hide();
				
				if (response.cartItems && response.cartItems.length > 0) {
					$('#side-cart-footer').show();
					
					let itemsHtml = '';
					response.cartItems.forEach(function(item) {
						let imageSrc = item.productImageUrl ? item.productImageUrl : 'images/product-01.jpg';
						itemsHtml += `
							<li class="header-cart-item flex-w flex-t m-b-12">
								<div class="header-cart-item-img" onclick="removeSideCartItem(this, ${item.productId})">
									<img src="${imageSrc}" alt="${item.productName}">
								</div>
								<div class="header-cart-item-txt p-t-8">
									<a href="product?id=${item.productId}" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
										${item.productName}
									</a>
									<span class="header-cart-item-info">
										${item.quantity} x $${item.price.toFixed(2)}
									</span>
								</div>
							</li>
						`;
					});
					
					// Insert items before the loading placeholder
					$(itemsHtml).insertBefore('#side-cart-loading');
					
					// Update total
					$('#side-cart-total').text('Total: $' + response.cartTotal.toFixed(2));
					
					// Update cart badge
					$('.icon-header-noti').attr('data-notify', response.totalCartItems);
				} else {
					$('#side-cart-empty-msg').show();
					$('.icon-header-noti').attr('data-notify', '0');
				}
			},
			error: function() {
				$('#side-cart-loading').hide();
				$('#side-cart-empty-msg').show();
			}
		});
	}

	function removeSideCartItem(imgEl, productId) {
		// Prevent multiple clicks
		if($(imgEl).hasClass('loading')) return;
		$(imgEl).addClass('loading');
		
		// Find the quantity text to know how many to remove
		let infoTxt = $(imgEl).siblings('.header-cart-item-txt').find('.header-cart-item-info').text();
		let qtyMatch = infoTxt.match(/(\d+)\s*x/);
		let qty = qtyMatch ? parseInt(qtyMatch[1]) : 1;

		$.ajax({
			url: 'cart',
			type: 'POST',
			dataType: 'json',
			data: { productId: productId, delta: -qty },
			success: function(response) {
				if (response.status === 'success') {
					// Reload cart to get updated totals and items
					loadSideCart();
					
					// If there is a showToast function available (from store/product page)
					if (typeof showToast === 'function') {
						let productName = $(imgEl).siblings('.header-cart-item-txt').find('.header-cart-item-name').text().trim();
						showToast('Removed from cart', productName, 'remove');
					}
					
					// If we are on shopping cart page, we might want to reload or call recalculate
					if (window.location.href.indexOf('shopping-cart') > -1) {
						window.location.reload();
					}
				} else {
					$(imgEl).removeClass('loading');
					if (typeof showToast === 'function') showToast('Error', response.message, 'error');
				}
			},
			error: function() {
				$(imgEl).removeClass('loading');
				if (typeof showToast === 'function') showToast('Error', 'Could not connect to server', 'error');
			}
		});
	}
</script>

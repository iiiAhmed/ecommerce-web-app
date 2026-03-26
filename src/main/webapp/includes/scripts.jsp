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
</script>

<!-- Cart Sidebar -->
<div class="wrap-header-cart js-panel-cart">
    <div class="s-full js-hide-cart"></div>

    <div class="header-cart flex-col-l p-l-65 p-r-25">
        <div class="header-cart-title flex-w flex-sb-m p-b-8">
            <span class="mtext-103 cl2">
                Your Cart
            </span>

            <div class="fs-35 lh-10 cl2 p-lr-5 pointer hov-cl1 trans-04 js-hide-cart">
                <i class="zmdi zmdi-close"></i>
            </div>
        </div>

        <div class="header-cart-content flex-w js-pscroll">
            <ul class="header-cart-wrapitem w-full" id="side-cart-items">
                <!-- Cart items will be populated dynamically -->
                <li class="side-cart-loader-wrap" id="side-cart-loading" style="display: none;">
                    <div class="side-cart-spinner"></div>
                </li>
            </ul>

            <div class="w-full" id="side-cart-footer" style="display: none;">
                <div class="header-cart-total w-full p-tb-40" id="side-cart-total">
                    Total: $0.00
                </div>

                <div class="header-cart-buttons flex-w w-full" id="side-cart-checkout-btn">
                    <a href="shopping-cart"
                        class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-b-10">
                        View Cart
                    </a>
                </div>
            </div>
            
            <div id="side-cart-empty-msg" class="w-full" style="display: none;">
                <div class="side-cart-empty-state">
                    <i class="zmdi zmdi-shopping-cart"></i>
                    <p>Your cart is empty</p>
                    <a href="shop">Continue Shopping</a>
                </div>
            </div>
        </div>
    </div>
</div>

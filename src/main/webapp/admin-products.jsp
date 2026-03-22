<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <title>Admin - Manage Products</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="images/icons/favicon.png" />
        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" type="text/css" href="fonts/linearicons-v1.0.0/icon-font.min.css">
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
        <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
        <link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">
        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
    </head>

    <body class="animsition">

        <!-- Header -->
        <header class="header-v4">
            <div class="container-menu-desktop">

                <div class="wrap-menu-desktop how-shadow1">
                    <nav class="limiter-menu-desktop container">
                        <a href="index.jsp" class="logo">
                            <img src="images/icons/logo-01.png" alt="IMG-LOGO">
                        </a>

                        <div class="menu-desktop">
                            <ul class="main-menu">
                                <li class="active-menu"><a href="admin-products.html">Manage Products</a></li>
                                <li><a href="admin-customers.jsp">Review Customers</a></li>
                                <li><a href="index.jsp" target="_blank">View Store</a></li>
                            </ul>
                        </div>

                        <!-- Admin Identity -->
                        <div class="wrap-icon-header flex-w flex-r-m">
                            <span class="stext-106 cl2 p-r-15" style="font-weight: 500;">Welcome,
                                ${sessionScope.userDto.name}</span>
                            <a href="#" onclick="logout(); return false;" class="stext-106 hov-cl1 trans-04"
                                style="color: #e74c3c;">Logout</a>
                        </div>
                    </nav>
                </div>
            </div>
        </header>

        <!-- Title -->
        <div class="bg0 p-t-60 p-b-20" style="background-color: #f7f7f7;">
            <div class="container">
                <h3 class="ltext-103 cl5 txt-center">
                    Product Inventory Management
                </h3>

                <!-- Flash Messages -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success mt-3 text-center">
                        <c:out value="${sessionScope.successMessage}" />
                    </div>
                    <c:remove var="successMessage" scope="session" />
                </c:if>
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="alert alert-danger mt-3 text-center">
                        <c:out value="${sessionScope.errorMessage}" />
                    </div>
                    <c:remove var="errorMessage" scope="session" />
                </c:if>
            </div>
        </div>

        <!-- Content page -->
        <section class="bg0 p-t-20 p-b-116" style="background-color: #f7f7f7;">
            <div class="container">
                <div class="bg0 bor10 p-t-30 p-b-40 p-lr-40 p-lr-15-sm">

                    <div class="flex-w flex-sb-m p-b-30">
                        <h4 class="mtext-109 cl2">All Products</h4>
                        <button
                            class="flex-c-m stext-101 cl0 size-112 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer js-show-add-product"
                            style="max-width: 200px;">
                            + Add New Product
                        </button>
                    </div>

                    <div class="wrap-table-shopping-cart">
                        <table class="table-shopping-cart">
                            <tr class="table_head">
                                <th class="column-1">Product</th>
                                <th class="column-2">Name</th>
                                <th class="column-3">Price</th>
                                <th class="column-4">Quantity in Stock</th>
                                <th class="column-5">Actions</th>
                            </tr>

                            <c:forEach items="${products}" var="product">
                                <tr class="table_row" id="prod-${product.productId}">
                                    <td class="column-1">
                                        <div class="how-itemcart1">
                                            <img src="<c:out value='${not empty product.imageUrl ? product.imageUrl : \"
                                                images/item-cart-01.jpg\"}' />" alt="IMG">
                                        </div>
                                    </td>
                                    <td class="column-2">
                                        <c:out value="${product.name}" />
                                    </td>
                                    <td class="column-3">$
                                        <c:out value="${product.price}" />
                                    </td>
                                    <td class="column-4">
                                        <span
                                            class="badge ${product.quantity > 10 ? 'badge-success' : 'badge-warning'} p-lr-10 p-tb-5">
                                            <c:out value="${product.quantity}" />
                                        </span>
                                    </td>
                                    <td class="column-5">
                                        <button
                                            class="stext-106 cl6 hov1 bor3 trans-04 p-lr-15 p-tb-5 m-r-10 text-primary js-edit-product"
                                            data-id="${product.productId}" data-name="<c:out value='${product.name}'/>"
                                            data-brand="<c:out value='${product.brand}'/>" data-price="${product.price}"
                                            data-quantity="${product.quantity}"
                                            data-desc="<c:out value='${product.description}'/>"
                                            data-gender="${product.gender}" data-age="${product.age}"
                                            data-category="${product.category}"
                                            data-image="<c:out value='${product.imageUrl}'/>">Edit</button>
                                        <button
                                            class="stext-106 cl6 hov1 bor3 trans-04 p-lr-15 p-tb-5 text-danger js-remove-product"
                                            data-id="${product.productId}">Remove</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>

                </div>
            </div>
        </section>

        <!-- Modal: Add / Edit Product -->
        <div class="wrap-modal1 js-modal-product p-t-60 p-b-20">
            <div class="overlay-modal1 js-hide-modal-product"></div>

            <div class="container">
                <div class="bg0 p-t-60 p-b-30 p-lr-15-lg how-pos3-parent bor10">
                    <button class="how-pos3 hov3 trans-04 js-hide-modal-product">
                        <img src="images/icons/icon-close.png" alt="CLOSE">
                    </button>

                    <div class="row px-5">
                        <div class="col-12">
                            <h4 class="mtext-105 cl2 txt-center p-b-30" id="modalProductTitle">
                                Add / Edit Product
                            </h4>

                            <form id="productForm" action="admin-product" method="POST" enctype="multipart/form-data">
                                <input type="hidden" id="pAction" name="action" value="add">
                                <input type="hidden" id="pId" name="productId" value="">
                                <input type="hidden" id="pCurrentImageUrl" name="imageUrl" value="">

                                <div class="row">
                                    <div class="col-sm-6 bor8 m-b-20 how-pos4-parent">
                                        <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="text" id="pName"
                                            name="name" placeholder="Product Name" required>
                                    </div>
                                    <div class="col-sm-6 bor8 m-b-20 how-pos4-parent">
                                        <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="text" id="pBrand"
                                            name="brand" placeholder="Brand" required>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-6 bor8 m-b-20 how-pos4-parent">
                                        <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="number"
                                            id="pPrice" name="price" placeholder="Price ($)" required min="0"
                                            step="0.01">
                                    </div>
                                    <div class="col-sm-6 bor8 m-b-20 how-pos4-parent">
                                        <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="number"
                                            id="pQuantity" name="quantity" placeholder="Quantity In Stock" required
                                            min="0">
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-4 bor8 m-b-20">
                                        <select class="stext-111 cl2 plh3 size-116 p-l-20" id="pCategory"
                                            name="category" required>
                                            <option value="" disabled selected>Category</option>
                                            <c:forEach items="${categories}" var="cat">
                                                <option value="${cat}">${cat}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-sm-4 bor8 m-b-20">
                                        <select class="stext-111 cl2 plh3 size-116 p-l-20" id="pGender" name="gender"
                                            required>
                                            <option value="" disabled selected>Gender</option>
                                            <c:forEach items="${genders}" var="gen">
                                                <option value="${gen}">${gen}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-sm-4 bor8 m-b-20">
                                        <select class="stext-111 cl2 plh3 size-116 p-l-20" id="pAge" name="age"
                                            required>
                                            <option value="" disabled selected>Age</option>
                                            <c:forEach items="${ages}" var="age">
                                                <option value="${age}">${age}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <div class="bor8 m-b-20 how-pos4-parent">
                                    <input class="stext-111 cl2 plh3 size-116 p-l-20 p-r-30" type="file" id="pImageFile"
                                        name="imageFile" accept="image/jpeg,image/png" required>
                                </div>

                                <div class="bor8 m-b-30">
                                    <textarea class="stext-111 cl2 plh3 size-120 p-lr-20 p-tb-25" id="pDesc"
                                        name="description" placeholder="Product Description" required></textarea>
                                </div>

                                <button type="submit"
                                    class="flex-c-m stext-101 cl0 size-121 bg3 bor1 hov-btn3 p-lr-15 trans-04 pointer">
                                    Save Product
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
        <script src="vendor/animsition/js/animsition.min.js"></script>
        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
        <script>
            $('.js-show-add-product').on('click', function (e) {
                e.preventDefault();
                $('#modalProductTitle').text('Add New Product');
                $('#productForm')[0].reset();
                $('#pAction').val('add');
                $('#pId').val('');
                $('#pCurrentImageUrl').val('');
                $('#pImageFile').prop('required', true);
                $('.js-modal-product').addClass('show-modal1');
            });

            $('.js-hide-modal-product').on('click', function () {
                $('.js-modal-product').removeClass('show-modal1');
            });

            $('.js-edit-product').on('click', function () {
                const btn = $(this);
                const name = btn.data('name');
                $('#modalProductTitle').text('Edit Product: ' + name);
                $('#pAction').val('update');
                $('#pId').val(btn.data('id'));
                $('#pName').val(name);
                $('#pBrand').val(btn.data('brand'));
                $('#pPrice').val(btn.data('price'));
                $('#pQuantity').val(btn.data('quantity'));
                $('#pDesc').val(btn.data('desc'));
                $('#pGender').val(btn.data('gender'));
                $('#pAge').val(btn.data('age'));
                $('#pCategory').val(btn.data('category'));
                $('#pCurrentImageUrl').val(btn.data('image'));
                $('#pImageFile').prop('required', false);
                $('.js-modal-product').addClass('show-modal1');
            });

            $('.js-remove-product').on('click', function () {
                const id = $(this).data('id');
                if (confirm('Are you sure you want to remove this product?')) {
                    const form = $('<form>', {
                        action: 'admin-product',
                        method: 'POST'
                    }).append($('<input>', {
                        type: 'hidden',
                        name: 'action',
                        value: 'delete'
                    })).append($('<input>', {
                        type: 'hidden',
                        name: 'productId',
                        value: id
                    }));
                    $('body').append(form);
                    form.submit();
                }
            });

            function logout() {
                window.location.href = 'logout';
            }
        </script>
    </body>

    </html>
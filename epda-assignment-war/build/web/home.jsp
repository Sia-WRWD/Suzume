<%-- 
    Document   : home
    Created on : Mar 30, 2023, 1:59:53 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Suzume's Home</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.css" rel="stylesheet"/>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>
        <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    </head>
    <body>
        <jsp:include page="nav/banner.jsp" />

        <c:if test="${empty sessionScope.uname or sessionScope.role eq 'customer'}">
            <!-- Jumbotron -->
            <div class="home-banner text-white py-5">
                <div class="home-banner-text container py-5">
                    <h1>
                        Best Anime Products & <br />
                        Brands in our store
                    </h1>
                    <p>
                        Trendy Products, Factory Prices, Excellent Service
                    </p>
                    <c:if test="${empty sessionScope.uname}">
                        <a type="button" class="btn btn-outline-light" href="${pageContext.request.contextPath}/authentication/customer-register.jsp">
                            Sign Up
                        </a>
                    </c:if>
                    <a type="button" class="btnHover2 btn btn-danger shadow-0 text-white pt-2 border border-white"
                       href="${pageContext.request.contextPath}/market/all-items.jsp">
                        <span class="pt-1">Shop Now!</span>
                    </a>
                </div>
            </div>
            <!-- Jumbotron -->

            <!--4 Items in Market-->
            <c:if test="${not empty sessionScope.uname and sessionScope.role eq 'customer'}">
                <section class="pb-4" style="background-color: #ffffff;">
                    <div class="container text-dark">
                        <header class="pt-4 pb-3 d-flex align-items-center">
                            <h3>Recently Added Items</h3>
                            <span class="ms-2 text-muted btnMarket" style="cursor: pointer;">
                                <a class="text-info" href="${pageContext.request.contextPath}/market/all-items.jsp">
                                    Visit Market <i class="fas fa-arrow-right-long"></i>
                                </a>
                            </span>
                        </header>
                        <div class="row">
                            <c:forEach var="item" items="${allItemList}" varStatus="loop">
                                <c:if test="${loop.index >= (allItemList.size()-3)}">
                                    <c:if test="${(item.status ne 'Out of Stock' and item.status ne 'Discontinued') and 
                                                  (item.getSeller().getStatus() ne 'Pending' and item.getSeller().getStatus() ne 'Deactivated')}">
                                          <div class="col-md-12 col-lg-4 mb-4 mb-lg-0">
                                              <div class="card item-card mb-4">
                                                  <div class="d-flex justify-content-between p-3 flex-end">
                                                      <p class="lead mb-0 fw-bold">
                                                          <a href="${pageContext.request.contextPath}/GetViewProfileDetails?accountId=${item.seller.getId()}&role=seller&loca=market"
                                                             class="text-black link-hover">
                                                              ${item.seller.getShopName()} 
                                                          </a>
                                                          -
                                                      <fmt:formatNumber type="number" value="${item.seller.getRatings()}" minFractionDigits="2" maxFractionDigits="2" /> 
                                                      <i class="text-warning fa fa-star"></i>
                                                      </p>
                                                  </div>
                                                  <img src="${item.imgUrl}"
                                                       data-mdb-image="${item.imgUrl}"
                                                       class="card-img-top product-img" alt="Laptop" data-mdb-toggle="modal" data-mdb-target="#pic-modal" style='cursor: zoom-in'/>
                                                  <div class="card-body">
                                                      <div class="d-flex justify-content-between">
                                                          <p class="small text-info mb-2 item-category">${item.category}</p>
                                                          <p class="small text-danger mb-2">
                                                              <i class="fas fa-truck"></i> ${item.deliveryType}
                                                          </p>
                                                      </div>

                                                      <div class="d-flex justify-content-between mb-2 col-12 align-items-center">
                                                          <h6 class="mb-0 col-8">${item.name}</h6>
                                                          <h6 class="text-dark mb-0 col-4 text-end">
                                                              RM <fmt:formatNumber type="number" value="${item.unitPrice}" minFractionDigits="2" maxFractionDigits="2" />
                                                          </h6>
                                                      </div>
                                                      <div class="d-flex justify-content-start">
                                                          <p class="text-muted small mb-2" title="${item.description}"
                                                             style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                              ${item.description}
                                                          </p>
                                                      </div>

                                                      <div class="d-flex justify-content-between mb-2">
                                                          <p class="text-muted mb-0">Available: <span class="fw-bold">${item.availableQuantity}</span></p>
                                                          <div class="ms-auto text-muted">
                                                              <fmt:formatNumber type="number" value="${item.ratings}" minFractionDigits="2" maxFractionDigits="2" /> <i class="text-warning fa fa-star"></i>
                                                          </div>
                                                      </div>
                                                      <div class="">
                                                          <form method="POST" action="${pageContext.request.contextPath}/AddToCart">
                                                              <input type="hidden" value="${item.id}" name="itemId">
                                                              <input type="hidden" value="1" name="itemQty">
                                                              <button type="submit" class="btn btn-block btn-primary d-flex align-items-center justify-content-center p-3">
                                                                  Add to Cart <i class="fas fa-cart-plus fa-lg me-2 fa-fw"></i>
                                                              </button>
                                                          </form>
                                                      </div>
                                                  </div>
                                              </div>
                                          </div>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </section>
            </c:if>
            <!--4 Items in Market-->


            <!--Feature-->
            <section class="pt-4 pb-4" style="background-color: #f5f5f5;">
                <div class="container text-dark pt-3">
                    <header class="pt-4 pb-3">
                        <h3>Why Choose Us?</h3>
                    </header>

                    <div class="row mb-4">
                        <div class="col-lg-4 col-md-6">
                            <figure class="d-flex align-items-center mb-4">
                                <span class="rounded-circle bg-white p-3 d-flex me-2 mb-2">
                                    <i class="fa fa-camera-retro fa-2x fa-fw text-primary floating"></i>
                                </span>
                                <figcaption class="info">
                                    <h6 class="title">Reasonable prices</h6>
                                    <p>Affordable prices without sacrificing quality or value.</p>
                                </figcaption>
                            </figure>
                            <!-- itemside // -->
                        </div>
                        <!-- col // -->
                        <div class="col-lg-4 col-md-6">
                            <figure class="d-flex align-items-center mb-4">
                                <span class="rounded-circle bg-white p-3 d-flex me-2 mb-2">
                                    <i class="fa fa-star fa-2x fa-fw text-primary floating"></i>
                                </span>
                                <figcaption class="info">
                                    <h6 class="title">Best quality</h6>
                                    <p>Uncompromising quality that exceeds expectations and sets the standard for excellence.</p>
                                </figcaption>
                            </figure>
                            <!-- itemside // -->
                        </div>
                        <!-- col // -->
                        <div class="col-lg-4 col-md-6">
                            <figure class="d-flex align-items-center mb-4">
                                <span class="rounded-circle bg-white p-3 d-flex me-2 mb-2">
                                    <i class="fa fa-plane fa-2x fa-fw text-primary floating"></i>
                                </span>
                                <figcaption class="info">
                                    <h6 class="title">Worldwide shipping</h6>
                                    <p>Worldwide shipping available to bring our products to your doorstep, no matter where you are.</p>
                                </figcaption>
                            </figure>
                            <!-- itemside // -->
                        </div>
                        <!-- col // -->
                        <div class="col-lg-4 col-md-6">
                            <figure class="d-flex align-items-center mb-4">
                                <span class="rounded-circle bg-white p-3 d-flex me-2 mb-2">
                                    <i class="fa fa-users fa-2x fa-fw text-primary floating"></i>
                                </span>
                                <figcaption class="info">
                                    <h6 class="title">Customer satisfaction</h6>
                                    <p>Your satisfaction is our top priority, and we strive to exceed your expectations with every purchase.</p>
                                </figcaption>
                            </figure>
                            <!-- itemside // -->
                        </div>
                        <!-- col // -->
                        <div class="col-lg-4 col-md-6">
                            <figure class="d-flex align-items-center mb-4">
                                <span class="rounded-circle bg-white p-3 d-flex me-2 mb-2">
                                    <i class="fa fa-thumbs-up fa-2x fa-fw text-primary floating"></i>
                                </span>
                                <figcaption class="info">
                                    <h6 class="title">Happy customers</h6>
                                    <p>Our happy customers are a testament to our commitment to quality and customer satisfaction.</p>
                                </figcaption>
                            </figure>
                            <!-- itemside // -->
                        </div>
                        <!-- col // -->
                        <div class="col-lg-4 col-md-6">
                            <figure class="d-flex align-items-center mb-4">
                                <span class="rounded-circle bg-white p-3 d-flex me-2 mb-2">
                                    <i class="fa fa-gift fa-2x fa-fw text-primary floating"></i>
                                </span>
                                <figcaption class="info">
                                    <h6 class="title">Thousand items</h6>
                                    <p>Explore our vast selection of over a thousand items to find the perfect product for your needs.</p>
                                </figcaption>
                            </figure>
                            <!-- itemside // -->
                        </div>
                        <!-- col // -->
                    </div>
                </div>
                <!-- container end.// -->
            </section>
            <!-- Feature -->

            <!-- Blog -->
            <section class="mt-5 mb-4">
                <div class="container text-dark">
                    <header class="mb-4">
                        <h3>Blog Posts</h3>
                    </header>

                    <div class="row">
                        <div class="col-lg-3 col-md-6 col-sm-6 col-12">
                            <article>
                                <a href="#" class="bg-image hover-zoom">
                                    <img class="rounded w-100" src="https://i.ytimg.com/vi/r2rGR-9u60I/maxresdefault.jpg" style="object-fit: cover;" height="160" />
                                </a>
                                <div class="mt-2 text-muted small d-block mb-1">
                                    <span>
                                        <i class="fa fa-calendar-alt fa-sm"></i>
                                        23.12.2022
                                    </span>
                                    <a href="#"><h6 class="text-dark">How to promote brands</h6></a>
                                    <p>Learn how to boost your brand's visibility and attract more customers with these effective promotion strategies.</p>
                                </div>
                            </article>
                        </div>
                        <!-- col.// -->
                        <div class="col-lg-3 col-md-6 col-sm-6 col-12">
                            <article>
                                <a href="#" class="bg-image hover-zoom">
                                    <img class="rounded w-100" src="https://cdn.idntimes.com/content-images/duniaku/post/20220715/untitled-1-1e40242e5dc1cf4be445a57ae14523c3.jpg" style="object-fit: cover;" height="160" />
                                </a>
                                <div class="mt-2 text-muted small d-block mb-1">
                                    <span>
                                        <i class="fa fa-calendar-alt fa-sm"></i>
                                        13.12.2022
                                    </span>
                                    <a href="#"><h6 class="text-dark">How we handle shipping</h6></a>
                                    <p>Discover the most efficient ways to handle shipping for your business and ensure timely delivery of your products to customers.</p>
                                </div>
                            </article>
                        </div>
                        <!-- col.// -->
                        <div class="col-lg-3 col-md-6 col-sm-6 col-12">
                            <article>
                                <a href="#" class="bg-image hover-zoom">
                                    <img class="rounded w-100" src="https://sportshub.cbsistatic.com/i/2022/08/03/e6fde283-487c-413a-9931-32ef42e14518/makoto-shinkai-suzume-no-tojimari-daijin.jpg" style="object-fit: cover;" height="160" />
                                </a>
                                <div class="mt-2 text-muted small d-block mb-1">
                                    <span>
                                        <i class="fa fa-calendar-alt fa-sm"></i>
                                        25.11.2022
                                    </span>
                                    <a href="#"><h6 class="text-dark">How to sell anything</h6></a>
                                    <p>Unlock the secrets to selling anything, anywhere with these proven strategies and expert tips for boosting sales and maximizing profits.</p>
                                </div>
                            </article>
                        </div>
                        <!-- col.// -->
                        <div class="col-lg-3 col-md-6 col-sm-6 col-12">
                            <article>
                                <a href="#" class="bg-image hover-zoom">
                                    <img class="rounded w-100" src="https://i.redd.it/iygdiceb33ba1.jpg" style="object-fit: cover;" height="160" />
                                </a>
                                <div class="mt-2 text-muted small d-block mb-1">
                                    <span>
                                        <i class="fa fa-calendar-alt fa-sm"></i>
                                        03.09.2022
                                    </span>
                                    <a href="#"><h6 class="text-dark">Success story of sellers</h6></a>
                                    <p>Get inspired by the success stories of top sellers who turned their passion into profit and achieved financial independence through online selling.</p>
                                </div>
                            </article>
                        </div>
                    </div>
                </div>
            </section>
        </c:if>
        <!-- Blog -->
        
        <c:if test="${not empty sessionScope.uname && sessionScope.role eq 'seller'}">
            <jsp:include page="seller/seller-home-content.jsp" />
        </c:if>
        <c:if test="${not empty sessionScope.uname && sessionScope.role eq 'admin'}">
            <jsp:include page="admin/admin-home-content.jsp" />
        </c:if>

        <!-- Pic Preview Modal-->
        <div class="modal fade" id="pic-modal" tabindex="-1" aria-labelledby="picModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <img src="" id="pic-modal-img">
                </div>
            </div>
        </div>

        <jsp:include page="shared/backtotop.jsp" />
        <jsp:include page="shared/music-player.jsp" />
        <jsp:include page="nav/footer.jsp" />

        <!-- Alert -->
        <c:if test="${not empty loginSuccess or not empty transactionSuccess}">
            <div class="alert alert-success" id="alert-success">
                ${transactionSuccess}
                ${loginSuccess}
                <i class="fas fa-circle-check" style="font-size: 25px; margin-left: 10px;"></i>
            </div>
        </c:if>
        <!-- Alert -->

        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script type="text/javascript">
            window.onload = function () {
                //Servlet API to execute
                getAllItems();
                getAllBest();
            };

            function getAllItems() {
                var xhr = new XMLHttpRequest();

                xhr.open('GET', '/epda-assignment-war/Market', true);

                xhr.setRequestHeader('Content-Type', 'application/json');

                xhr.send();
            }

            function getAllBest() {
                var xhr = new XMLHttpRequest();

                xhr.open('GET', '/epda-assignment-war/GetAllBest', true);

                xhr.setRequestHeader('Content-Type', 'application/json');

                xhr.send();
            }

            // Hide the alert after 3 seconds
            setTimeout(function () {
                var successAlert = document.getElementById("alert-success");
                var errorAlert = document.getElementById("alert-error")
                if (successAlert) {
                    successAlert.style.display = "none";
                } else if (errorAlert) {
                    errorAlert.style.display = "none";
                }
            }, 3000);

            const images = document.querySelectorAll('.product-img');

            images.forEach(function (image) {
                image.addEventListener('click', function () {
                    var imgUrl = image.getAttribute('data-mdb-image');

                    const modalImg = document.querySelector("#pic-modal-img");
                    modalImg.src = imgUrl;
                });
            });

            function filter() {
                var filterValue = document.querySelector('input[name="category"]:checked').value;
                window.location.href = "${pageContext.request.contextPath}/FilterItems?category=" + filterValue;
            }
        </script>
    </body>
</html>
<style>
    .alert {
        display: flex;
        justify-content: center;
        align-items: center;
        border: 0;
        position: fixed;
        bottom: 0px;
        right: 15px;
        width: auto;
        z-index: 3;
    }

    .home-banner {
        background-image: url("https://cdn.wallpapersafari.com/69/52/uHlkx7.jpg");
        background-repeat: no-repeat;
        background-position: center;
        background-size: cover;
        background-attachment: fixed;
        position: relative;
    }

    .home-banner:after {
        content:'';
        position:absolute;
        left:0px;
        top:0px;
        width:100%;
        height:100%;
        background: rgba(0, 0, 0, 0.5);
    }

    .home-banner-text {
        position: relative;
        z-index: 1;
        text-shadow: 1px 2px 3px black;
    }

    .btnHover2:hover {
        background: #3b71ca !important;
        transition: 0.3s ease-in-out;
    }

    .btnMarket:hover {
        transition: 0.3s ease-in-out;
        transform: translateX(10px);
    }

    .link-hover:hover {
        text-decoration: underline;
        transition: 0.3s ease-in-out;
        color: #03A9F4 !important;
    }

    .all-item-container {
        position: relative;
        z-index: 2;
    }

    .card {
        border-radius: 15px !important;
        transition: 0.4s ease-out;
        background: #fff; 
        overflow: hidden;
    }

    .card:hover {
        transform: translateY(0px);   
    }

    .card:hover:after {
        opacity: 1;
    }

    .card:hover .card-description {
        opacity: 1;
        transform: translateY(0px);
    }

    .card-description {
        opacity: 0;
        position: absolute;
        bottom: 0;
        height: 100%;
        z-index: 3;
        transform: translateY(30px);
        transition: 0.5s;
        text-shadow: 1px 2px 3px black;
    }

    .card-img-top {
        border-top-left-radius: 0 !important;
        border-top-right-radius: 0 !important;
        width: auto;
        height: 150px;
        object-fit: cover;
        object-position: top;
    }
</style>

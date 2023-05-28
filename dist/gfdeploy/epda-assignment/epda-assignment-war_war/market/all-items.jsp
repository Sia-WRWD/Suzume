<%-- 
    Document   : all-items
    Created on : Apr 5, 2023, 11:36:34 AM
    Author     : Sia_RTX3070
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Items</title>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.css" rel="stylesheet"/>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>
        <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    </head>
    <body>
        <c:if test="${not empty sessionScope.uname && role ne 'customer'}">
            <%
                response.sendRedirect("/epda-assignment-war/home.jsp");
            %>
        </c:if>

        <jsp:include page="../nav/banner.jsp" />

        <section class="h-100 bg">
            <div class="container vh-100 py-5 all-item-container">
                <div class="row gx-5 h-100">
                    <div class="col-2 border p-0 filter-container text-white" style="height: fit-content;">
                        <div class="p-3 h-100 w-100">
                            <div class="d-flex justify-content-start">
                                <p class="fw-bold">Category Filter</p>
                            </div>
                            <div class="ms-2 mb-2 form-check">
                                <input class="form-check-input category-filter" type="radio" name="category" id="All" value="All" aria-label="All" onclick="filter()"/>
                                <label class="form-check-label" for="All">All</label>
                            </div>
                            <div class="ms-2 mb-2 form-check">
                                <input class="form-check-input category-filter" type="radio" name="category" id="Figurine" value="Figurine" aria-label="Figurine" onclick="filter()"/>
                                <label class="form-check-label" for="Figurine">Figurine</label>
                            </div>
                            <div class="ms-2 mb-2 form-check">
                                <input class="form-check-input category-filter" type="radio" name="category" id="Poster" value="Poster" aria-label="Poster" onclick="filter()"/>
                                <label class="form-check-label" for="Poster">Poster</label>
                            </div>
                            <div class="ms-2 mb-2 form-check">
                                <input class="form-check-input category-filter" type="radio" name="category" id="Badge" value="Badge" aria-label="Badge" onclick="filter()"/>
                                <label class="form-check-label" for="Badge">Badge</label>
                            </div>
                            <div class="ms-2 mb-2 form-check">
                                <input class="form-check-input category-filter" type="radio" name="category" id="Plushy" value="Plushy" aria-label="Plushy" onclick="filter()"/>
                                <label class="form-check-label" for="Plushy">Plushy</label>
                            </div>
                            <div class="ms-2 mb-2 form-check">
                                <input class="form-check-input category-filter" type="radio" name="category" id="Light Novel" value="Light-Novel" aria-label="Light Novel" onclick="filter()"/>
                                <label class="form-check-label" for="Light Novel">Light Novel</label>
                            </div>
                            <div class="ms-2 mb-2 form-check">
                                <input class="form-check-input category-filter" type="radio" name="category" id="T-Shirt" value="T-Shirt" aria-label="T-Shirt" onclick="filter()"/>
                                <label class="form-check-label" for="T-Shirt">T-Shirt</label>
                            </div>
                        </div>
                    </div>
                    <div class="col-10 p-3 h-100 overflow-y-scroll item-card-container"">    
                        <div class="row h-100">
                            <c:if test="${not empty sessionScope.allItemList && empty filteredList}">
                                <c:forEach var="item" items="${sessionScope.allItemList}">
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
                                </c:forEach>
                            </c:if>
                            <c:if test="${not empty filteredList}">
                                <c:forEach var="item" items="${filteredList}">
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
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty sessionScope.allItemList && empty sessionScope.filteredList}">
                                <div class="d-flex align-items-center justify-content-center flex-column h-100" style="filter: drop-shadow(1px 2px 3px black);">
                                    <h2 class="text-warning fw-bold">No item is in the market!?</h2>
                                    <img src="${pageContext.request.contextPath}/market/no-item.png" al="no-items.png" style="height: 350px; width: 400px;">
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Pic Preview Modal-->
        <div class="modal fade" id="pic-modal" tabindex="-1" aria-labelledby="picModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <img src="" id="pic-modal-img">
                </div>
            </div>
        </div>

        <jsp:include page="../shared/backtotop.jsp" />
        <jsp:include page="../shared/music-player.jsp" />
        <jsp:include page="../nav/footer.jsp" />

        <script>
            //Send Img Src Value to Modal
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
    .bg {
        background-image: url("https://rare-gallery.com/mocahbig/420860-digital-art-Japanese-Art-night-street-rain-Market.jpg");
        background-size: cover;
        background-repeat: no-repeat;
        background-position: center;
        position: relative;
    }

    .bg:after {
        content:'';
        position:absolute;
        left:0px;
        top:0px;
        width:100%;
        height:100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: 1;
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

    .filter-container, .item-card-container {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(3px);
        filter: drop-shadow(1px 2px 3px black);
    }

    .link-hover:hover {
        text-decoration: underline;
        transition: 0.3s ease-in-out;
        color: #03A9F4 !important;
    }
</style>

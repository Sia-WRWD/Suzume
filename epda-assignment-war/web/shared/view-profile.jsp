<%-- 
    Document   : view-profile
    Created on : May 10, 2023, 1:12:28 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Profile Page</title>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.css" rel="stylesheet"/>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>
        <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    </head>
    <body>
        <jsp:include page="../nav/banner.jsp" />

        <section class="bg vh-100">
            <div class="container h-100 w-100 d-flex py-4" style="position: relative; z-index: 2;">
                <div class="row h-100 col-4">
                    <div class="col-md-12 col-xl-12 mb-4">

                        <div class="card pb-1" style="border-radius: 15px;">
                            <div class="card-body text-center d-flex justify-content-center flex-column">
                                <div class="mt-3 mb-4">
                                    <c:if test="${vpRole eq 'seller'}">
                                        <img src="${pageContext.request.contextPath}/shared/seller-pic.png"
                                             class="rounded-circle img-fluid" style="width: 195px; height: 110px; filter: drop-shadow(1px 2px 3px black);" />
                                    </c:if>
                                    <c:if test="${vpRole eq 'customer'}">
                                        <img src="${pageContext.request.contextPath}/shared/customer-pic.png"
                                             class="rounded-circle img-fluid" style="width: 145px; height: 110px; filter: drop-shadow(1px 2px 3px black);" />
                                    </c:if>
                                </div>
                                <c:if test="${vpRole eq 'customer'}">
                                    <div class="d-flex justify-content-around text-center mb-3">
                                        <div>
                                            <h3 class="mb-0 text-info">
                                                ${vpAccd.getName()}
                                            </h3>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${vpRole eq 'seller'}">
                                    <div class="d-flex justify-content-around text-center mb-3">
                                        <div>
                                            <h3 class="mb-0 text-info">
                                                <i class="fas fa-store me-1 fa-fw"></i> ${vpAccd.getShopName()}
                                            </h3>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${vpRole eq 'customer'}">
                                    <div class="d-flex justify-content-around text-center mt-5 mb-2">
                                        <div>
                                            <p class="mb-2 h5 text-white">${vpAccd.getRatings()}</p>
                                            <p class="mb-0 text-info">Ratings</p>
                                        </div>
                                        <div>
                                            <p class="mb-2 h5 text-white">${vpTrans.size()}</p>
                                            <p class="mb-0 text-info">Total Transactions</p>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${vpRole eq 'seller'}">
                                    <div class="d-flex justify-content-around text-center mt-5 mb-2">
                                        <div>
                                            <p class="mb-2 h5 text-white">${vpAccd.getRatings()}</p>
                                            <p class="mb-0 text-info">Ratings</p>
                                        </div>
                                        <div>
                                            <p class="mb-2 h5 text-white">${vpTrans.size()}</p>
                                            <p class="mb-0 text-info">Total Transactions</p>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="row h-100 col-8 ms-3">
                    <div class="col-md-12 col-xl-12">

                        <div class="card pb-3 mb-3" style="border-radius: 15px;">
                            <p class="h1 fw-bold mx-1 mx-md-4 mt-4 text-info text-decoration-underline" style="filter: drop-shadow(1px 2px 3px black);">User Details</p>

                            <div class="card-body">
                                <div class="row">
                                    <div class="col-xl-4 col-lg-6 col-sm-12">
                                        <p class="h5 fw-light">
                                            Email
                                            <i class="fas fa-envelope fa-fw"></i>
                                        </p>
                                        <p class="h5 fw-bold text-warning">
                                            ${vpAccd.getEmail()}
                                        </p>
                                    </div>
                                    <div class="col-xl-4 col-lg-6 col-sm-12">
                                        <p class="h5 fw-light">
                                            Name
                                            <i class="far fa-user fa-fw"></i>
                                        </p>
                                        <p class="h5 fw-bold text-warning">
                                            ${vpAccd.getName()}
                                        </p>
                                    </div>
                                    <div class="col-xl-4 col-lg-6 col-sm-12">
                                        <p class="h5 fw-light">
                                            Status
                                            <i class="fas fa-clipboard-check fa-fw"></i>
                                        </p>
                                        <p class="h5 fw-bold text-warning">
                                            ${vpAccd.getStatus()}
                                        </p>
                                    </div>
                                    <div class="col-xl-12 col-lg-12 col-sm-12 mt-3">
                                        <p class="h5 fw-light">
                                            Address
                                            <i class="fas fa-location-dot fa-fw"></i>
                                        </p>
                                        <p class="h5 fw-bold text-warning">
                                            ${vpAccd.getAddress()}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <c:if test="${vpRole eq 'customer' && vpTrans.size() != 0}">
                            <div class="card pb-3" style="border-radius: 15px;">
                                <p class="h1 fw-bold mx-1 mx-md-4 mt-4 text-info text-decoration-underline" style="filter: drop-shadow(1px 2px 3px black);">
                                    Recently Bought Items
                                </p>

                                <div class="card-body">
                                    <div class="row">
                                        <c:forEach var="trans" items="${vpTrans}" varStatus="loop">
                                            <c:if test="${loop.index >= (vpTrans.size()-3)}">
                                                <div class="card mb-2">
                                                    <div class="row py-4 justify-content-center">
                                                        <div class="col-2 d-flex justify-content-center align-items-center">
                                                            <img src="${trans.getItem().getImgUrl()}" class="rounded-circle" style="height: 100px; width: 100px;">
                                                        </div>
                                                        <div class="col-10">
                                                            <p class="h4 text-warning">${trans.getItem().getName()}</p>
                                                            <div class="row">
                                                                <div class="col-6">
                                                                    <p class="h6">Quantity Available: 
                                                                        <span class="text-danger">${trans.getItem().getAvailableQuantity()}</span>
                                                                    </p>
                                                                </div>
                                                                <div class="col-6">
                                                                    <p class="h6">Quantity Purchased: 
                                                                        <span class="text-danger">${trans.getItemQuantity()}</span>
                                                                    </p>
                                                                </div>
                                                                <div class="col-6">
                                                                    <p class="h6">
                                                                        Item Ratings: 
                                                                        <span class="text-danger">
                                                                            <fmt:formatNumber type="number" value="${trans.getItem().getRatings()} " minFractionDigits="2" maxFractionDigits="2" />
                                                                            <i class="fas fa-star fa-fw"></i>
                                                                        </span>
                                                                    </p>
                                                                </div>
                                                                <div class="col-6">
                                                                    <p class="h6">
                                                                        Unit Price: 
                                                                        <span class="text-danger">
                                                                            RM<fmt:formatNumber type="number" value="${trans.getItem().getUnitPrice()} " minFractionDigits="2" maxFractionDigits="2" />
                                                                        </span>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${vpRole eq 'seller' && vpTrans.size() != 0}">
                            <div class="card pb-3" style="border-radius: 15px;">
                                <p class="h1 fw-bold mx-1 mx-md-4 mt-4 text-info text-decoration-underline" style="filter: drop-shadow(1px 2px 3px black);">
                                    Recently Sold Items
                                </p>

                                <div class="row">
                                    <div class="card-body">
                                        <c:forEach var="trans" items="${vpTrans}" varStatus="loop">
                                            <c:if test="${loop.index >= (vpTrans.size()-3)}">
                                                <div class="card mb-2">
                                                    <div class="row py-4 justify-content-center">
                                                        <div class="col-2 d-flex justify-content-center align-items-center">
                                                            <img src="${trans.getItem().getImgUrl()}" class="rounded-circle" style="height: 100px; width: 100px;">
                                                        </div>
                                                        <div class="col-10">
                                                            <p class="h4 text-warning">${trans.getItem().getName()}</p>
                                                            <div class="row">
                                                                <div class="col-6">
                                                                    <p class="h6">Quantity Available: 
                                                                        <span class="text-danger">${trans.getItem().getAvailableQuantity()}</span>
                                                                    </p>
                                                                </div>
                                                                <div class="col-6">
                                                                    <p class="h6">Quantity Purchased: 
                                                                        <span class="text-danger">${trans.getItemQuantity()}</span>
                                                                    </p>
                                                                </div>
                                                                <div class="col-6">
                                                                    <p class="h6">
                                                                        Item Ratings: 
                                                                        <span class="text-danger">
                                                                            <fmt:formatNumber type="number" value="${trans.getItem().getRatings()} " minFractionDigits="2" maxFractionDigits="2" />
                                                                            <i class="fas fa-star fa-fw"></i>
                                                                        </span>
                                                                    </p>
                                                                </div>
                                                                <div class="col-6">
                                                                    <p class="h6">
                                                                        Unit Price: 
                                                                        <span class="text-danger">
                                                                            RM<fmt:formatNumber type="number" value="${trans.getItem().getUnitPrice()} " minFractionDigits="2" maxFractionDigits="2" />
                                                                        </span>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>  
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${(vpRole eq 'customer' && vpTrans.size() == 0) or (vpRole eq 'seller' && vpTrans.size() == 0)}">
                            <div class="card pb-3" style="border-radius: 15px;">
                                <c:if test="${vpRole eq 'customer' && vpTrans.size() == 0}">
                                    <p class="h1 fw-bold mx-1 mx-md-4 mt-4 text-info text-decoration-underline" style="filter: drop-shadow(1px 2px 3px black);">
                                        Recently Bought Items
                                    </p>
                                </c:if>
                                <c:if test="${vpRole eq 'seller' && vpTrans.size() == 0}">
                                    <p class="h1 fw-bold mx-1 mx-md-4 mt-4 text-info text-decoration-underline" style="filter: drop-shadow(1px 2px 3px black);">
                                        Recently Sold Items
                                    </p>
                                </c:if>
                                <div class="d-flex justify-content-center align-items-center text-center text-white flex-column card-body">
                                    <p class="h5">No Transactions Yet...</p>
                                    <img src="https://media.tenor.com/o6_Suc3YJq4AAAAM/no-money-please.gif" style="width: 125px; height: 125px; border-radius: 50%;"/>
                                </div>
                            </div>
                        </c:if>

                    </div>
                </div>
            </div>
        </section>

        <jsp:include page="../shared/backtotop.jsp" />
        <jsp:include page="../shared/music-player.jsp" />
        <jsp:include page="../nav/footer.jsp" />
    </body>
</html>
<style>
    .bg {
        background-image: url("https://cdnb.artstation.com/p/assets/images/images/015/934/209/large/karn-rerkkriangkrai-asset.jpg?1550235532");
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

    .card {
        background: rgb(255, 255, 255, 0.1);
        backdrop-filter: blur(3px);
    }

    .card-body {
        border-radius: 15px;
        filter: drop-shadow(1px 2px 3px black);
        color: #fff !important;
    }
</style>

<%-- 
    Document   : seller-home-content
    Created on : Apr 8, 2023, 10:05:46 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="today" value="<%=new java.util.Date()%>" />
<c:set var="formattedDate">
    <fmt:formatDate value="${today}" pattern="dd/MM/yyyy" />
</c:set>
<c:set var="transactionCounter" value="0" />
<c:set var="leastAvailableItem" value="${null}" />
<c:set var="leastAvailableQuantity" value="${Integer.MAX_VALUE}" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Seller Home Content</title>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.css" rel="stylesheet"/>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
        <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    </head>
    <body>
        <section class="h-100 bg py-4">
            <div class="container vh-100 pt-4" style="position: relative; z-index: 2;">
                <div class="row" style="filter: drop-shadow(1px 2px 3px black);">
                    <div class="col-12">
                        <div class="row mb-4">
                            <div class="col">
                                <div class="card">
                                    <img class="bg-image card-img" src="https://pbs.twimg.com/media/FOxjxAIXMAc0O6C.jpg">
                                    <div class="card-description d-flex flex-column p-2 text-white text-center 
                                         justify-content-end align-items-center w-100">
                                        <h1 class="w-100 text-danger" style="font-size: 60px;">
                                            <c:forEach var="trans" items="${sessionScope.trans}">
                                                <c:if test="${fn:startsWith(transaction.date, formattedDate)}">
                                                    <c:set var="transactionCounter" value="${transactionCounter+1}" />
                                                </c:if>
                                            </c:forEach>
                                            ${transactionCounter}
                                        </h1>
                                        <h6 class="mb-3 text-info fst-italic">Today's Total Transaction</h6>
                                        <div class="row d-flex justify-space-between w-100">
                                            <h3 title="transactions"><i class="fas fa-money-bill-wave fa-fw text-success"></i></h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="card">
                                    <img class="bg-image card-img" src="https://i.pinimg.com/originals/0f/f9/1e/0ff91e519e39e255074fc27c2a3eda97.jpg">
                                    <div class="card-description d-flex flex-column p-2 text-white text-center w-100">
                                        <div class="h4 mb-4">
                                            <span class="fw-bold">1 Star</span>
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: ${onestar}%;"></div>
                                            </div>

                                        </div>
                                        <div class="h4 mb-4">
                                            <span class="fw-bold">2 Stars</span>
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: ${twostar}%;"></div>
                                            </div>
                                        </div>
                                        <div class="h4 mb-4">
                                            <span class="fw-bold">3 Stars</span>
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: ${threestar}%;"></div>
                                            </div>
                                        </div>
                                        <div class="h4 mb-4">
                                            <span class="fw-bold">4 Stars</span>
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: ${fourstar}%;"></div>
                                            </div>
                                        </div>
                                        <div class="h4 mb-4">
                                            <span class="fw-bold">5 Stars</span>
                                            <div class="progress mt-1">
                                                <div class="progress-bar" role="progressbar" style="width: ${fivestar}%;"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="card ">
                                    <img class="bg-image card-img" src="${pageContext.request.contextPath}/shared/customer-pic.png">
                                    <div class="card-description d-flex flex-column p-2 text-white text-center 
                                         justify-content-end align-items-center w-100">
                                        <h1 class="w-100 text-danger" style="font-size: 40px;">${sessionScope.bestCustomer.getName()}</h1>
                                        <h6 class="mb-3 text-info fst-italic">Best Customer</h6>
                                        <div class="row d-flex justify-space-between w-100">
                                            <div class="col">
                                                <h3>${sessionScope.bestCustomer.getRatings()}</h3>
                                                <h3 title="ratings"><i class="fas fa-star fa-fw text-warning"></i></h3>
                                            </div>
                                            <div class="col">
                                                <h3>${sessionScope.bestCustomer.getTransactionList().size()}</h3>
                                                <h3 title="transactions"><i class="fas fa-money-bill-wave fa-fw text-success"></i></h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="card">
                                    <c:forEach var="item" items="${sessionScope.itemList}">
                                        <c:if test="${item.getAvailableQuantity() < leastAvailableQuantity}">
                                            <c:set var="leastAvailableItem" value="${item}" />
                                            <c:set var="leastAvailableQuantity" value="${item.getAvailableQuantity()}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${not empty sessionScope.itemList}">
                                        <img class="bg-image card-img" src="${leastAvailableItem.getImgUrl()}">
                                        <div class="card-description d-flex flex-column p-2 text-white text-center 
                                             justify-content-end align-items-center w-100">
                                            <h1 class="w-100 text-danger" style="font-size: 40px;">
                                                ${leastAvailableItem.getName()}
                                            </h1>
                                            <h6 class="mb-3 text-info fst-italic">My Best Selling Item</h6>
                                            <div class="row d-flex justify-space-between w-100">
                                                <div class="col">
                                                    <h3>${leastAvailableItem.getRatings()}</h3>
                                                    <h3 title="ratings"><i class="fas fa-star fa-fw text-warning"></i></h3>
                                                </div>
                                                <div class="col">
                                                    <h3>${leastAvailableItem.getTransactions().size()}</h3>
                                                    <h3 title="transactions"><i class="fas fa-money-bill-wave fa-fw text-success"></i></h3>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${empty sessionScope.itemList}">
                                        <img class="bg-image card-img" src="https://wompampsupport.azureedge.net/fetchimage?siteId=7575&v=2&jpgQuality=100&width=700&url=https%3A%2F%2Fi.ytimg.com%2Fvi%2FgxnbE5BMOTY%2Fhqdefault.jpg">
                                        <div class="card-description d-flex flex-column p-2 text-white text-center 
                                             justify-content-end align-items-center w-100">
                                            <h1 class="w-100 text-danger" style="font-size: 40px;">
                                                You got no Items <br> on the Market!
                                            </h1>
                                            <a class="btn btn-primary mb-4 p-3" href="${pageContext.request.contextPath}/seller/add-items.jsp" style="font-size: 16px;">
                                                Add New Items! 
                                            </a>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>
<style>
    .bg {
        background-image: url("https://i.ytimg.com/vi/31HfP81oWDI/maxresdefault.jpg");
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
        border-radius: 15px !important;
        transition: 0.4s ease-out;
    }

    .card:hover {
        transform: translateY(20px);   
    }

    .card:hover:after {
        opacity: 1;
    }

    .card:hover .card-description {
        opacity: 1;
        transform: translateY(0px);
    }

    .card:after {
        display: block;
        content: '';
        position: absolute;
        left: 0px;
        top: 0px;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        border-radius: 15px;
        transition: 0.5s;
        opacity: 0;
    }

    .card-img {
        border-radius: 15px !important;
        height: 400px;
        background-position: center;
        object-fit: cover;
        object-position: top;
        background-attachment: fixed;
    }

    .card-description {
        opacity: 0;
        position: absolute;
        bottom: 0;
        height: 100%;
        width: 100%;
        z-index: 3;
        transform: translateY(30px);
        transition: 0.5s;
        text-shadow: 1px 2px 3px black;
    }

    .progress {
        height: 15px;
        border-radius: 20px;
        filter: drop-shadow(1px 2px 3px black);
    }

    .progress-bar {
        background: yellow !important;
    }
</style>

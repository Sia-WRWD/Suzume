<%-- 
    Document   : admin-home-content
    Created on : Apr 8, 2023, 10:10:43 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Home Content</title>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.css" rel="stylesheet"/>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>
        <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    </head>
    <body>
        <section class="h-100 bg py-4">
            <div class="container vh-100 pt-4" style="position: relative; z-index: 2;">
                <div class="row" style="filter: drop-shadow(1px 2px 3px black);">
                    <div class="col-8">
                        <div class="row mb-4">
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
                                    <img class="bg-image card-img" src="https://attackofthefanboy.com/wp-content/uploads/2022/12/Makima.jpg">
                                    <div class="card-description d-flex flex-column p-2 text-white text-center 
                                         justify-content-end align-items-center w-100">
                                        <h1 class="w-100 text-danger" style="font-size: 40px;">${sessionScope.bestSeller.getShopName()}</h1>
                                        <h6 class="mb-3 text-info fst-italic">Best Seller</h6>
                                        <div class="row d-flex justify-space-between w-100">
                                            <div class="col">
                                                <h3>${sessionScope.bestSeller.getRatings()}</h3>
                                                <h3 title="ratings"><i class="fas fa-star fa-fw text-warning"></i></h3>
                                            </div>
                                            <div class="col">
                                                <h3>${sessionScope.bestSeller.getTransactionList().size()}</h3>
                                                <h3 title="transactions"><i class="fas fa-money-bill-wave fa-fw text-success"></i></h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="card">
                                    <img class="bg-image card-img" src="${sessionScope.bestItem.getImgUrl()}">
                                    <div class="card-description d-flex flex-column p-2 text-white text-center 
                                         justify-content-end align-items-center w-100">
                                        <h1 class="w-100 text-danger" style="font-size: 40px;">${sessionScope.bestItem.getName()}</h1>
                                        <h6 class="mb-3 text-info fst-italic">Best Item</h6>
                                        <div class="row d-flex justify-space-between w-100">
                                            <div class="col">
                                                <h3>${sessionScope.bestItem.getRatings()}</h3>
                                                <h3 title="ratings"><i class="fas fa-star fa-fw text-warning"></i></h3>
                                            </div>
                                            <div class="col">
                                                <h3>${sessionScope.bestItem.getTransactions().size()}</h3>
                                                <h3 title="transactions"><i class="fas fa-money-bill-wave fa-fw text-success"></i></h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <a class="btn btn-primary btn-block p-4 mb-3" style="font-size: 20px; text-shadow: 1px 2px 3px black;" 
                           href="${pageContext.request.contextPath}/admin/sales-summary.jsp">
                            Generate Sales Summary Report
                        </a>
                        <a class="btn btn-primary btn-block p-4" style="font-size: 20px; text-shadow: 1px 2px 3px black;" 
                           href="${pageContext.request.contextPath}/admin/user-summary.jsp">
                            Generate User Summary Report
                        </a>
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
</style>

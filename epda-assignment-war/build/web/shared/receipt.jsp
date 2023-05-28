<%-- 
    Document   : receipt
    Created on : Apr 7, 2023, 12:33:27 AM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="firstTrans" value="${null}" />
<c:forEach var="trans" items="${sessionScope.trans}">
    <c:if test="${trans.transactionIdentifier eq param.id}">
        <c:if test="${firstTrans eq null}">
            <c:set var="firstTrans" value="${trans}" />
        </c:if>
    </c:if>
</c:forEach>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transaction Receipt</title>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.css" rel="stylesheet"/>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>
        <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js" 
                integrity="sha512-GsLlZN/3F2ErC5ifS5QtgpiJtWd43JWSuIgh7mbzZ8zBps+dvLusV+eNQATqgA/HdeKFVgA5v3S/cIrLF7QnIg==" 
                crossorigin="anonymous" referrerpolicy="no-referrer">
        </script>
    </head>
    <body>
        <c:if test="${empty sessionScope.uname}">
            <%
                response.sendRedirect("/epda-assignment-war/authentication/login.jsp");
            %>
        </c:if>

        <section class="h-100 bg py-4">
            <div class="container d-flex align-items-center justify-content-center vh-100" style="position: relative; z-index: 2;">

                <div class="row w-100">
                    <div class="col">
                        <div class="d-flex flex-row mb-4">
                            <div class="btn btn-danger me-3" style="width:fit-content; height: fit-content;">
                                <a href="${pageContext.request.contextPath}/shared/manage-transaction.jsp" style="color: white; font-size: 1rem;">
                                    <i class="fa fa-arrow-left fa-fw"></i>
                                </a>
                            </div>
                            <div class="btn btn-info h-100" style="width:fit-content; height: fit-content;" title="Download Receipt">
                                <button class="text-white" onclick="generatePDF()" style="border: 2px solid transparent; background: transparent;">
                                    <i class="fas fa-download fa-fw"></i>
                                </button>
                            </div>
                        </div>

                        <div class="card h-100" id="toGenerate">
                            <div class="w-100 h-100 d-flex justify-content-center align-items-center">
                                <img src="${pageContext.request.contextPath}/watermark.png" class="watermark">
                            </div>
                            <div class="card-body d-flex justify-content-center align-items-center w-100 h-100">
                                <div class="container d-flex flex-column h-100 justify-content-center">
                                    <div class="row align-items-center">
                                        <p class="my-4 col fw-bold" style="font-size: 30px; text-decoration: underline;">Thank You for Your Purchase</p>
                                        <img class="col-3" src="${pageContext.request.contextPath}/logo.png" style="height: 50px; width: 250px;">
                                    </div>
                                    <div class="d-flex flex-row justify-space-between">
                                        <ul class="list-unstyled mb-0 me-5">
                                            <li class="text-muted mt-1">
                                                <span class="text-black fw-bold">Receipt ID: </span> 
                                                #${param.id}
                                            </li>
                                            <li class="text-muted mt-1">
                                                <span class="text-black fw-bold">Shop(s) Name: </span> 
                                                <c:forEach var="trans" items="${sessionScope.trans}">
                                                    <c:if test="${trans.transactionIdentifier eq param.id}">
                                                        ${trans.getSeller().getShopName()}
                                                    </c:if>
                                                </c:forEach>
                                            </li>
                                            <li class="text-muted mt-1">
                                                <span class="text-black fw-bold">Delivered From: </span><br>
                                                <c:forEach var="trans" items="${sessionScope.trans}">
                                                    <c:if test="${trans.transactionIdentifier eq param.id}">
                                                        ${trans.getSeller().getAddress()}<br>
                                                    </c:if>
                                                </c:forEach>
                                            </li>
                                        </ul>
                                        <ul class="list-unstyled mb-0 ms-5">
                                            <li class="text-muted mt-1">
                                                <span class="text-black fw-bold">Date: </span> 
                                                ${firstTrans.date}
                                            </li>
                                            <li class="text-muted mt-1">
                                                <span class="text-black fw-bold">Customer: </span> 
                                                ${firstTrans.getCustomer().getName()}
                                            </li>
                                            <li class="text-muted mt-1">
                                                <span class="text-black fw-bold">Delivered To: </span><br>
                                                ${firstTrans.getCustomer().getAddress()}
                                            </li>
                                        </ul>
                                    </div>
                                    <hr>
                                    <c:forEach var="trans" items="${sessionScope.trans}">
                                        <c:if test="${trans.transactionIdentifier eq param.id}">
                                            <div class="row">
                                                <div class="col-xl-8 fw-bold">
                                                    <p>${trans.getItem().getName()}</p>
                                                </div>
                                                <div class="col-xl-2 fw-bold">
                                                    <p>x${trans.getItemQuantity()}</p>
                                                </div>
                                                <div class="col-xl-2">
                                                    <p class="float-end">
                                                        RM <fmt:formatNumber type="number" value="${trans.getItem().getUnitPrice() * trans.getItemQuantity()}" 
                                                                          minFractionDigits="2" maxFractionDigits="2" /> 
                                                    </p>
                                                </div>
                                                <hr>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                    <div class="row text-black">
                                        <hr style="border: 2px solid black;">
                                        <div class="col-xl-12">
                                            <p class="float-end fw-bold">Total: RM <fmt:formatNumber type="number" value="${firstTrans.wholeTransactionTotal}" minFractionDigits="2" maxFractionDigits="2" /> </p>
                                        </div>
                                        <hr style="border: 2px solid black;">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
                                        
        <jsp:include page="../shared/music-player.jsp" />
        
        <script>
            function generatePDF() {
                var element = document.getElementById('toGenerate');
                var opt = {
                    margin: 1,
                    filename: 'receipt.pdf',
                    image: {type: 'jpeg', quality: 0.98},
                    html2canvas: {scale: 2},
                    jsPDF: {unit: 'in', format: 'letter', orientation: 'landscape'}
                };
                html2pdf().set(opt).from(element).save();
            }

            function getFirstTransaction() {
            <c:forEach var="trans" items="${sessionScope.trans}" varStatus="loopStatus">
                <c:if test="${trans.transactionIdentifier eq param.id}">
<!-- Code to display transaction information here -->
                </c:if>
                <c:if test="${loopStatus.first}">
<!-- Code to execute only on the first iteration here -->
                </c:if>
            </c:forEach>
            }
        </script>
    </body>
</html>
<style>
    .bg {
        background-image: url("https://cdn.donmai.us/original/d3/d7/d3d79e97677154daa413a5c6fac90c6b.png");
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

    .watermark {
        position: relative;
        opacity: 0.5;
    }

    .card-body {
        position: absolute;
    }
</style>

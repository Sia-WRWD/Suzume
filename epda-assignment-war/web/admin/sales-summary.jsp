<%-- 
    Document   : sales-summary
    Created on : Apr 9, 2023, 11:54:45 AM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sales Summary Report</title>
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
        <c:if test="${not empty sessionScope.uname && sessionScope.role ne 'admin'}">
            <%
                response.sendRedirect("/epda-assignment-war/home.jsp");
            %>
        </c:if>
        <section class="h-100 bg py-4">
            <div class="container d-flex align-items-center justify-content-center vh-100" style="position: relative; z-index: 2;">

                <div class="row w-100">
                    <div class="col">
                        <div class="d-flex flex-row mb-4">
                            <div class="btn btn-danger me-3" style="width:fit-content; height: fit-content;">
                                <a href="${pageContext.request.contextPath}/home.jsp" style="color: white; font-size: 1rem;">
                                    <i class="fa fa-arrow-left fa-fw"></i>
                                </a>
                            </div>
                            <div class="btn btn-info h-100" style="width:fit-content; height: fit-content;" title="Download Receipt">
                                <button class="text-white" onclick="generatePDF()" style="border: 2px solid transparent; background: transparent;">
                                    <i class="fas fa-download fa-fw"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card" id="toGenerate">
                            <div class="w-100 h-100 d-flex justify-content-center align-items-center">
                                <img src="${pageContext.request.contextPath}/watermark.png" class="watermark">
                            </div>
                            <div class="card-body d-flex justify-content-center align-items-center w-100 h-100">
                                <div class="container" style="text-shadow: 1px 2px 3px black;">
                                    <div class="row align-items-center">
                                        <p class="my-4 col fw-bold text-primary" style="font-size: 40px; text-decoration: underline;">Sales Summary</p>
                                    </div>
                                    <div class="row mb-4 border p-4">
                                        <div class="col text-center">
                                            <h1 class="text-danger">${sessionScope.trans.size()}</h1>
                                            <h3 class="text-warning" style="text-shadow: 1px 2px 3px black;">Total Transactions</h3>
                                            <i class="fas fa-money-bill-wave fa-fw text-success" style="font-size: 60px; filter: drop-shadow(1px 2px 3px black);"></i>
                                        </div>
                                        <div class="col text-center">
                                            <h1 class="text-success">${sessionScope.itemList.size()}</h1>
                                            <h3 class="text-danger" style="text-shadow: 1px 2px 3px black;">Total Items</h3>
                                            <i class="fas fa-gifts fa-fw text-warning" style="font-size: 60px; filter: drop-shadow(1px 2px 3px black);"></i>
                                        </div>
                                        <div class="col text-center">
                                            <h1 class="text-warning">${sessionScope.bestItem.getTransactions().size()}</h1>
                                            <h3 class="text-success" style="text-shadow: 1px 2px 3px black;">${sessionScope.bestItem.getName()}</h3>
                                            <i class="fas fa-gift fa-fw text-danger" style="font-size: 60px; filter: drop-shadow(1px 2px 3px black);"></i>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-end">
                                        <img class="col-3" src="${pageContext.request.contextPath}/logo.png" style="height: 50px; width: 250px;">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>

        <jsp:include page="../shared/music-player.jsp" />

        <script type="text/javascript">
            function generatePDF() {
                var element = document.getElementById('toGenerate');
                var opt = {
                    margin: 1,
                    filename: 'sales-summary-report.pdf',
                    image: {type: 'jpeg', quality: 0.98},
                    html2canvas: {scale: 2},
                    jsPDF: {unit: 'in', format: 'letter', orientation: 'landscape'}
                };
                html2pdf().set(opt).from(element).save();
            }
        </script>
    </body>
</html>
<style>
    .bg {
        background-image: url("https://images4.alphacoders.com/123/123194.jpg");
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

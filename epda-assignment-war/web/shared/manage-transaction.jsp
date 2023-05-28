<%-- 
    Document   : manage-transaction
    Created on : Apr 7, 2023, 3:25:24 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Transaction</title>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.css" rel="stylesheet"/>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>
        <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    </head>
    <body>
        <c:if test="${empty sessionScope.uname}">
            <%-- Redirect the user to the login page --%>
            <%
                response.sendRedirect("/epda-assignment-war/authentication/login.jsp");
            %>
        </c:if>

        <jsp:include page="../nav/banner.jsp" />

        <section class="vh-100 bg py-4">
            <div class="container h-100 pt-4" style="position: relative; z-index: 2;">
                <c:if test="${not empty sessionScope.trans}">
                    <div class="form-outline mb-4">
                        <input type="text" class="form-control text-white" id="search-input" />
                        <label class="form-label text-white" for="datatable-search-input">Search</label>
                    </div>

                    <table class="table align-middle mb-0 bg-white">
                        <thead>
                            <tr>
                                <th style="width: 15%;">Date</th>
                                <th style="width: 20%;">Item Name</th>
                                <th style="width: 5%;">Quantity</th>
                                <th style="width: 15%;">Single Total</th>
                                <th style="width: 15%;">Whole Total </th>
                                    <c:if test="${sessionScope.role eq 'customer'}">
                                    <th style="width: 15%;">Seller</th>
                                    <th style="width: 15%;">Method</th>
                                    </c:if>
                                    <c:if test="${sessionScope.role eq 'seller'}">
                                    <th style="width: 15%;">Customer</th>
                                    </c:if>
                                <th style="width: 15%;">
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="trans" items="${sessionScope.trans}">
                                <tr>
                                    <td>
                                        ${trans.date}
                                    </td>
                                    <td>
                                        ${trans.item.getName()}
                                    </td>
                                    <td>
                                        ${trans.itemQuantity}
                                    </td>
                                    <td>
                                        RM <fmt:formatNumber type="number" value="${trans.individualTransactionTotal}" minFractionDigits="2" maxFractionDigits="2" />
                                    </td>
                                    <td>
                                        RM <fmt:formatNumber type="number" value="${trans.wholeTransactionTotal}" minFractionDigits="2" maxFractionDigits="2" />
                                    </td>
                                    <c:if test="${sessionScope.role eq 'customer'}">
                                        <td>
                                            <a href="${pageContext.request.contextPath}/GetViewProfileDetails?accountId=${trans.seller.getId()}&role=seller&loca=manageTransaction" class="text-white link-hover">
                                                ${trans.seller.getShopName()}
                                            </a>
                                        </td>
                                        <td>Paid using ${trans.ccType} card <br> ending with -${trans.ccRefDigits}</td>
                                        </c:if>
                                        <c:if test="${sessionScope.role eq 'seller'}">
                                        <td>
                                            <a href="${pageContext.request.contextPath}/GetViewProfileDetails?accountId=${trans.customer.getId()}&role=customer&loca=manageTransaction" class="text-white link-hover">
                                                ${trans.customer.getName()}
                                            </a>
                                        </td>
                                    </c:if>
                                    <td class="d-flex justify-content-center">
                                        <a type="button" class="btn btn-danger btn-rounded me-1 d-flex justify-content-center align-items-center" title="My Reviews" 
                                           href="${pageContext.request.contextPath}/shared/review.jsp?id=${trans.id}">
                                            <i class="far fa-comments fa-fw"></i>
                                        </a>
                                        <c:if test="${sessionScope.role eq 'seller' && trans.sellerCollectionStatus eq 'Pending'}">
                                            <form method="POST" action="${pageContext.request.contextPath}/ManageTransaction">
                                                <input type="hidden" name="ops" value="collection">
                                                <input type="hidden" name="transactionId" value="${trans.id}">
                                                <button type="submit" class="btn btn-warning btn-rounded me-1 d-flex justify-content-center align-items-center" title="Collect Payment">
                                                    <i class="fas fa-vault fa-fw"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                        <a type="button" class="btn btn-info btn-rounded d-flex justify-content-center align-items-center" title="View Receipt"
                                           href="${pageContext.request.contextPath}/shared/receipt.jsp?id=${trans.transactionIdentifier}">
                                            <i class="fas fa-file-invoice-dollar fa-fw"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty sessionScope.trans && sessionScope.role eq 'customer'}">
                    <div class="d-flex align-items-center justify-content-center flex-column h-100" style="filter: drop-shadow(1px 2px 3px black);">
                        <h2 class="text-warning fw-bold">Why is it Empty...?</h2>
                        <img class="rounded-circle mb-3" src="https://i.kym-cdn.com/photos/images/newsfeed/001/230/774/9b2.gif" alt="crying.jpg" style="height: 350px; width: 350px;">
                        <a class="btn btn-danger" href="${pageContext.request.contextPath}/market/all-items.jsp">
                            START SHOPPING NOW
                        </a>
                    </div>
                </c:if>
                <c:if test="${empty sessionScope.trans && sessionScope.role eq 'seller'}">
                    <div class="d-flex align-items-center justify-content-center flex-column h-100" style="filter: drop-shadow(1px 2px 3px black);">
                        <h2 class="text-warning fw-bold">PMA, sales will be coming soon!</h2>
                        <img class="rounded-circle mb-3" src="https://media.tenor.com/NSVzFE84-CQAAAAd/popcorn-anime.gif" alt="crying.jpg" style="height: 350px; width: 350px;">
                        <a class="btn btn-info" href="${pageContext.request.contextPath}/seller/add-items.jsp">
                            Add More Items?
                        </a>
                    </div>
                </c:if>
                <c:if test="${empty sessionScope.trans && sessionScope.role eq 'admin'}">
                    <div class="d-flex align-items-center justify-content-center flex-column h-100" style="filter: drop-shadow(1px 2px 3px black);">
                        <h2 class="text-warning fw-bold">OH MY GOD! NO SALES YET!?</h2>
                        <img class="rounded-circle mb-3" src="https://media.tenor.com/o6_Suc3YJq4AAAAM/no-money-please.gif" alt="crying.jpg" style="height: 350px; width: 350px;">
                    </div>
                </c:if>
            </div>
        </section>

        <jsp:include page="../shared/backtotop.jsp" />
        <jsp:include page="../shared/music-player.jsp" />
        <jsp:include page="../nav/footer.jsp" />

        <!-- Alert -->

        <c:if test="${not empty collectionSuccess}">
            <div class="alert alert-success" id="alert-success">
                ${collectionSuccess}
                <i class="fas fa-circle-check" style="font-size: 25px; margin-left: 10px;"></i>
            </div>
        </c:if>

        <c:if test="${not empty otherError}">
            <div class="alert alert-danger" id="alert-error">
                ${otherError}
                <i class="fas fa-circle-xmark" style="font-size: 25px; margin-left: 10px;"></i>
            </div>
        </c:if>

        <!-- Alert --> 

        <script type="text/javascript">
            //Search Functionality
            const searchInput = document.getElementById('search-input');
            const tableRows = document.getElementsByTagName('tr');

            searchInput.addEventListener('keyup', function () {
                const filter = searchInput.value.toUpperCase();
                for (let i = 1; i < tableRows.length; i++) {
                    const tableData = tableRows[i].getElementsByTagName('td');
                    let displayRow = false;
                    for (let j = 0; j < tableData.length; j++) {
                        const tableDataText = tableData[j].textContent || tableData[j].innerText;
                        if (tableDataText.toUpperCase().indexOf(filter) > -1) {
                            displayRow = true;
                            break;
                        }
                    }
                    if (displayRow) {
                        tableRows[i].style.display = '';
                    } else {
                        tableRows[i].style.display = 'none';
                    }
                }
            });

            // Hide the alert after 3 seconds
            setTimeout(function () {
                var successAlert = document.getElementById("alert-success");
                var errorAlert = document.getElementById("alert-error");
                if (successAlert) {
                    successAlert.style.display = "none";
                } else if (errorAlert) {
                    errorAlert.style.display = "none";
                }
            }, 3000);
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

    .bg {
        background-image: url("https://i.kym-cdn.com/entries/icons/original/000/029/313/1322.jpg");
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

    .btn {
        height: 100%;
    }

    .table {
        background: rgba(255, 255, 255, 0.1) !important;
        color: #fff !important;
        backdrop-filter: blur(3px);
        filter: drop-shadow(1px 2px 3px black);
        height: 875px;
        display: block;
        width: 100%;
        table-layout: fixed;
        overflow-y: auto;
    }

    thead {
        background: rgba(255, 255, 255, 0.1) !important;
        color: white !important;
        backdrop-filter: blur(3px);
    }

    td {
        border-bottom-width: 0px !important;
        height: 75px;
    }

    tbody, td, tfoot, th, thead, tr {
        border: none !important;
    }

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

    #btn-add-item {
        position: fixed;
        bottom: 90px;
        right: 20px;
        border-radius: 50%;
        z-index: 4;
    }

    .form-outline .form-control {
        border: 1px solid #eee;
    }

    .form-label {
        z-index: 2;
    }

    .form-notch {
        display: none !important;
    }

    .link-hover:hover {
        text-decoration: underline;
        transition: 0.3s ease-in-out;
        color: #03A9F4 !important;
    }
</style>

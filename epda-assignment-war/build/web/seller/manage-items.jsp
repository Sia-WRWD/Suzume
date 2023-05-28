<%-- 
    Document   : manage-items
    Created on : Apr 3, 2023, 4:13:23 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All My Items</title>
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
            <%
                response.sendRedirect("/epda-assignment-war/authentication/login.jsp");
            %>
        </c:if>
        <c:if test="${not empty sessionScope.uname && (sessionScope.role ne 'seller' and sessionScope.role ne 'admin')}">
            <%
                response.sendRedirect("/epda-assignment-war/home.jsp");
            %>
        </c:if>
        <jsp:include page="../nav/banner.jsp" />

        <section class="vh-100 bg py-4">
            <div class="container h-100 pt-4" style="position: relative; z-index: 2;">
                <c:if test="${not empty sessionScope.itemList}">
                    <div class="form-outline mb-4">
                        <input type="text" class="form-control text-white" id="search-input" />
                        <label class="form-label text-white" for="datatable-search-input">Search</label>
                    </div>

                    <table class="table align-middle mb-0 bg-white" id="data-table">
                        <thead>
                            <tr>
                                <th style="width: 20%;">Item Name</th>
                                <th style="width: 10%;">Unit Price</th>
                                <th style="width: 15%;">Available Quantity</th>
                                <th style="width: 5%;">Rating</th>
                                <th style="width: 15%;">Category</th>
                                <th style="width: 15%;">Status</th>
                                    <c:if test="${sessionScope.role eq 'seller'}">
                                    <th style="width: 20%;">
                                        Actions
                                    </th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${sessionScope.itemList}">
                                <tr>
                                    <td>
                                        <p class="fw-normal mb-1">${item.name}</p>
                                    </td>
                                    <td>
                                        <p class="fw-normal mb-1">
                                            RM
                                            <fmt:formatNumber type="number" value="${item.unitPrice}" minFractionDigits="2" maxFractionDigits="2" />
                                        </p>
                                    </td>
                                    <td>
                                        <p class="fw-normal mb-1">
                                            ${item.availableQuantity}
                                        </p>
                                    </td>
                                    <td>
                                        <p class="fw-normal mb-1">
                                            <fmt:formatNumber type="number" value="${item.ratings}" minFractionDigits="2" maxFractionDigits="2" />
                                        </p>
                                    </td>
                                    <td>
                                        ${item.category}
                                    </td>
                                    <td>
                                        <c:if test="${item.status eq 'Available'}">
                                            <span class="badge badge-success rounded-pill d-inline">${item.status}</span>
                                        </c:if>
                                        <c:if test="${item.status eq 'Out of Stock'}">
                                            <span class="badge badge-danger rounded-pill d-inline">${item.status}</span>
                                        </c:if>
                                        <c:if test="${item.status eq 'Discontinued'}">
                                            <span class="badge badge-light rounded-pill d-inline">${item.status}</span>
                                        </c:if>
                                    </td>
                                    <c:if test="${sessionScope.role eq 'seller'}">
                                        <td class="d-flex justify-content-center">
                                            <a type="button" class="btn btn-primary btn-sm btn-rounded me-2 d-flex justify-content-center align-items-center" 
                                               href="${pageContext.request.contextPath}/seller/edit-item.jsp?id=${item.id}">
                                                <i class="far fa-pen-to-square fa-fw"></i>
                                            </a>
                                            <button type="button" class="btn btn-danger btn-sm btn-rounded deleteItem d-flex justify-content-center align-items-center"
                                                    data-mdb-toggle="modal" data-mdb-target="#deleteModal"
                                                    data-mdb-itemid="${item.id}" data-mdb-ops="delete">
                                                <i class="fas fa-trash-can fa-fw"></i>
                                            </button>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty sessionScope.itemList}">
                    <div class="d-flex align-items-center justify-content-center flex-column h-100" style="filter: drop-shadow(1px 2px 3px black);">
                        <h2 class="text-warning fw-bold">Woah! So Empty...</h2>
                        <img src="${pageContext.request.contextPath}/seller/intrigued.png" al="intrigued.jpg" style="height: 350px; width: 350px;">
                        <a class="btn btn-primary" href="${pageContext.request.contextPath}/seller/add-items.jsp">
                            ADD IT NOW
                        </a>
                    </div>
                </c:if>
            </div>
        </section>

        <!--Add Item Button-->
        <c:if test="${sessionScope.role eq 'seller'}">
            <a type="button" id="btn-add-item" 
               class="btn btn-primary btn-floating btn-lg"
               href="${pageContext.request.contextPath}/seller/add-items.jsp">
                <i class="fas fa-plus"></i>
            </a>
        </c:if>

        <!--Confirm Delete Modal-->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form method="POST" action="${pageContext.request.contextPath}/Item">
                        <div class="modal-header">
                            <h5 class="modal-title" id="deleteModalLabel">Delete Item?</h5>
                            <button type="button" class="btn-close" data-mdb-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p class="d-flex">
                                Are you sure you want to delete the item?
                            <p>
                                <input type="hidden" value="" id="modal-item-id" name="modal-item-id"/>
                                <input type="hidden" value="" id="modal-item-ops" name="operation"/>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-mdb-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-danger">Delete Item</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="../shared/backtotop.jsp" />
        <jsp:include page="../shared/music-player.jsp" />
        <jsp:include page="../nav/footer.jsp" />

        <!-- Alert -->

        <c:if test="${not empty itemDeleteSuccess or not empty editItemSuccess}">
            <div class="alert alert-success" id="alert-success">
                ${editItemSuccess}
                ${itemDeleteSuccess}
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
            window.onload = function () {
                const deleteButtons = document.querySelectorAll('.deleteItem');
                deleteButtons.forEach(button => {
                    button.addEventListener('click', function () {
                        const itemid = this.getAttribute('data-mdb-itemid');
                        const ops = this.getAttribute('data-mdb-ops');

                        const hiddenItemId = document.getElementById("modal-item-id");
                        const hiddenOps = document.getElementById("modal-item-ops");

                        hiddenItemId.value = itemid;
                        hiddenOps.value = ops;
                    });
                });
            };

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
    .bg {
        background-image: url("https://cdn.wallpapersafari.com/5/5/52YJo9.jpg");
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

    .table {
        display: block;
        background: rgba(255, 255, 255, 0.1) !important;
        color: #fff !important;
        backdrop-filter: blur(3px);
        filter: drop-shadow(1px 2px 3px black);
        height: 875px;
        overflow-y: auto;
        table-layout: fixed;
        width: 100%;
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
        bottom: 150px;
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
</style>

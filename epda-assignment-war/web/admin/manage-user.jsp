<%-- 
    Document   : manage-user
    Created on : Apr 8, 2023, 2:05:18 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Users</title>
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
        <c:if test="${not empty sessionScope.uname && sessionScope.role ne 'admin'}">
            <%
                response.sendRedirect("/epda-assignment-war/home.jsp");
            %>
        </c:if>

        <jsp:include page="../nav/banner.jsp" />

        <section class="vh-100 bg py-4">
            <div class="container h-100 pt-4 w-100" style="position: relative; z-index: 2;">
                <c:if test="${not empty sessionScope.userList}">
                    <div class="form-outline mb-4">
                        <input type="text" class="form-control text-white" id="search-input" />
                        <label class="form-label text-white" for="datatable-search-input">Search</label>
                    </div>

                    <table class="table align-middle mb-0 bg-white" id="data-table">
                        <thead>
                            <tr>
                                <th style="width: 20%;">Username</th>
                                <th style="width: 20%;">Roles</th>
                                <th style="width: 20%;">Status</th>
                                <th style="width: 20%;">Ratings</th>
                                <th style="width: 10%;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${sessionScope.userList}">
                                <tr>
                                    <td>
                                        <p class="fw-normal mb-1">${user.id}</p>
                                    </td>
                                    <td>
                                        <p class="fw-normal mb-1">
                                            ${user.role}
                                        </p>
                                    </td>
                                    <td>
                                        <c:if test="${user.role eq 'customer'}">
                                            <c:if test="${user.getCust().get(0).getStatus() eq 'Active'}">
                                                <span class="badge badge-success rounded-pill d-inline">
                                                    ${user.getCust().get(0).getStatus()}
                                                </span>
                                            </c:if>
                                            <c:if test="${user.getCust().get(0).getStatus() eq 'Deactivated'}">
                                                <span class="badge badge-danger rounded-pill d-inline">
                                                    ${user.getCust().get(0).getStatus()}
                                                </span>
                                            </c:if>
                                        </c:if>
                                        <c:if test="${user.role eq 'seller'}">
                                            <c:if test="${user.getSeller().get(0).getStatus() eq 'Active'}">
                                                <span class="badge badge-success rounded-pill d-inline">
                                                    ${user.getSeller().get(0).getStatus()}
                                                </span>
                                            </c:if>
                                            <c:if test="${user.getSeller().get(0).getStatus() eq 'Pending'}">
                                                <span class="badge badge-warning rounded-pill d-inline">
                                                    ${user.getSeller().get(0).getStatus()}
                                                </span>
                                            </c:if>
                                            <c:if test="${user.getSeller().get(0).getStatus() eq 'Deactivated'}">
                                                <span class="badge badge-danger rounded-pill d-inline">
                                                    ${user.getSeller().get(0).getStatus()}
                                                </span>
                                            </c:if>
                                        </c:if>
                                        <c:if test="${user.role eq 'admin'}">
                                            <c:if test="${user.getAdmin().get(0).getStatus() eq 'Active'}">
                                                <span class="badge badge-success rounded-pill d-inline">
                                                    ${user.getAdmin().get(0).getStatus()}
                                                </span>
                                            </c:if>
                                            <c:if test="${user.getAdmin().get(0).getStatus() eq 'Deactivated'}">
                                                <span class="badge badge-danger rounded-pill d-inline">
                                                    ${user.getAdmin().get(0).getStatus()}
                                                </span>
                                            </c:if>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${user.role eq 'customer'}">
                                            ${user.getCust().get(0).getRatings()}
                                        </c:if> 
                                        <c:if test="${user.role eq 'seller'}">
                                            ${user.getSeller().get(0).getRatings()}
                                        </c:if> 
                                        <c:if test="${user.role eq 'admin'}">
                                            over 9000
                                        </c:if> 
                                    </td>
                                    <td class="d-flex justify-content-center">
                                        <a type="button" class="btn btn-primary btn-sm btn-rounded me-2 d-flex justify-content-center align-items-center" title="Edit"
                                           href="${pageContext.request.contextPath}/admin/edit-user.jsp?id=${user.id}">
                                            <i class="far fa-pen-to-square fa-fw"></i>
                                        </a>
                                        <c:if test="${user.role eq 'seller' and user.getSeller().get(0).getStatus() eq 'Pending'}">
                                            <form method="POST" action="${pageContext.request.contextPath}/ManageUser">
                                                <input type="hidden" name="ops" value="approve">
                                                <input type="hidden" name="uname" value="${user.id}">
                                                <button type="submit" class="btn btn-success btn-sm btn-rounded me-2" title="Approve">
                                                    <i class="fas fa-clipboard-check fa-fw"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${user.role eq 'seller' and user.getSeller().get(0).getStatus() eq 'Active'}">
                                            <form method="POST" action="${pageContext.request.contextPath}/ManageUser">
                                                <input type="hidden" name="ops" value="deactivate">
                                                <input type="hidden" name="uname" value="${user.id}">
                                                <button type="submit" class="btn btn-warning btn-sm btn-rounded me-2" title="Deactivate">
                                                    <i class="fas fa-power-off fa-fw"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${user.role eq 'customer' and user.getCust().get(0).getStatus() eq 'Active'}">
                                            <form method="POST" action="${pageContext.request.contextPath}/ManageUser">
                                                <input type="hidden" name="ops" value="deactivate">
                                                <input type="hidden" name="uname" value="${user.id}">
                                                <button type="submit" class="btn btn-warning btn-sm btn-rounded me-2" title="Deactivate">
                                                    <i class="fas fa-power-off fa-fw"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${user.role eq 'admin' and user.getAdmin().get(0).getStatus() eq 'Active'}">
                                            <form method="POST" action="${pageContext.request.contextPath}/ManageUser">
                                                <input type="hidden" name="ops" value="deactivate">
                                                <input type="hidden" name="uname" value="${user.id}">
                                                <button type="submit" class="btn btn-warning btn-sm btn-rounded me-2" title="Deactivate">
                                                    <i class="fas fa-power-off fa-fw"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${user.role eq 'seller' and user.getSeller().get(0).getStatus() eq 'Deactivated'}">
                                            <form method="POST" action="${pageContext.request.contextPath}/ManageUser">
                                                <input type="hidden" name="ops" value="reactivate">
                                                <input type="hidden" name="uname" value="${user.id}">
                                                <button type="submit" class="btn btn-info btn-sm btn-rounded me-2" title="Reactivate">
                                                    <i class="fas fa-lock-open fa-fw"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${user.role eq 'customer' and user.getCust().get(0).getStatus() eq 'Deactivated'}">
                                            <form method="POST" action="${pageContext.request.contextPath}/ManageUser">
                                                <input type="hidden" name="ops" value="reactivate">
                                                <input type="hidden" name="uname" value="${user.id}">
                                                <button type="submit" class="btn btn-info btn-sm btn-rounded me-2" title="Reactivate">
                                                    <i class="fas fa-lock-open fa-fw"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${user.role eq 'admin' and user.getAdmin().get(0).getStatus() eq 'Deactivated'}">
                                            <form method="POST" action="${pageContext.request.contextPath}/ManageUser">
                                                <input type="hidden" name="ops" value="reactivate">
                                                <input type="hidden" name="uname" value="${user.id}">
                                                <button type="submit" class="btn btn-info btn-sm btn-rounded me-2" title="Reactivate">
                                                    <i class="fas fa-lock-open fa-fw"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty sessionScope.userList}">
                    <div class="d-flex align-items-center justify-content-center flex-column h-100" style="filter: drop-shadow(1px 2px 3px black);">
                        <h2 class="text-warning fw-bold">Where's Everybody...?</h2>
                        <img src="https://i.gifer.com/7VE.gif" alt="where.gif" style="height: 350px; width: 350px;">
                    </div>
                </c:if>
            </div>
        </section>

        <jsp:include page="../shared/backtotop.jsp" />
        <jsp:include page="../shared/music-player.jsp" />
        <jsp:include page="../nav/footer.jsp" />

        <!-- Alert -->

        <c:if test="${not empty approveSuccess or not empty deactivateSuccess or not empty reactivateSuccess
                      or not empty userEditSuccess}">
              <div class="alert alert-success" id="alert-success">
                  ${approveSuccess} ${deactivateSuccess} 
                  ${reactivateSuccess} ${userEditSuccess}
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
    .bg {
        background-image: url("https://imgix.ranker.com/user_node_img/3832/76625536/original/kirito-photo-u15?auto=format&q=60&fit=crop&fm=pjpg&dpr=2&w=375");
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
        display: block;
        background: rgba(255, 255, 255, 0.1) !important;
        color: #fff !important;
        backdrop-filter: blur(3px);
        filter: drop-shadow(1px 2px 3px black);
        height: 875px;
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

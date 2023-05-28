<%-- 
    Document   : edit-user
    Created on : Apr 8, 2023, 4:19:58 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit User</title>
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
        <c:if test="${not empty sessionScope.uname && sessionScope.role ne 'admin'}">
            <%
                response.sendRedirect("/epda-assignment-war/home.jsp");
            %>
        </c:if>

        <jsp:include page="../nav/banner.jsp" />

        <section class="h-100 bg py-4">
            <div class="container d-flex align-items-center justify-content-center vh-100" style="position: relative; z-index: 2;">
                <div class="row w-100">
                    <div class="col-lg-12 col-xl-11">
                        <div class="card card-bg text-white" style="border-radius: 25px;">
                            <div class="card-body p-md-5">
                                <div class="btn btn-danger" style="width:fit-content; height: fit-content;">
                                    <a href="${pageContext.request.contextPath}/admin/manage-user.jsp" style="color: white; font-size: 1rem;">
                                        <i class="fa fa-arrow-left"></i>
                                    </a>
                                </div>
                                <c:forEach var="user" items="${sessionScope.userList}">
                                    <c:if test="${user.id eq param.id && user.role eq 'seller'}">
                                        <div class="row justify-content-center">
                                            <div class="col-12">

                                                <p class="text-start h1 fw-bold mb-4 mx-1 mx-md-4 mt-4">Edit Seller</p>

                                                <form class="mx-1 mx-md-4" method="POST" action="${pageContext.request.contextPath}/ManageUser">
                                                    <div class="row">
                                                        <div class="d-flex flex-row align-items-center mb-4 col">
                                                            <i class="fas fa-shop fa-lg me-3 fa-fw"></i>
                                                            <div class="form-outline flex-fill mb-0">
                                                                <input type="text" id="selrShopName" class="form-control text-white" name="selrShopName" required 
                                                                       oninput="checkSellerInputs()" value="${user.getSeller().get(0).getShopName()}"/>
                                                                <label class="form-label text-white" for="selrShopName">Shop Name</label>
                                                            </div>
                                                        </div>
                                                        <div class="d-flex flex-row align-items-center mb-4 col">
                                                            <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                                                            <div class="form-outline flex-fill mb-0">
                                                                <input type="text" id="selrName" class="form-control text-white" name="selrName" required 
                                                                       oninput="checkSellerInputs()" value="${user.getSeller().get(0).getName()}"/>
                                                                <label class="form-label text-white" for="selrName">Name</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="d-flex flex-row align-items-center mb-4 col">
                                                            <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                                                            <div class="form-outline flex-fill mb-0">
                                                                <input type="email" id="selrEmail" class="form-control text-white" name="selrEmail" 
                                                                       oninput="checkSellerInputs()" required 
                                                                       value="${user.getSeller().get(0).getEmail()}"/>
                                                                <label class="form-label text-white" for="selrEmail">Email</label>
                                                            </div>
                                                        </div>
                                                        <div class="d-flex flex-row align-items-center mb-4 col">
                                                            <i class="fas fa-venus-mars fa-lg me-3 fa-fw"></i>
                                                            <div class="form-outline flex-fill mb-0">
                                                                <select class="form-control text-white" id="selrGender" onchange="checkSellerInputs()" name="selrGender">
                                                                    <option class="text-black" value="M">Male</option>
                                                                    <option class="text-black" value="F">Female</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="d-flex flex-row align-items-center mb-4 col">
                                                            <i class="fas fa-location-dot fa-lg me-3 fa-fw"></i>
                                                            <div class="form-outline flex-fill mb-0">
                                                                <input type="text" id="selrAddress" class="form-control text-white" name="selrAddress" 
                                                                       oninput="checkSellerInputs()" required 
                                                                       value="${user.getSeller().get(0).getAddress()}"/>
                                                                <label class="form-label text-white" for="selrAddress">Address</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="d-flex justify-content-end">
                                                        <input type="hidden" name="ops" value="edit">
                                                        <input type="hidden" name="uname" value="${param.id}">
                                                        <button type="submit" class="btn btn-primary p-3" id="selrSubmit" 
                                                                style="width: 160px; font-size: 14px;" disabled>
                                                            Submit
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </c:if>

                                    <c:if test="${user.id eq param.id && user.role eq 'customer'}">
                                        <div class="row justify-content-center">
                                            <div class="col-12">

                                                <p class="text-start h1 fw-bold mb-4 mx-1 mx-md-4 mt-4">Edit Customer</p>

                                                <form class="mx-1 mx-md-4" method="POST" action="${pageContext.request.contextPath}/ManageUser">
                                                    <div class="row">
                                                        <div class="d-flex flex-row align-items-center mb-4 col">
                                                            <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                                                            <div class="form-outline flex-fill mb-0">
                                                                <input type="text" id="custName" class="form-control text-white" name="custName" required 
                                                                       oninput="checkCustInputs()" value="${user.getCust().get(0).getName()}"/>
                                                                <label class="form-label text-white" for="custName">Name</label>
                                                            </div>
                                                        </div>
                                                        <div class="d-flex flex-row align-items-center mb-4 col">
                                                            <i class="fas fa-venus-mars fa-lg me-3 fa-fw"></i>
                                                            <div class="form-outline flex-fill mb-0">
                                                                <select class="form-control text-white" id="custGender" onchange="checkCustInputs()" name="custGender">
                                                                    <option class="text-black" value="M">Male</option>
                                                                    <option class="text-black" value="F">Female</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="d-flex flex-row align-items-center mb-4 col">
                                                            <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                                                            <div class="form-outline flex-fill mb-0">
                                                                <input type="email" id="custEmail" class="form-control text-white" name="custEmail" 
                                                                       oninput="checkCustInputs()" required 
                                                                       value="${user.getCust().get(0).getEmail()}"/>
                                                                <label class="form-label text-white" for="custEmail">Email</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="d-flex flex-row align-items-center mb-4 col">
                                                            <i class="fas fa-location-dot fa-lg me-3 fa-fw"></i>
                                                            <div class="form-outline flex-fill mb-0">
                                                                <input type="text" id="custAddress" class="form-control text-white" name="custAddress" 
                                                                       oninput="checkCustomerInputs()" required 
                                                                       value="${user.getCust().get(0).getAddress()}"/>
                                                                <label class="form-label text-white" for="custAddress">Address</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="d-flex justify-content-end">
                                                        <input type="hidden" name="ops" value="edit">
                                                        <input type="hidden" name="uname" value="${param.id}">
                                                        <button type="submit" class="btn btn-primary p-3" id="custSubmit" 
                                                                style="width: 160px; font-size: 14px;" disabled>
                                                            Submit
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </c:if>

                                    <c:if test="${user.id eq param.id && user.role eq 'admin'}">
                                        <div class="row justify-content-center">
                                            <div class="col-12">

                                                <p class="text-start h1 fw-bold mb-4 mx-1 mx-md-4 mt-4">Edit Admin</p>

                                                <form class="mx-1 mx-md-4" method="POST" action="${pageContext.request.contextPath}/ManageUser">
                                                    <div class="row">
                                                        <div class="d-flex flex-row align-items-center mb-4 col">
                                                            <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                                                            <div class="form-outline flex-fill mb-0">
                                                                <input type="text" id="admName" class="form-control text-white" name="admName" required 
                                                                       oninput="checkAdminInputs()" value="${user.getAdmin().get(0).getName()}"/>
                                                                <label class="form-label text-white" for="admName">Name</label>
                                                            </div>
                                                        </div>
                                                        <div class="d-flex flex-row align-items-center mb-4 col">
                                                            <i class="far fa-building fa-lg me-3 fa-fw"></i>
                                                            <div class="form-outline flex-fill mb-0">
                                                                <input type="text" id="admDept" class="form-control text-white" name="admDept" required 
                                                                       oninput="checkAdminInputs()" value="${user.getAdmin().get(0).getDepartment()}"/>
                                                                <label class="form-label text-white" for="admDept">Department</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="d-flex flex-row align-items-center mb-4 col">
                                                            <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                                                            <div class="form-outline flex-fill mb-0">
                                                                <input type="email" id="admEmail" class="form-control text-white" name="admEmail" 
                                                                       oninput="checkAdminInputs()" required 
                                                                       value="${user.getAdmin().get(0).getEmail()}"/>
                                                                <label class="form-label text-white" for="admEmail">Email</label>
                                                            </div>
                                                        </div>
                                                        <div class="d-flex flex-row align-items-center mb-4 col">
                                                            <i class="fas fa-venus-mars fa-lg me-3 fa-fw"></i>
                                                            <div class="form-outline flex-fill mb-0">
                                                                <select class="form-control text-white" id="admGender" onchange="checkAdminInputs()" name="admGender">
                                                                    <option class="text-black" value="M">Male</option>
                                                                    <option class="text-black" value="F">Female</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="d-flex flex-row align-items-center mb-4 col">
                                                            <i class="fas fa-location-dot fa-lg me-3 fa-fw"></i>
                                                            <div class="form-outline flex-fill mb-0">
                                                                <input type="text" id="admAddress" class="form-control text-white" name="admAddress" 
                                                                       oninput="checkAdminInputs()" required 
                                                                       value="${user.getAdmin().get(0).getAddress()}"/>
                                                                <label class="form-label text-white" for="admAddress">Address</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="d-flex justify-content-end">
                                                        <input type="hidden" name="ops" value="edit">
                                                        <input type="hidden" name="uname" value="${param.id}">
                                                        <button type="submit" class="btn btn-primary p-3" id="admSubmit" 
                                                                style="width: 160px; font-size: 14px;" disabled>
                                                            Submit
                                                        </button>
                                                    </div>

                                                </form>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>          
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <jsp:include page="../shared/backtotop.jsp" />
        <jsp:include page="shared/music-player.jsp" />
        <jsp:include page="../nav/footer.jsp" />

        <script type="text/javascript">
            window.onload = function () {
                initGender();

                //Initialize the Label. Reference: https://mdbootstrap.com/support/standard/input-field-label-doesnt-update-styles-when-value-set-programmatically/
                document.querySelectorAll('.form-outline input').forEach((input) => {
                    const formOutline = input.parentNode;
                    new mdb.Input(formOutline).init();
                });

            };

            function initGender() {
            <c:forEach var="user" items="${sessionScope.userList}">
                <c:if test="${user.id eq param.id && user.role eq 'seller'}">
                var selrGender = document.getElementById("selrGender");
                selrGender.value = "${user.getSeller().get(0).getGender()}";
                </c:if>
                <c:if test="${user.id eq param.id && user.role eq 'customer'}">
                var custGender = document.getElementById("custGender");
                custGender.value = "${user.getCust().get(0).getGender()}";
                </c:if>
                <c:if test="${user.id eq param.id && user.role eq 'admin'}">
                var admGender = document.getElementById("admGender");
                admGender.value = "${user.getAdmin().get(0).getGender()}";
                </c:if>
            </c:forEach>
            }

            function checkSellerInputs() {

                var selrShopName = document.getElementById("selrShopName").value;
                var selrName = document.getElementById("selrName").value;
                var selrEmail = document.getElementById("selrEmail").value;
                var selrGender = document.getElementById("selrGender").value;
                var btnSubmit = document.getElementById("selrSubmit");
                var selrAddress = document.getElementById("selrAddress").value;

                if (selrShopName && selrName && selrEmail && selrGender && selrAddress) {
                    var validSelrShopName = validateShopNameInput(selrShopName);
                    var validSelrName = validateNameInput(selrName);
                    var validSelrEmail = validateEmailInput(selrEmail);

                    if (validSelrShopName && validSelrName && validSelrEmail) {
                        btnSubmit.disabled = false;
                    } else {
                        btnSubmit.disabled = true;
                    }
                }

            }

            function checkCustInputs() {
                var custName = document.getElementById("custName").value;
                var custEmail = document.getElementById("custEmail").value;
                var custGender = document.getElementById("custGender").value;
                var btnSubmit = document.getElementById("custSubmit");
                var custAddress = document.getElementById("custAddress").value;

                if (custName && custEmail && custGender && custAddress) {
                    var validCustName = validateNameInput(custName);
                    var validCustEmail = validateEmailInput(custEmail);

                    if (validCustName && validCustEmail) {
                        btnSubmit.disabled = false;
                    } else {
                        btnSubmit.disabled = true;
                    }
                }
            }

            function checkAdminInputs() {
                var admName = document.getElementById("admName").value;
                var admDept = document.getElementById("admDept").value;
                var admEmail = document.getElementById("admEmail").value;
                var admGender = document.getElementById("admGender").value;
                var btnSubmit = document.getElementById("admSubmit");
                var admAddress = document.getElementById("admAddress").value;

                if (admName && admDept && admEmail && admGender && admAddress) {
                    var validAdmDept = validateNameInput(admDept);
                    var validAdmName = validateNameInput(admName);
                    var validAdmEmail = validateEmailInput(admEmail);

                    if (validAdmDept && validAdmName && validAdmEmail) {
                        btnSubmit.disabled = false;
                    } else {
                        btnSubmit.disabled = true;
                    }
                }
            }

            function validateShopNameInput(input) {
                if (/^[A-Za-z0-9\\s_-]+$/.test(input)) {
                    return true;
                } else {
                    return false;
                }
            }

            function validateNameInput(input) {
                if (/^[a-zA-Z]+$/.test(input)) {
                    return true;
                } else {
                    return false;
                }
            }

            function validateEmailInput(input) {
                if (/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(input)) {
                    return true;
                } else {
                    return false;
                }
            }

        </script>
    </body>
</html>
<style>
    .form-outline .form-control {
        border: 1px solid #bdbdbd;
    }

    .bg {
        background-image: url("https://wallpaperaccess.com/full/3229727.jpg");
        background-repeat: no-repeat;
        background-position: center;
        background-size: cover;
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

    .card-bg {
        background: rgba(255, 255, 255, 0.1) !important;
        backdrop-filter: blur(5px);
        filter: drop-shadow(2px 4px 6px black);
    }

    .form-label {
        z-index: 2;
    }

    .form-notch {
        display: none !important;
    }
</style>

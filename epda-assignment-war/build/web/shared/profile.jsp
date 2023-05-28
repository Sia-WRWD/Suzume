<%-- 
    Document   : profile
    Created on : Mar 31, 2023, 12:05:46 AM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Profile</title>
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

        <div class="bg h-100">
            <div class="container py-4 vh-100 col-12 d-flex profile-content" style="padding-top: 2rem !important; position: relative; z-index: 2;">
                <div class="row h-100 col-4">
                    <div class="col-md-12 col-xl-12 mb-4">

                        <div class="card pb-1" style="border-radius: 15px;">
                            <div class="card-body text-center d-flex justify-content-center flex-column">
                                <div class="mt-3 mb-4">
                                    <c:if test="${role eq 'seller'}">
                                        <img src="${pageContext.request.contextPath}/shared/seller-pic.png"
                                             class="rounded-circle img-fluid" style="width: 195px; height: 110px; filter: drop-shadow(1px 2px 3px black);" />
                                    </c:if>
                                    <c:if test="${role eq 'customer'}">
                                        <img src="${pageContext.request.contextPath}/shared/customer-pic.png"
                                             class="rounded-circle img-fluid" style="width: 145px; height: 110px; filter: drop-shadow(1px 2px 3px black);" />
                                    </c:if>
                                    <c:if test="${role eq 'admin'}">
                                        <img src="${pageContext.request.contextPath}/shared/admin-pic.png"
                                             class="rounded-circle img-fluid" style="width: 195px; height: 110px; filter: drop-shadow(1px 2px 3px black);" />
                                    </c:if>
                                </div>
                                <h4 class="mb-2 text-danger">${uname}</h4>
                                <c:if test="${sessionScope.role eq 'seller'}">
                                    <div class="d-flex justify-content-around text-center mb-3">
                                        <div>
                                            <p class="mb-0 text-info">
                                                <i class="fas fa-store me-1 fa-fw"></i> ${accd.get(0).getShopName()}
                                            </p>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${sessionScope.role eq 'admin'}">
                                    <div class="d-flex justify-content-around text-center mb-3">
                                        <div>
                                            <p class="mb-0 text-info">
                                                <i class="fas fa-hammer me-1 fa-fw"></i> Admin
                                            </p>
                                        </div>
                                    </div>
                                </c:if>
                                <button type="button" class="btn btn-primary btn-rounded btn-lg" id="btnEdit" onclick="toggleEdit()">
                                    Edit Profile <i class="fas fa-pen-to-square"></i>
                                </button>
                                <button type="button" class="btn btn-primary btn-rounded btn-lg" id="btnCancelEdit" onclick="reset()">
                                    Cancel Edit <i class="fas fa-trash"></i>
                                </button>
                                <c:if test="${sessionScope.role eq 'customer'}">
                                    <div class="d-flex justify-content-around text-center mt-5 mb-2">
                                        <div>
                                            <p class="mb-2 h5 text-white">${accd.get(0).getRatings()}</p>
                                            <p class="mb-0 text-info">My Ratings</p>
                                        </div>
                                        <div>
                                            <p class="mb-2 h5 text-white">${trans.size()}</p>
                                            <p class="mb-0 text-info">Total Transactions</p>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${sessionScope.role eq 'seller'}">
                                    <div class="d-flex justify-content-around text-center mt-5 mb-2">
                                        <div>
                                            <p class="mb-2 h5 text-white">${accd.get(0).getRatings()}</p>
                                            <p class="mb-0 text-info">My Ratings</p>
                                        </div>
                                        <div>
                                            <p class="mb-2 h5 text-white">${trans.size()}</p>
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

                        <div class="card pb-3" style="border-radius: 15px;">
                            <p class="text-center h1 fw-bold mx-1 mx-md-4 mt-4 text-info" style="filter: drop-shadow(1px 2px 3px black);">Account Details</p>

                            <div class="card-body text-center">
                                <form class="mx-1 mx-md-4" method="POST" action="${pageContext.request.contextPath}/Profile">
                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                                        <div class="form-outline flex-fill mb-0">
                                            <input type="email" id="email" class="form-control" name="email" 
                                                   oninput="checkInputs()" required readonly/>
                                            <label class="form-label" id="lblEmail" for="email">Email</label>
                                        </div>
                                    </div>
                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <i class="far fa-circle-user fa-lg me-3 fa-fw"></i>
                                        <div class="form-outline flex-fill mb-0">
                                            <input type="text" id="name" class="form-control" name="name" 
                                                   oninput="checkInputs()" required readonly/>
                                            <label class="form-label" id="lblName" for="name">Name</label>
                                        </div>
                                    </div>
                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <i class="fas fa-venus-mars fa-lg me-3 fa-fw"></i>
                                        <div class="form-outline flex-fill mb-0">
                                            <select class="form-control" id="gender" onchange="checkInputs()" name="gender" disabled>
                                                <option value="M">Male</option>
                                                <option value="F">Female</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <i class="far fa-circle-user fa-lg me-3 fa-fw"></i>
                                        <div class="form-outline flex-fill mb-0">
                                            <input type="text" id="address" class="form-control" name="address" 
                                                   oninput="checkInputs()" required readonly/>
                                            <label class="form-label" id="lblAddress" for="address">Address</label>
                                        </div>
                                    </div>

                                    <input type="hidden" value="acc" name="operation">

                                    <div class="d-flex justify-content-end mb-3 mb-lg-4">
                                        <button type="submit" value="Profile" class="btn btn-primary btn-lg" id="accSubmit" disabled>Update Details</button>
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-12 col-xl-12 mt-4">

                        <div class="card" style="border-radius: 15px;">
                            <p class="text-center h1 fw-bold mx-1 mx-md-4 mt-4 text-info" style="filter: drop-shadow(1px 2px 3px black);">Password Settings</p>

                            <div class="card-body text-center">
                                <form class="mx-1 mx-md-4" method="POST" action="${pageContext.request.contextPath}/Profile">
                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <i class="fas fa-unlock fa-lg me-3 fa-fw"></i>
                                        <div class="form-outline flex-fill mb-0">
                                            <input type="password" id="oldpass" class="form-control text-white" name="oldpass" 
                                                   oninput="checkInputs()" required/>
                                            <label class="form-label text-white" for="oldpass">Old Password</label>
                                        </div>
                                    </div>
                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <i class="fas fa-key fa-lg me-3 fa-fw"></i>
                                        <div class="form-outline flex-fill mb-0">
                                            <input type="password" id="newpass" class="form-control text-white" name="newpass" 
                                                   oninput="checkInputs()" required/>
                                            <label class="form-label text-white" for="newpass">New Password</label>
                                        </div>
                                    </div>
                                    <input type="hidden" value="pwd" name="operation">

                                    <div class="d-flex justify-content-end mb-3 mb-lg-4">
                                        <button type="submit" value="Profile" class="btn btn-primary btn-lg" id="pwdSubmit" disabled>Update Password</button>
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>
                </div>                   
            </div>         
        </div>

        <jsp:include page="backtotop.jsp" />
        <jsp:include page="../shared/music-player.jsp" />
        <jsp:include page="../nav/footer.jsp" />

        <!-- Alert -->

        <c:if test="${not empty updateAccSuccess or not empty updatePwdSuccess}">
            <div class="alert alert-success" id="alert-success">
                ${updateAccSuccess}
                ${updatePwdSuccess}
                <i class="fas fa-circle-check" style="font-size: 25px; margin-left: 10px;"></i>
            </div>
        </c:if>

        <c:if test="${not empty updateAccError or not empty oldPwdError or not empty updatePwdError}">
            <div class="alert alert-danger" id="alert-error">
                ${updateAccError}
                ${oldPwdError}
                ${updatePwdError}
                <i class="fas fa-circle-xmark" style="font-size: 25px; margin-left: 10px;"></i>
            </div>
        </c:if>

        <!-- Alert --> 

        <script type="text/javascript">
            window.onload = function () {
                initValue();

                //Initialize the Label.
                document.querySelectorAll('.form-outline input').forEach((input) => {
                    const formOutline = input.parentNode;
                    new mdb.Input(formOutline).init();
                });
            };

            function initValue() {
                var sEmail = "${accd.get(0).getEmail()}";
                var sName = "${accd.get(0).getName()}";
                var sGender = "${accd.get(0).getGender()}";
                var sAddress = "${accd.get(0).getAddress()}";

                var iEmail = document.getElementById("email");
                var iName = document.getElementById("name");
                var iGender = document.getElementById("gender");
                var iAddress = document.getElementById("address");

                iEmail.value = sEmail;
                iName.value = sName;
                iGender.value = sGender;
                iAddress.value = sAddress;
            }

            function toggleEdit() {
                var iEmail = document.getElementById("email");
                var lblEmail = document.getElementById("lblEmail");
                var iName = document.getElementById("name");
                var lblName = document.getElementById("lblName");
                var iGender = document.getElementById("gender");
                var lblAddress = document.getElementById("lblAddress");
                var iAddress = document.getElementById("address");
                var btnToggle = document.getElementById("btnEdit");
                var btnCancel = document.getElementById("btnCancelEdit");

                iEmail.removeAttribute("readonly");
                iName.removeAttribute("readonly");
                iAddress.removeAttribute("readonly");
                iGender.disabled = false;

                btnToggle.style.display = "none";
                btnCancel.style.display = "block";

                iEmail.classList.add("text-warning");
                iName.classList.add("text-warning");
                iGender.classList.add("text-warning");
                iAddress.classList.add("text-warning");
                lblEmail.classList.add("text-white");
                lblName.classList.add("text-white");
                lblAddress.classList.add("text-white");
            }

            function reset() {
                initValue();

                var iEmail = document.getElementById("email");
                var lblEmail = document.getElementById("lblEmail");
                var iName = document.getElementById("name");
                var lblName = document.getElementById("lblName");
                var iGender = document.getElementById("gender");
                var lblAddress = document.getElementById("lblAddress");
                var iAddress = document.getElementById("address");

                var btnToggle = document.getElementById("btnEdit");
                var btnCancel = document.getElementById("btnCancelEdit");
                var btnAcc = document.getElementById("accSubmit");
                var btnPwd = document.getElementById("pwdSubmit");

                iEmail.setAttribute("readonly", true);
                iName.setAttribute("readonly", true);
                iAddress.setAttribute("readonly", true);
                iGender.disabled = true;

                btnToggle.style.display = "block";
                btnCancel.style.display = "none";
                btnAcc.disabled = true;
                btnPwd.disabled = true;

                iEmail.classList.remove("text-warning");
                iName.classList.remove("text-warning");
                iGender.classList.remove("text-warning");
                iAddress.classList.remove("text-warning");
                lblEmail.classList.remove("text-white");
                lblName.classList.remove("text-white");
                lblAddress.classList.remove("text-white");
                lblEmail.classList.add("text-black");
                lblName.classList.add("text-black");
                lblAddress.classList.add("text-black");
            }

            function checkInputs() {

                var iEmail = document.getElementById("email").value;
                var iName = document.getElementById("name").value;
                var iGender = document.getElementById("gender").value;
                var iOldPass = document.getElementById("oldpass").value;
                var iNewPass = document.getElementById("newpass").value;
                var iAddress = document.getElementById("address").value;

                var btnAcc = document.getElementById("accSubmit");
                var btnPwd = document.getElementById("pwdSubmit");

                if (iEmail && iName && iGender && iAddress) {
                    var validEmail = validateEmail(iEmail);
                    var validName = validateName(iName);

                    if (validEmail && validName) {
                        btnAcc.disabled = false;
                    }
                } else {
                    btnAcc.disabled = true;
                }

                if (iOldPass && iNewPass) {
                    btnPwd.disabled = false;
                } else {
                    btnPwd.disabled = true;
                }

            }

            function validateEmail(email) {
                if (/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(email)) {
                    return true;
                } else {
                    return false;
                }
            }

            function validateName(input) {
                if (/^[a-zA-Z]+$/.test(input)) {
                    return true;
                } else {
                    return false;
                }
            }

            // Hide the alert after 3 seconds
            setTimeout(function () {
                var successAlert = document.getElementById("alert-success");
                var errorAlert = document.getElementById("alert-error")
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
        background-image: url("https://wallpapercave.com/wp/wp10268002.jpg");
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

    #btnCancelEdit {
        display: none;
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

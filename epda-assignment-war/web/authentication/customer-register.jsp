<%-- 
    Document   : register
    Created on : Mar 30, 2023, 7:21:50 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Register</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.css" rel="stylesheet"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/tilt.js/1.2.1/tilt.jquery.min.js"></script>
        <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    </head>
    <body>

        <c:if test="${not empty sessionScope.uname}">
            <%
                response.sendRedirect("/epda-assignment-war/home.jsp");
            %>
        </c:if>

        <section class="h-100 bg py-4">
            <div class="container vh-100 justify-content-center align-items-center" style="position: relative; z-index: 2;">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-lg-12 col-xl-11">
                        <div class="card card-bg text-white" style="border-radius: 25px;">
                            <div class="card-body p-md-5">
                                <div class="btn btn-danger" style="width:fit-content; height: fit-content;">
                                    <a href="${pageContext.request.contextPath}/authentication/login.jsp" style="color: white; font-size: 1rem;">
                                        <i class="fa fa-arrow-left"></i>
                                    </a>
                                </div>
                                <div class="row justify-content-center">
                                    <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">

                                        <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Customer Sign Up</p>

                                        <form class="mx-1 mx-md-4" method="POST" action="${pageContext.request.contextPath}/Register">

                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input type="text" id="username" class="form-control text-white" name="username" required 
                                                           oninput="checkInputs()"/>
                                                    <label class="form-label text-white" for="username">Your Username</label>
                                                </div>
                                            </div>

                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input type="text" id="name" class="form-control text-white" name="name" required 
                                                           oninput="checkInputs()"/>
                                                    <label class="form-label text-white" for="name">Your Name</label>
                                                </div>
                                            </div>

                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-envelope fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input type="email" id="email" class="form-control text-white" name="email" required
                                                           oninput="checkInputs()"/>
                                                    <label class="form-label text-white" for="email">Your Email</label>
                                                </div>
                                            </div>

                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-location-dot fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input type="text" id="address" class="form-control text-white" name="address" required
                                                           oninput="checkInputs()"/>
                                                    <label class="form-label text-white" for="address">Your Address</label>
                                                </div>
                                            </div>

                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-lock fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input type="password" id="password" class="form-control text-white" name="password" required
                                                           oninput="checkInputs()"/>
                                                    <label class="form-label text-white" for="password">Password</label>
                                                </div>
                                            </div>

                                            <div class="d-flex flex-row align-items-center mb-4">
                                                <i class="fas fa-key fa-lg me-3 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input type="password" id="repassword" class="form-control text-white" name="repassword" required
                                                           oninput="checkInputs()"/>
                                                    <label class="form-label text-white" for="repassword">Repeat your password</label>
                                                </div>
                                            </div>

                                            <div class="form-check d-flex justify-content-center mb-4">
                                                <input class="form-check-input me-2" type="checkbox" value="" id="terms" required
                                                       onchange="checkInputs()"/>
                                                <label class="form-check-label" for="terms">
                                                    I agree all statements in <a href="#!" class="text-danger" style="font-weight: bold;">
                                                        Terms of service
                                                    </a>
                                                </label>
                                            </div>

                                            <input type="hidden" name="role" value="customer">

                                            <div class="d-flex justify-content-center mb-3 mb-lg-4">
                                                <button type="submit" value="Register" class="btn btn-block btn-primary btn-lg" id="regSubmit" disabled>Register</button>
                                            </div>

                                        </form>
                                    </div>
                                    <div class="col-md-10 col-lg-6 col-xl-7 d-flex justify-content-center align-items-center order-1 order-lg-2 tilt-this" data-tilt>

                                        <img src="/epda-assignment-war/authentication/register.png"
                                             class="img-fluid" alt="Sample image">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <jsp:include page="../shared/music-player.jsp" />

        <!-- Alert -->
        <c:if test="${not empty registerationError or not empty otherError}">
            <div class="alert alert-danger" id="alert-error">
                ${registerationError}
                ${otherError}
                <i class="far fa-circle-xmark" style="font-size: 25px; margin-left: 10px;"></i>
            </div>
        </c:if>
        <!-- Alert -->

        <script type="text/javascript">
            $('.tilt-this').tilt({
                max: 20,
                speed: 150,
                scale: 1.05
            });

            function checkInputs() {

                var username = document.getElementById("username").value;
                var name = document.getElementById("name").value;
                var email = document.getElementById("email").value;
                var password = document.getElementById("password").value;
                var repassword = document.getElementById("repassword").value;
                var terms = document.getElementById("terms").checked;
                var btnSubmit = document.getElementById("regSubmit");
                var address = document.getElementById("address").value;

                if (username && name && email && password && repassword && terms && address) {
                    var validUsername = validateUsernameInput(username);
                    var validName = validateNameInput(name);
                    var validEmail = validateEmail(email);
                    var validPwds = validatePwd(password, repassword);

                    if (validUsername && validName && validEmail && validPwds) {
                        btnSubmit.disabled = false;
                    } else {
                        btnSubmit.disabled = true;
                    }
                }

            }

            function validateNameInput(input) {
                if (/^[a-zA-Z ]{2,}$/.test(input)) {
                    return true;
                } else {
                    return false;
                }
            }

            function validateUsernameInput(input) {
                if (/^[a-zA-Z0-9]*$/.test(input)) {
                    return true;
                } else {
                    return false;
                }
            }

            function validateEmail(email) {
                if (/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(email)) {
                    return true;
                } else {
                    return false;
                }
            }

            function validatePwd(pwd, repwd) {
                if (pwd === repwd) {
                    return true;
                } else {
                    return false;
                }
            }

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
    .form-outline .form-control {
        border: 1px solid #bdbdbd;
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

    .bg {
        background-image: url("https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/549e9b77-4c90-4c7f-8d0e-772a4ba70576/daj4ocm-f915657c-797c-40ee-b7a5-23dd7750457c.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzU0OWU5Yjc3LTRjOTAtNGM3Zi04ZDBlLTc3MmE0YmE3MDU3NlwvZGFqNG9jbS1mOTE1NjU3Yy03OTdjLTQwZWUtYjdhNS0yM2RkNzc1MDQ1N2MuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.PaAp8z14lGYJi8O6vtI_u7ZCcET_ThsIniENsVrZZuU");
        background-repeat: no-repeat;
        background-position: center;
        background-size: cover;
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
</style>

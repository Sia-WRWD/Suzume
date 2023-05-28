<%-- 
    Document   : login
    Created on : Mar 30, 2023, 1:46:33 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Login</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.css" rel="stylesheet"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
        <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    </head>
    <body>
        <c:if test="${not empty sessionScope.uname}">
            <%
                response.sendRedirect("/epda-assignment-war/home.jsp");
            %>
        </c:if>
        <div class="bg h-100">
            <div class="container d-flex justify-content-center align-items-center vh-100">
                <div class="wrapper">
                    <div class="btn" style="width:fit-content; height: fit-content;">
                        <a href="${pageContext.request.contextPath}/home.jsp" style="color: white; font-size: 1rem;">
                            <i class="fa fa-arrow-left"></i>
                        </a>
                    </div>
                    <div class="logo">
                        <img src="https://img1.ak.crunchyroll.com/i/spire3/b534744242637dff62604afcdf8561e51639560872_full.jpg" alt="">
                    </div>
                    <div class="text-center mt-4 name">
                        User Login
                    </div>
                    <form class="p-3 mt-3" method="POST" action="${pageContext.request.contextPath}/Login">
                        <div class="form-field d-flex align-items-center">
                            <span class="fa fa-user"></span>
                            <input type="text" name="username" id="username" placeholder="Username" oninput="checkInputs()">
                        </div>
                        <div class="form-field d-flex align-items-center">
                            <span class="fa fa-key"></span>
                            <input type="password" name="password" id="password" placeholder="Password" oninput="checkInputs()">
                        </div>
                        <button type="submit" value="Login" class="btn mt-3 bg-primary" id="btnLogin" disabled>Login</button>
                    </form>
                    <div class="text-center fs-6">
                        <a class="btn-link" data-mdb-toggle="modal" data-mdb-target="#resetModal" style="cursor: pointer;">Forget password?</a> 
                        or <a href="${pageContext.request.contextPath}/authentication/customer-register.jsp">Sign up</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal top fade" id="resetModal" tabindex="-1" aria-labelledby="resetModal"
             aria-hidden="true" data-mdb-backdrop="true" data-mdb-keyboard="true">
            <div class="modal-dialog" style="width: 400px;">
                <div class="modal-content text-center">
                    <div class="modal-header h5 text-white bg-danger justify-content-center">
                        Password Reset
                    </div>
                    <div class="modal-body px-5">
                        <form method="POST" action="${pageContext.request.contextPath}/ResetPassword">
                            <p class="py-2">
                                Enter your email, username and new password. if your username exist and your email matches, your account's password will be reset.
                            </p>
                            <div class="form-outline">
                                <input type="email" id="email" class="form-control my-3" oninput="checkResetInputs()" name="email"/>
                                <label class="form-label" for="email">Email</label>
                            </div>
                            <div class="form-outline">
                                <input type="text" id="uname" class="form-control my-3" oninput="checkResetInputs()" name="uname"/>
                                <label class="form-label" for="uname">Username</label>
                            </div>
                            <div class="form-outline">
                                <input type="password" id="newpwd" class="form-control my-3" oninput="checkResetInputs()" name="newpwd"/>
                                <label class="form-label" for="newpwd">New Password</label>
                            </div>
                            <button type="submit" class="btn btn-danger w-100" id="btnReset" disabled>
                                Reset password
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="../shared/music-player.jsp" />
                            
        <!-- Alert -->
        <c:if test="${not empty registerationSuccess or not empty logoutSuccess or not empty passwordResetSuccess}">
            <div class="alert alert-success" id="alert-success">
                ${registerationSuccess}
                ${logoutSuccess}
                ${passwordResetSuccess}
                <i class="fas fa-circle-check" style="font-size: 25px; margin-left: 10px;"></i>
            </div>
        </c:if>

        <c:if test="${not empty loginError or not empty otherError or not empty deactivatedError or not empty passwordResetError}">
            <div class="alert alert-danger" id="alert-error">
                ${loginError}
                ${otherError}
                ${deactivatedError}
                ${passwordResetError}
                <i class="fas fa-circle-xmark" style="font-size: 25px; margin-left: 10px;"></i>
            </div>
        </c:if>
        <!-- Alert -->

        <script type="text/javascript">
            function checkResetInputs() {
                var email = document.getElementById("email").value;
                var uname = document.getElementById("uname").value;
                var newpwd = document.getElementById("newpwd").value;
                var btnSubmit = document.getElementById("btnReset");

                if (email && uname && newpwd) {
                    var validEmail = validateEmailInput(email);
                    var validUname = validateUsernameInput(uname);

                    if (validEmail && validUname) {
                        btnSubmit.disabled = false;
                    } else {
                        btnSubmit.disabled = true;
                    }
                }
            }

            function checkInputs() {

                var username = document.getElementById("username").value;
                var password = document.getElementById("password").value;
                var btnSubmit = document.getElementById("btnLogin");
                var validUsername = validateUsernameInput(username);

                if (validUsername && password) {
                    btnSubmit.disabled = false;
                } else {
                    btnSubmit.disabled = true;
                }
            }

            function validateUsernameInput(input) {
                if (/^[a-zA-Z0-9]*$/.test(input)) {
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
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
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
        background-image: url("https://images5.alphacoders.com/119/thumb-1920-1198137.jpg");
        background-repeat: no-repeat;
        background-position: center;
        background-size: cover;
        display: flex;
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

    .wrapper {
        display: flex;
        flex-direction: column;
        width: 500px;
        height: 750px;
        margin: auto;
        padding: 40px 30px 30px 30px;
        background-color: #ecf0f3;
        border-radius: 15px;
        box-shadow: 5px 10px 15px #cbced1;
        position: relative;
        z-index: 2;
        margin-top: 30px;
        margin-bottom: 30px;
    }

    .logo {
        width: 300px;
        margin: auto;
    }

    .logo img {
        width: 100%;
        height: 300px;
        object-fit: cover;
        border-radius: 50%;
        box-shadow: 0px 0px 3px #5f5f5f,
            0px 0px 0px 5px #ecf0f3,
            8px 8px 15px #a7aaa7,
            -8px -8px 15px #fff;
    }

    .wrapper .name {
        font-weight: 600;
        font-size: 1.4rem;
        letter-spacing: 1.3px;
        padding-left: 10px;
        color: #555;
    }

    .wrapper .form-field input {
        width: 100%;
        display: block;
        border: none;
        outline: none;
        background: none;
        font-size: 1.2rem;
        color: #666;
        padding: 10px 15px 10px 10px;
        /* border: 1px solid red; */
    }

    .wrapper .form-field {
        padding-left: 10px;
        margin-bottom: 20px;
        border-radius: 20px;
        box-shadow: inset 8px 8px 8px #cbced1, inset -8px -8px 8px #fff;
    }

    .wrapper .form-field .fas {
        color: #555;
    }

    .wrapper .btn {
        box-shadow: none;
        width: 100%;
        height: 40px;
        background-color: #03A9F4;
        color: #fff;
        border-radius: 25px;
        box-shadow: 3px 3px 3px #b1b1b1,
            -3px -3px 3px #fff;
        letter-spacing: 1.3px;
    }

    .wrapper .btn:hover {
        background-color: #039BE5;
    }

    .wrapper a {
        text-decoration: none;
        font-size: 0.8rem;
        color: #03A9F4;
    }

    .wrapper a:hover {
        color: #039BE5;
    }

    @media(max-width: 380px) {
        .wrapper {
            margin: 30px 20px;
            padding: 40px 15px 15px 15px;
        }
    }

    .form-label {
        z-index: 2;
    }

    .form-notch {
        display: none !important;
    }

    .form-outline .form-control {
        border: 1px solid #bdbdbd;
    }
</style>

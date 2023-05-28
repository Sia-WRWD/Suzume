<%-- 
    Document   : cart
    Created on : Apr 4, 2023, 10:50:36 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Cart</title>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.css" rel="stylesheet"/>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>
        <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    </head>
    <body>
        <c:if test="${not empty sessionScope.uname && role ne 'customer'}">
            <%
                response.sendRedirect("/epda-assignment-war/home.jsp");
            %>
        </c:if>

        <jsp:include page="../nav/banner.jsp" />

        <section class="h-100 py-4 bg text-white" style="background-color: #eee;">
            <div class="container d-flex justify-content-center align-items-center vh-100 cart-container">
                <div class="row w-100">
                    <div class="col">
                        <div class="card">
                            <div class="card-body p-4">

                                <div class="row justify-content-center">

                                    <div class="col-lg-7">
                                        <h5 class="mb-3"><a href="${pageContext.request.contextPath}/market/all-items.jsp" class="text-white"><i
                                                    class="fas fa-long-arrow-alt-left me-2"></i>Continue shopping</a></h5>
                                        <hr>
                                        <c:if test="${not empty sessionScope.cart}">
                                            <div class="d-flex justify-content-between align-items-center mb-4 text-white">
                                                <div>
                                                    <p class="mb-1">Shopping cart</p>
                                                    <p class="mb-0">You have ${sessionScope.cart.size()} item(s) in your cart</p>
                                                </div>
                                            </div>

                                            <c:forEach var="cartItem" items="${sessionScope.cart}">
                                                <div class="card mb-3">
                                                    <div class="card-body">
                                                        <div class="d-flex justify-content-between">
                                                            <div class="d-flex flex-row align-items-center">
                                                                <div>
                                                                    <img
                                                                        src="${cartItem.imgUrl}"
                                                                        class="img-fluid rounded-3" alt="Shopping item" 
                                                                        style="width: 65px; height: 65px; object-fit: cover; object-position: top;">
                                                                </div>
                                                                <div class="ms-3">
                                                                    <h5>${cartItem.name}</h5>
                                                                    <p class="small mb-0">${cartItem.category}</p>
                                                                </div>
                                                            </div>
                                                            <div class="d-flex flex-row align-items-center">
                                                                <div style="width: 50px;">
                                                                    <h5 class="fw-normal mb-0">${cartItem.quantity}</h5>
                                                                </div>
                                                                <div style="width: 110px;">
                                                                    <h5 class="mb-0">
                                                                        RM <fmt:formatNumber type="number" value="${cartItem.price}" minFractionDigits="2" maxFractionDigits="2" />
                                                                    </h5>
                                                                </div>
                                                                <form method="POST" action="${pageContext.request.contextPath}/RemoveFromCart">
                                                                    <input type="hidden" value="${cartItem.id}" name="itemId">
                                                                    <button type="submit" class="btn-link" style="background: none; border: 0;">
                                                                        <i class="text-danger fas fa-trash-alt"></i>
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${empty sessionScope.cart}">
                                            <div class="d-flex align-items-center justify-content-center flex-column h-100" style="filter: drop-shadow(1px 2px 3px black);">
                                                <h2 class="text-warning fw-bold">No item has been added yet!</h2>
                                                <img src="${pageContext.request.contextPath}/customer/no-item.jpg" al="no-items.jpg" style="height: 350px; width: 350px;">
                                            </div>
                                        </c:if>
                                    </div>
                                    <c:if test="${not empty sessionScope.cart}">
                                        <div class="col-lg-5">

                                            <div class="card bg-primary text-white rounded-3">
                                                <div class="card-body" style="filter: drop-shadow(1px 2px 3px black);">
                                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                                        <h5 class="mb-0">Payment Details</h5>
                                                    </div>

                                                    <c:if test="${not empty sessionScope.uname}">
                                                        <p class="small mb-2">We Accept:</p>
                                                        <a class="text-white" id="ccVisa"><i class="fab fa-cc-mastercard fa-2x me-2"></i></a>
                                                        <a class="text-white" id="ccMaster"><i class="fab fa-cc-visa fa-2x me-2"></i></a>
                                                        <a class="text-white" id="ccAmex"><i class="fab fa-cc-amex fa-2x me-2"></i></a>

                                                        <form method="POST" action="${pageContext.request.contextPath}/CreateTransaction" class="mt-4">
                                                            <div class="form-outline form-white mb-4">
                                                                <input type="text" class="form-control form-control-lg" size="17" id="ccName"
                                                                       placeholder="Cardholder's Name" name="ccName" oninput="checkInputs()"/>
                                                                <label class="form-label" for="typeName">Cardholder's Name</label>
                                                            </div>

                                                            <div class="form-outline form-white mb-4">
                                                                <input type="text" class="form-control form-control-lg" size="17"
                                                                       placeholder="1234 5678 9012 3457" minlength="16" maxlength="16" name="ccNum"
                                                                       id="ccNum" oninput="checkInputs()"/>
                                                                <label class="form-label" for="typeText">Card Number</label>
                                                            </div>

                                                            <div class="row mb-4">
                                                                <div class="col-md-6">
                                                                    <div class="form-outline form-white">
                                                                        <input type="text" class="form-control form-control-lg" id="ccDate" name="ccDate" id="ccDate"
                                                                               placeholder="MM/YY" size="7" minlength="5" maxlength="5" oninput="checkInputs()"/>
                                                                        <label class="form-label" for="typeExp">Expiration</label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-outline form-white">
                                                                        <input type="password" class="form-control form-control-lg" id="ccCVV" name="ccCVV"
                                                                               placeholder="&#9679;&#9679;&#9679;" size="1" minlength="3" maxlength="3" oninput="checkInputs()"/>
                                                                        <label class="form-label" for="typeText">CVV</label>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <hr class="my-4">
                                                        </c:if>
                                                        <div class="d-flex justify-content-between">
                                                            <p class="mb-2">Subtotal</p>
                                                            <p class="mb-2">
                                                                RM <fmt:formatNumber type="number" value="${sessionScope.cartTotal}" minFractionDigits="2" maxFractionDigits="2" />
                                                            </p>
                                                        </div>

                                                        <div class="d-flex justify-content-between">
                                                            <p class="mb-2">Shipping</p>
                                                            <p class="mb-2">
                                                                RM <fmt:formatNumber type="number" value="${sessionScope.shippingTotal}" minFractionDigits="2" maxFractionDigits="2" />
                                                            </p>
                                                        </div>

                                                        <div class="d-flex justify-content-between mb-4">
                                                            <p class="mb-2">Final Total</p>
                                                            <p class="mb-2">
                                                                RM <fmt:formatNumber type="number" value="${sessionScope.finalTotal}" minFractionDigits="2" maxFractionDigits="2" />
                                                            </p>
                                                        </div>
                                                        <c:if test="${not empty sessionScope.uname}">
                                                            <input type="hidden" value="" name="ccType" id="ccType">
                                                            <input type="hidden" value="${sessionScope.uname}" name="uname">
                                                            <button type="submit" class="btn btn-info btn-block btn-lg" value="CreateTransaction" 
                                                                    id="btnCheckout" disabled>
                                                                <div class="d-flex justify-content-between">
                                                                    <span>
                                                                        RM <fmt:formatNumber type="number" value="${sessionScope.finalTotal}" minFractionDigits="2" maxFractionDigits="2" />
                                                                    </span>
                                                                    <span>Checkout <i class="fas fa-long-arrow-alt-right ms-2"></i></span>
                                                                </div>
                                                            </button>
                                                        </c:if>
                                                        <c:if test="${empty sessionScope.uname}">
                                                            <a type="button" class="btn btn-info btn-block btn-lg" href="${pageContext.request.contextPath}/authentication/login.jsp">
                                                                <div class="d-flex justify-content-between">
                                                                    <span>
                                                                        RM <fmt:formatNumber type="number" value="${sessionScope.finalTotal}" minFractionDigits="2" maxFractionDigits="2" />
                                                                    </span>
                                                                    <span>Login to pay <i class="fas fa-arrow-right-to-bracket ms-2"></i></span>
                                                                </div>
                                                            </a>
                                                        </c:if>
                                                        <a type="button" class="btn btn-outline-light btn-block btn-lg mt-3" href="${pageContext.request.contextPath}/market/all-items.jsp">
                                                            <div class="d-flex justify-content-between">
                                                                <span>Continue Shopping <i class="fas fa-arrow-right-to-bracket ms-2"></i></span>
                                                            </div>
                                                        </a>
                                                    </form>
                                                </div>
                                            </div>


                                        </div>
                                    </c:if>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Alert -->

        <c:if test="${not empty addItemToCartSuccess or not empty removeItemFromCartSuccess}">
            <div class="alert alert-success" id="alert-success">
                ${addItemToCartSuccess}
                ${removeItemFromCartSuccess}
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

        <jsp:include page="../shared/backtotop.jsp" />
        <jsp:include page="../shared/music-player.jsp" />
        <jsp:include page="../nav/footer.jsp" />

        <script type="text/javascript">
            var ccType = document.getElementById("ccType");
            var btnCheckout = document.getElementById("btnCheckout");

            function checkInputs() {
                var ccName = document.getElementById("ccName").value;
                var ccNum = document.getElementById("ccNum").value;
                var ccDate = document.getElementById("ccDate").value;
                var ccCVV = document.getElementById("ccCVV").value;

                if (ccNum) {
                    var ccNumValid = validateCreditCardNumber(ccNum);
                }

                if (ccName && ccNum && ccDate && ccCVV) {
                    var ccNameValid = validateName(ccName);
                    var ccDateValid = validateDate(ccDate);
                    var ccCVVValid = validateCVV(ccCVV);

                    if (ccNameValid && ccNumValid && ccDateValid && ccCVVValid && ccType) {
                        btnCheckout.disabled = false;
                    } else {
                        btnCheckout.disabled = true;
                    }
                }
            }

            function validateCreditCardNumber(cardNumber) {
                // Remove any spaces or dashes from the card number
                cardNumber = cardNumber.replace(/[ -]/g, '');

                // Regular expressions for each card type
                var visaPattern = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/;
                var mastercardPattern = /^(?:5[1-5][0-9]{14})$/;
                var amexPattern = /^(?:3[47][0-9]{13})$/;

                // Check if the card number matches any of the patterns
                if (visaPattern.test(cardNumber)) {
                    ccType.value = "visa";
                    return true;
                } else if (mastercardPattern.test(cardNumber)) {
                    ccType.value = "master";
                    return true;
                } else if (amexPattern.test(cardNumber)) {
                    ccType.value = "amex";
                    return true;
                } else {
                    return false;
                }
            }

            function toggleClass(condition, elementId) {
                const element = document.getElementById(elementId);
                if (condition) {
                    element.classList.add('text-danger');
                    element.classList.remove('text-white');
                } else {
                    element.classList.add('text-white');
                    element.classList.remove('text-danger');
                }
            }

            function validateDate(expiryDate) {
                if (/^(0[1-9]|1[0-2])\/([0-9]{2})$/.test(expiryDate)) {
                    return true;
                } else {
                    return false;
                }
            }

            function validateCVV(cvv) {
                if (/^\d{3}$/.test(cvv)) {
                    return true;
                } else {
                    return false;
                }
            }

            function validateName(name) {
                if (/^[a-zA-Z ]{2,}$/.test(name)) {
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
    .bg {
        background-image: url("https://wallpaperaccess.com/full/4612148.jpg");
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

    .cart-container {
        position: relative;
        z-index: 2;
        filter: drop-shadow(1px 2px 3px black);
    }

    .card {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(3px);
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
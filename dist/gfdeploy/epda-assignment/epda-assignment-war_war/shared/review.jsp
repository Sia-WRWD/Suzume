<%-- 
    Document   : review
    Created on : Apr 7, 2023, 4:03:19 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transaction Review</title>
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

        <section class="h-100 bg py-4">
            <div class="container vh-100 pt-4" style="position: relative; z-index: 2;">
                <div class="btn btn-danger mb-4" style="width:fit-content; height: fit-content;">
                    <a href="${pageContext.request.contextPath}/shared/manage-transaction.jsp" style="color: white; font-size: 1rem;">
                        <i class="fa fa-arrow-left"></i>
                    </a>
                </div>

                <!-- Tabs navs -->
                <ul class="nav nav-tabs mb-3" id="ex1" role="tablist">
                    <li class="nav-item" role="presentation">
                        <a
                            class="nav-link active"
                            id="ex1-tab-1"
                            data-mdb-toggle="tab"
                            href="#ex1-tabs-1"
                            role="tab"
                            aria-controls="ex1-tabs-1"
                            aria-selected="true"
                            >Customer Review</a 
                        >
                    </li>
                    <li class="nav-item" role="presentation">
                        <a
                            class="nav-link"
                            id="ex1-tab-2"
                            data-mdb-toggle="tab"
                            href="#ex1-tabs-2"
                            role="tab"
                            aria-controls="ex1-tabs-2"
                            aria-selected="false"
                            >Seller Review</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a
                            class="nav-link"
                            id="ex1-tab-3"
                            data-mdb-toggle="tab"
                            href="#ex1-tabs-3"
                            role="tab"
                            aria-controls="ex1-tabs-3"
                            aria-selected="false"
                            >Item Review</a >
                    </li>
                </ul>
                <!-- Tabs navs -->

                <!-- Tabs content -->
                <div class="tab-content h-75" id="ex1-content">
                    <!--Tab 1-->
                    <div class="tab-pane fade show active" id="ex1-tabs-1" role="tabpanel" aria-labelledby="ex1-tab-1">
                        <form method="POST" action="${pageContext.request.contextPath}/ManageTransaction">
                            <p class="text-danger h1 fw-bold mt-4">Customer Review <i class="fas fa-user"></i></p>
                            <hr class="text-white">
                            <div class="row">
                                <div class="d-flex flex-column align-items-start mb-4 col">
                                    <h3 class="form-label text-white">Are you satisfied with the Seller?</h3>
                                    <div class="customer-ratings">
                                        <input type="radio" id="customer-star5" name="customer-rating" value="5"/>
                                        <label class="fas fa-star" data-mdb-toggle="tooltip" for="customer-star5" title="Awesome" aria-hidden="true"></label>
                                        <input type="radio" id="customer-star4" name="customer-rating" value="4" />
                                        <label class="fas fa-star" data-mdb-toggle="tooltip" for="customer-star4" title="Great" aria-hidden="true"></label>
                                        <input type="radio" id="customer-star3" name="customer-rating" value="3" />
                                        <label class="fas fa-star" data-mdb-toggle="tooltip" for="customer-star3" title="Very Good" aria-hidden="true"></label>
                                        <input type="radio" id="customer-star2" name="customer-rating" value="2" />
                                        <label class="fas fa-star" data-mdb-toggle="tooltip" for="customer-star2" title="Good" aria-hidden="true"></label>
                                        <input type="radio" id="customer-star1" name="customer-rating" value="1" />
                                        <label class="fas fa-star" data-mdb-toggle="tooltip" for="customer-star1" title="Bad" aria-hidden="true"></label>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex flex-row align-items-center mb-4 col">
                                <div class="form-outline flex-fill mb-0">
                                    <h3 class="form-label text-white mb-2">Any feedbacks for the Seller?</h3>
                                    <textarea id="custFeedback" class="form-control form-outline text-white" name="custFeedback" required 
                                              oninput="checkCReviewInputs()" rows="10" style="resize: none;"></textarea>
                                </div>
                            </div>
                            <div class="d-flex justify-content-end">
                                <input type="hidden" name="cust-review-ratings" value="" id="cust-review-ratings">
                                <input type="hidden" name="ops" value="custFeedback">
                                <input type="hidden" name="transactionId" value="${param.id}">
                                <button type="submit" value="ManageTransaction" class="btn btn-primary p-3" style="font-size: 16px;" 
                                        id="custSubmit" disabled>
                                    Submit Feedback
                                </button>
                            </div>
                        </form>
                    </div>
                    <!--Tab 2-->
                    <div class="tab-pane fade" id="ex1-tabs-2" role="tabpanel" aria-labelledby="ex1-tab-2">
                        <form method="POST" action="${pageContext.request.contextPath}/ManageTransaction">
                            <p class="text-danger h1 fw-bold mt-4">Seller Review <i class="fas fa-shop"></i></p>
                            <hr class="text-white">
                            <div class="row">
                                <div class="d-flex flex-column align-items-start mb-4 col">
                                    <h3 class="form-label text-white">Are you satisfied with the Customer?</h3>
                                    <div class="seller-ratings">
                                        <input type="radio" id="seller-star5" name="seller-rating" value="5"/>
                                        <label class="fas fa-star" data-mdb-toggle="tooltip" for="seller-star5" title="Awesome" aria-hidden="true"></label>
                                        <input type="radio" id="seller-star4" name="seller-rating" value="4" />
                                        <label class="fas fa-star" data-mdb-toggle="tooltip" for="seller-star4" title="Great" aria-hidden="true"></label>
                                        <input type="radio" id="seller-star3" name="seller-rating" value="3" />
                                        <label class="fas fa-star" data-mdb-toggle="tooltip" for="seller-star3" title="Very Good" aria-hidden="true"></label>
                                        <input type="radio" id="seller-star2" name="seller-rating" value="2" />
                                        <label class="fas fa-star" data-mdb-toggle="tooltip" for="seller-star2" title="Good" aria-hidden="true"></label>
                                        <input type="radio" id="seller-star1" name="seller-rating" value="1" />
                                        <label class="fas fa-star" data-mdb-toggle="tooltip" for="seller-star1" title="Bad" aria-hidden="true"></label>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex flex-row align-items-center mb-4 col">
                                <div class="form-outline flex-fill mb-0">
                                    <h3 class="form-label text-white mb-2">Any feedbacks for the Customer?</h3>
                                    <textarea id="selrFeedback" class="form-control form-outline text-white" name="selrFeedback" required 
                                              oninput="checkSReviewInputs()" rows="10" style="resize: none;"></textarea>
                                </div>
                            </div>
                            <div class="d-flex justify-content-end">
                                <input type="hidden" name="selr-review-ratings" value="" id="selr-review-ratings">
                                <input type="hidden" name="ops" value="selrFeedback">
                                <input type="hidden" name="transactionId" value="${param.id}">
                                <button type="submit" value="ManageTransaction" class="btn btn-primary p-3" style="font-size: 16px;" 
                                        id="selrSubmit" disabled>
                                    Submit Feedback
                                </button>
                            </div>
                        </form>
                    </div>
                    <!--Tab 3-->
                    <div class="tab-pane fade" id="ex1-tabs-3" role="tabpanel" aria-labelledby="ex1-tab-3">
                        <form method="POST" action="${pageContext.request.contextPath}/ManageTransaction">
                            <p class="text-danger h1 fw-bold mt-4">Item Review <i class="fas fa-gift"></i></p>
                            <hr class="text-white">
                            <div class="row">
                                <div class="d-flex flex-column align-items-start mb-4 col">
                                    <h3 class="form-label text-white">Are you satisfied with the Item?</h3>
                                    <div class="item-ratings">
                                        <input type="radio" id="item-star5" name="item-rating" value="5"/>
                                        <label class="fas fa-star" data-mdb-toggle="tooltip" for="item-star5" title="Awesome" aria-hidden="true"></label>
                                        <input type="radio" id="item-star4" name="item-rating" value="4" />
                                        <label class="fas fa-star" data-mdb-toggle="tooltip" for="item-star4" title="Great" aria-hidden="true"></label>
                                        <input type="radio" id="item-star3" name="item-rating" value="3" />
                                        <label class="fas fa-star" data-mdb-toggle="tooltip" for="item-star3" title="Very Good" aria-hidden="true"></label>
                                        <input type="radio" id="item-star2" name="item-rating" value="2" />
                                        <label class="fas fa-star" data-mdb-toggle="tooltip" for="item-star2" title="Good" aria-hidden="true"></label>
                                        <input type="radio" id="item-star1" name="item-rating" value="1" />
                                        <label class="fas fa-star" data-mdb-toggle="tooltip" for="item-star1" title="Bad" aria-hidden="true"></label>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex flex-row align-items-center mb-4 col">
                                <div class="form-outline flex-fill mb-0">
                                    <h3 class="form-label text-white mb-2">Any feedbacks for the Item?</h3>
                                    <textarea id="itemFeedback" class="form-control form-outline text-white" name="itemFeedback" required 
                                              oninput="checkIReviewInputs()" rows="10" style="resize: none;"></textarea>
                                </div>
                            </div>
                            <div class="d-flex justify-content-end">
                                <input type="hidden" name="item-review-ratings" value="" id="item-review-ratings">
                                <input type="hidden" name="ops" value="itemFeedback">
                                <input type="hidden" name="transactionId" value="${param.id}">
                                <button type="submit" value="ManageTransaction" class="btn btn-primary p-3" style="font-size: 16px;" 
                                        id="itemSubmit" disabled>
                                    Submit Feedback
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- Tabs content -->
            </div>
        </section>

        <jsp:include page="../shared/backtotop.jsp" />
        <jsp:include page="../shared/music-player.jsp" />
        <jsp:include page="../nav/footer.jsp" />

        <!-- Alert -->
        <c:if test="${not empty custReviewSuccess or not empty selrReviewSuccess 
                      or not empty itemReviewSuccess}">
              <div class="alert alert-success" id="alert-success">
                  ${custReviewSuccess}
                  ${selrReviewSuccess}
                  ${itemReviewSuccess}
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
                initReviewDetails();
                disableInputs();
            };

            function initReviewDetails() {
            <c:forEach var="trans" items="${sessionScope.trans}">
                <c:if test="${trans.id == param.id}">
                if (${trans.itemRatings} > 0) {
                    var roundedItemRating = Math.min(5, Math.max(1, Math.round(${trans.itemRatings})));
                    var itemRadio = document.querySelector('input[name="item-rating"][value="' + roundedItemRating + '"]');
                    itemRadio.checked = true;
                }

                if (${trans.custRatings} > 0) {
                    var roundedCustRating = Math.min(5, Math.max(1, Math.round(${trans.custRatings})));
                    var custRadio = document.querySelector('input[name="customer-rating"][value="' + roundedCustRating + '"]');
                    custRadio.checked = true;
                }

                if (${trans.selrRatings} > 0) {
                    var roundedSelrRating = Math.min(5, Math.max(1, Math.round(${trans.selrRatings})));
                    var selrRadio = document.querySelector('input[name="seller-rating"][value="' + roundedSelrRating + '"]');
                    selrRadio.checked = true;
                }

                var itemFeedback = document.getElementById("itemFeedback");
                var custFeedback = document.getElementById("custFeedback");
                var selrFeedback = document.getElementById("selrFeedback");

                itemFeedback.value = "${trans.itemFeedback}";
                custFeedback.value = "${trans.custFeedback}";
                selrFeedback.value = "${trans.selrFeedback}";
                </c:if>
            </c:forEach>
            }

            function disableInputs() {
                var role = "${sessionScope.role}";

                if (role === "seller") {
                    // Item
                    var itemRatings = document.querySelector('.item-ratings');
                    var itemInputs = itemRatings.querySelectorAll('input');

                    itemInputs.forEach(function (input) {
                        input.disabled = true;
                    });

                    var itemFeedback = document.getElementById("itemFeedback");
                    itemFeedback.disabled = true;

                    // Customer
                    var customerRatings = document.querySelector('.customer-ratings');
                    var customerInputs = customerRatings.querySelectorAll('input');

                    customerInputs.forEach(function (input) {
                        input.disabled = true;
                    });

                    var customerFeedback = document.getElementById("custFeedback");
                    customerFeedback.disabled = true;
                } else if (role === "customer") {
                    //Seller
                    var sellerRatings = document.querySelector('.seller-ratings');
                    var sellerInputs = sellerRatings.querySelectorAll('input');

                    sellerInputs.forEach(function (input) {
                        input.disabled = true;
                    });

                    var sellerFeedback = document.getElementById("selrFeedback");
                    sellerFeedback.disabled = true;
                } else {
                    // Item
                    var itemRatings = document.querySelector('.item-ratings');
                    var itemInputs = itemRatings.querySelectorAll('input');

                    itemInputs.forEach(function (input) {
                        input.disabled = true;
                    });

                    var itemFeedback = document.getElementById("itemFeedback");
                    itemFeedback.disabled = true;

                    // Customer
                    var customerRatings = document.querySelector('.customer-ratings');
                    var customerInputs = customerRatings.querySelectorAll('input');

                    customerInputs.forEach(function (input) {
                        input.disabled = true;
                    });

                    var customerFeedback = document.getElementById("custFeedback");
                    customerFeedback.disabled = true;

                    //Seller
                    var sellerRatings = document.querySelector('.seller-ratings');
                    var sellerInputs = sellerRatings.querySelectorAll('input');

                    sellerInputs.forEach(function (input) {
                        input.disabled = true;
                    });

                    var sellerFeedback = document.getElementById("selrFeedback");
                    sellerFeedback.disabled = true;
                }
            }

            //Customer Review
            const custRatingRadios = document.getElementsByName('customer-rating');

            custRatingRadios.forEach(radio => {
                radio.addEventListener('click', () => {

                });
            });

            function checkCReviewInputs() {
                var feedback = document.getElementById("custFeedback").value;
                const ratingValue = document.querySelector('input[name="customer-rating"]:checked').value;
                var btnSubmit = document.getElementById("custSubmit");
                var hiddenRating = document.getElementById("cust-review-ratings");

                if (feedback && ratingValue) {
                    hiddenRating.value = ratingValue;
                    btnSubmit.disabled = false;
                } else {
                    btnSubmit.disabled = true;
                }
            }

            //Seller Review
            const selrRatingRadios = document.getElementsByName('seller-rating');

            selrRatingRadios.forEach(radio => {
                radio.addEventListener('click', () => {

                });
            });

            function checkSReviewInputs() {
                var feedback = document.getElementById("selrFeedback").value;
                const ratingValue = document.querySelector('input[name="seller-rating"]:checked').value;
                var btnSubmit = document.getElementById("selrSubmit");
                var hiddenRating = document.getElementById("selr-review-ratings");

                console.log(hiddenRating);

                if (feedback && ratingValue) {
                    hiddenRating.value = ratingValue;
                    btnSubmit.disabled = false;
                } else {
                    btnSubmit.disabled = true;
                }
            }

            //Item Review
            const itemRatingRadios = document.getElementsByName('item-rating');

            itemRatingRadios.forEach(radio => {
                radio.addEventListener('click', () => {

                });
            });

            function checkIReviewInputs() {
                var feedback = document.getElementById("itemFeedback").value;
                const ratingValue = document.querySelector('input[name="item-rating"]:checked').value;
                var btnSubmit = document.getElementById("itemSubmit");
                var hiddenRating = document.getElementById("item-review-ratings");

                if (feedback && ratingValue) {
                    hiddenRating.value = ratingValue;
                    btnSubmit.disabled = false;
                } else {
                    btnSubmit.disabled = true;
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
        background-image: url("https://mechanicalanimereviews.files.wordpress.com/2016/12/light-writing.jpg");
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

    .nav {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(3px);
    }

    .nav-tabs .nav-link {
        color: #fff;
    }

    .tab-content {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(3px);
        filter: drop-shadow(1px 2px 3px black);
    }

    .tab-pane {
        padding: 2rem;
    }

    .form-outline .form-control {
        border: 1px solid #bdbdbd;
    }

    .form-label {
        z-index: 2;
    }

    .form-notch {
        display: none !important;
    }


    .item-ratings, .customer-ratings, .seller-ratings {
        border: none;
        float: left;
    }

    .item-ratings > label {
        color: #90A0A3;
        float: right;
    }

    .item-ratings > label:before {
        margin: 5px;
        font-size: 2em;
        font-family: FontAwesome;
        content: "\f005";
        display: inline-block;
    }

    .item-ratings > input {
        display: none;
    }

    .item-ratings > input:checked ~ label,
    .item-ratings:not(:checked) > label:hover,
    .item-ratings:not(:checked) > label:hover ~ label {
        color: #F79426;
    }

    .item-ratings > input:checked + label:hover,
    .item-ratings > input:checked ~ label:hover,
    .item-ratings > label:hover ~ input:checked ~ label,
    .item-ratings > input:checked ~ label:hover ~ label {
        color: #FECE31;
    }

    .customer-ratings > label {
        color: #90A0A3;
        float: right;
    }

    .customer-ratings > label:before {
        margin: 5px;
        font-size: 2em;
        font-family: FontAwesome;
        content: "\f005";
        display: inline-block;
    }

    .customer-ratings > input {
        display: none;
    }

    .customer-ratings > input:checked ~ label,
    .customer-ratings:not(:checked) > label:hover,
    .customer-ratings:not(:checked) > label:hover ~ label {
        color: #F79426;
    }

    .customer-ratings > input:checked + label:hover,
    .customer-ratings > input:checked ~ label:hover,
    .customer-ratings > label:hover ~ input:checked ~ label,
    .customer-ratings > input:checked ~ label:hover ~ label {
        color: #FECE31;
    }

    .seller-ratings > label {
        color: #90A0A3;
        float: right;
    }

    .seller-ratings > label:before {
        margin: 5px;
        font-size: 2em;
        font-family: FontAwesome;
        content: "\f005";
        display: inline-block;
    }

    .seller-ratings > input {
        display: none;
    }

    .seller-ratings > input:checked ~ label,
    .seller-ratings:not(:checked) > label:hover,
    .seller-ratings:not(:checked) > label:hover ~ label {
        color: #F79426;
    }

    .seller-ratings > input:checked + label:hover,
    .seller-ratings > input:checked ~ label:hover,
    .seller-ratings > label:hover ~ input:checked ~ label,
    .seller-ratings > input:checked ~ label:hover ~ label {
        color: #FECE31;
    }

    textarea[disabled] {
        background-color: transparent !important;
    }
</style>

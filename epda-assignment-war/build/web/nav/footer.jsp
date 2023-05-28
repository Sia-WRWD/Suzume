<%-- 
    Document   : footer
    Created on : Mar 30, 2023, 1:54:42 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Footer</title>
    </head>
    <body>
        <footer class="text-center text-lg-start text-muted pt-3" style="background-color: #f5f5f5;">
            <!-- Section: Links  -->
            <section class="">
                <div class="container text-center text-md-start pt-4 pb-4">
                    <!-- Grid row -->   
                    <div class="row mt-3">
                        <!-- Grid column -->
                        <div class="col-12 col-lg-3 col-sm-12 mb-2">
                            <!-- Content -->
                            <a href="https://suzume-tojimari-movie.jp/" target="_blank" class="">
                                <img src="${pageContext.request.contextPath}/logo.png" height="35" />
                            </a>
                            <p class="mt-2 text-dark">
                                2023 © Copyright Suzume <br/>
                                Built using <a href="https://mdbootstrap.com/" target="_blank">Bootstrap MDB V5</a>
                            </p>
                        </div>
                        <!-- Grid column -->

                        <!-- Grid column -->
                        <div class="col-6 col-sm-4 col-lg-2">
                            <c:if test="${empty sessionScope.uname or sessionScope.role eq 'customer'}">
                                <!-- Links -->
                                <h6 class="text-uppercase text-dark fw-bold mb-2">
                                    Store
                                </h6>
                                <ul class="list-unstyled mb-4">
                                    <li><a class="text-muted" href="${pageContext.request.contextPath}/market/all-items.jsp">Marketplace</a></li>
                                    <li><a class="text-muted" href="${pageContext.request.contextPath}/market/categories.jsp">Categories</a></li>
                                    <li><a class="text-muted" href="https://suzume-tojimari-movie.jp/" target="_blank">Blogs</a></li>
                                </ul>
                            </c:if>
                        </div>
                        <!-- Grid column -->

                        <!-- Grid column -->
                        <div class="col-6 col-sm-4 col-lg-2">
                            <!-- Links -->
                            <h6 class="text-uppercase text-dark fw-bold mb-2">
                                Information
                            </h6>
                            <ul class="list-unstyled mb-4">
                                <c:if test="${empty sessionScope.uname}">
                                    <li><a class="text-muted" href="${pageContext.request.contextPath}/authentication/customer-register.jsp">
                                        Customer Sign Up
                                        </a>
                                    </li>
                                    <li><a class="text-muted" href="${pageContext.request.contextPath}/authentication/seller-register.jsp">
                                            Sell on Suzume
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${sessionScope.role eq 'customer'}">
                                    <li><a class="text-muted" href="${pageContext.request.contextPath}/shared/manage-transaction.jsp">
                                            Manage Transaction
                                        </a>
                                    </li>
                                    <li><a class="text-muted" href="${pageContext.request.contextPath}/shared/profile.jsp">
                                            Manage Account
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${sessionScope.role eq 'seller'}">
                                    <li><a class="text-muted" href="${pageContext.request.contextPath}/shared/manage-transaction.jsp">
                                            Manage Transactions
                                        </a>
                                    </li>
                                    <li><a class="text-muted" href="${pageContext.request.contextPath}/seller/manage-items.jsp">
                                            Manage Items
                                        </a>
                                    </li>
                                    <li><a class="text-muted" href="${pageContext.request.contextPath}/shared/profile.jsp">
                                            Manage Account
                                        </a>
                                    </li>
                                </c:if>
                                <c:if test="${sessionScope.role eq 'admin'}">
                                    <li><a class="text-muted" href="${pageContext.request.contextPath}/authentication/admin-register.jsp">
                                            Register Admin
                                        </a>
                                    </li>
                                    <li><a class="text-muted" href="${pageContext.request.contextPath}/admin/manage-user.jsp">
                                            Manage Users
                                        </a>
                                    </li>
                                    <li><a class="text-muted" href="${pageContext.request.contextPath}/shared/manage-transaction.jsp">
                                            Manage Transactions
                                        </a>
                                    </li>
                                    <li><a class="text-muted" href="${pageContext.request.contextPath}/seller/manage-items.jsp">
                                            Manage Items
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                        <!-- Grid column -->

                        <!-- Grid column -->
                        <div class="col-6 col-sm-4 col-lg-2">
                            <!-- Links -->
                            <h6 class="text-uppercase text-dark fw-bold mb-2">
                                Support
                            </h6>
                            <ul class="list-unstyled mb-4">
                                <li><a class="text-muted" href="https://www.youtube.com/watch?v=Bu8bH2P37kY&ab_channel=TacheMemes" target="_blank">
                                        Help Center
                                    </a>
                                </li>
                                <li><a class="text-muted" href="https://www.youtube.com/watch?v=1w_XuOBnUAg&ab_channel=HansKristian" target="_blank">
                                        Money Refund
                                    </a>
                                </li>
                                <li><a class="text-muted" href="https://media.tenor.com/-P-xeHYEY9QAAAAC/sad-pablo-lonely.gif" target="_blank">
                                        Shipping Info
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <!-- Grid column -->

                        <!-- Grid column -->
                        <div class="col-12 col-sm-12 col-lg-3">
                            <!-- Links -->
                            <h6 class="text-uppercase text-dark fw-bold mb-2">Newsletter</h6>
                            <p class="text-muted">Stay in touch with latest updates about our products and offers</p>
                            <div class="input-group mb-3">
                                <input type="email" class="form-control border" placeholder="Email" aria-label="Email" aria-describedby="button-addon2" />
                                <button class="btn btn-light border shadow-0" type="button" id="button-addon2" data-mdb-ripple-color="dark">
                                    Join
                                </button>
                            </div>
                        </div>
                        <!-- Grid column -->
                    </div>
                    <!-- Grid row -->
                </div>
            </section>
            <!-- Section: Links  -->

            <div class="">
                <div class="container">
                    <div class="d-flex justify-content-between py-4 border-top">
                        <!--- payment --->
                        <div>
                            <i class="fab fa-lg fa-cc-visa text-dark"></i>
                            <i class="fab fa-lg fa-cc-amex text-dark"></i>
                            <i class="fab fa-lg fa-cc-mastercard text-dark"></i>
                            <i class="fab fa-lg fa-cc-paypal text-dark"></i>
                        </div>
                        <!--- payment --->
                    </div>
                </div>
            </div>
        </footer>
    </body>
</html>
<style>
    /*    footer {
            position: absolute;
            bottom: 0;
            right: 0;
            left: 0;
        }*/
</style>

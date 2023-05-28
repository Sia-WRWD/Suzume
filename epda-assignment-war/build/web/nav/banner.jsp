<%-- 
    Document   : banner
    Created on : Mar 30, 2023, 1:54:35 PM
    Author     : Sia_RTX3070
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Banner</title>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>
    </head>
    <body>
        <header>
            <!-- Jumbotron -->
            <div class="p-3 text-center bg-primary border-bottom">
                <div class="container">
                    <div class="row gy-3">
                        <!-- Left elements -->
                        <div class="col-4">
                            <a href="${pageContext.request.contextPath}/home.jsp" class="float-start">
                                <img src="${pageContext.request.contextPath}/logo.png" height="35" class="logo"/>
                            </a>
                        </div>
                        <!-- Left elements -->

                        <!-- Center elements -->
                        <div class="order-lg-last col-8">
                            <div class="d-flex float-end text-white">
                                <c:if test="${empty sessionScope.uname}">
                                    <a href="${pageContext.request.contextPath}/authentication/login.jsp" class="btnHover me-1 border rounded py-1 px-3 nav-link d-flex align-items-center"> 
                                        <i class="fa fa-user m-1 me-md-2"></i><p class="d-none d-md-block mb-0">Sign in</p> 
                                    </a>
                                </c:if>
                                <c:if test="${not empty sessionScope.uname}">
                                    <a href="${pageContext.request.contextPath}/shared/profile.jsp" class="btnHover3 me-1 border rounded py-1 px-3 nav-link d-flex align-items-center"> 
                                        <i class="fa fa-user m-1 me-md-2"></i><p class="d-none d-md-block mb-0">My Profile</p> 
                                    </a>
                                </c:if>
                                <c:if test="${empty sessionScope.role or sessionScope.role eq 'customer'}">
                                    <a href="${pageContext.request.contextPath}/customer/cart.jsp" class="btnHover3 border rounded py-1 px-3 nav-link d-flex align-items-center"> 
                                        <i class="fa fa-shopping-cart m-1 me-md-2"></i><p class="d-none d-md-block mb-0">My Cart</p> 
                                    </a>
                                </c:if>
                                <c:if test="${not empty sessionScope.uname}">
                                    <form action="${pageContext.request.contextPath}/Logout" method="GET">
                                        <button class="btnHover border rounded ms-1 py-1 px-3 nav-link d-flex align-items-center" type="submit" value="Logout">
                                            <i class="fas fa-arrow-right-from-bracket m-1 me-md-2"></i> Logout
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                        <!-- Center elements -->
                    </div>
                </div>
            </div>
            <!-- Jumbotron -->

            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-light bg-white">
                <!-- Container wrapper -->
                <div class="container justify-content-center justify-content-md-between">
                    <!-- Toggle button -->
                    <button
                        class="navbar-toggler border py-2 text-dark"
                        type="button"
                        data-mdb-toggle="collapse"
                        data-mdb-target="#navbarLeftAlignExample"
                        aria-controls="navbarLeftAlignExample"
                        aria-expanded="false"
                        aria-label="Toggle navigation"
                        >
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Collapsible wrapper -->
                    <div class="collapse navbar-collapse" id="navbarLeftAlignExample">
                        <!-- Left links -->
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item">
                                <a class="nav-link text-dark" aria-current="page" href="${pageContext.request.contextPath}/home.jsp">Home</a>
                            </li>
                            <c:if test="${empty sessionScope.role or sessionScope.role eq 'customer'}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle text-dark" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true"aria-expanded="false">
                                        Market
                                    </a>
                                    <!-- Dropdown menu -->
                                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/market/categories.jsp">All Categories</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/market/all-items.jsp">All Items</a>
                                        </li>
                                    </ul>
                                </li>
                            </c:if>
                            <c:if test="${empty sessionScope.uname}">
                                <li class="nav-item">
                                    <a class="nav-link text-dark" href="${pageContext.request.contextPath}/authentication/seller-register.jsp">Sell on Suzume</a>
                                </li>
                            </c:if>
                            <c:if test="${not empty sessionScope.uname && sessionScope.role eq 'admin'}">
                                <li class="nav-item">
                                    <a class="nav-link text-dark" href="${pageContext.request.contextPath}/authentication/admin-register.jsp">Register Admin</a>
                                </li>
                            </c:if>
                            <c:if test="${not empty sessionScope.uname && sessionScope.role eq 'admin'}">
                                <li class="nav-item">
                                    <a class="nav-link text-dark" href="${pageContext.request.contextPath}/admin/manage-user.jsp">Manage Users</a>
                                </li>
                            </c:if>
                            <c:if test="${not empty sessionScope.uname && (sessionScope.role eq 'seller' or sessionScope.role eq 'admin')}">
                                <li class="nav-item">
                                    <a class="nav-link text-dark" href="${pageContext.request.contextPath}/seller/manage-items.jsp">Manage Items</a>
                                </li>
                            </c:if>
                            <c:if test="${not empty sessionScope.uname}">
                                <li class="nav-item">
                                    <a class="nav-link text-dark" href="${pageContext.request.contextPath}/shared/manage-transaction.jsp">
                                        Manage Transactions
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                        <!-- Left links -->
                    </div>
                </div>
                <!-- Container wrapper -->
            </nav>
            <!-- Navbar -->
        </header>
    </body>
</html>
<style>
    .logo {
        filter: invert(1) drop-shadow(1px 2px 3px black);
        transition: 0.3s ease-in-out;
    }

    .logo:hover {
        filter: invert(0) drop-shadow(1px 2px 3px white);
    }

    .btnHover {
        background: #fff !important;
        color: #3b71ca !important;
    }

    .btnHover:hover {
        background: #3b71ca !important;
        color: #fff !important;
        transition: 0.3s ease-in-out;
    }

    .navbar {
        padding: 0 !important;
    }

    .nav-link {
        padding: 10px 0px;
    }

    .nav-link:hover, .dropdown-item:hover {
        background: #3b71ca !important;
        color: #fff !important;
        transition: 0.3s ease-in-out;
    }

    .btnHover3 {
        transition: 0.3s ease-in-out;
    }

    .btnHover3:hover {
        background: #fff !important;;
        color: #3b71ca !important;
    }

    .dropdown-divider {
        margin: 0;
    }

    .dropdown-menu {
        z-index: 999;
    }
</style>

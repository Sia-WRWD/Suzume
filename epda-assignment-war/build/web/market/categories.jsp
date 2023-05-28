<%-- 
    Document   : categories
    Created on : Apr 3, 2023, 12:25:06 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Categories</title>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.css" rel="stylesheet"/>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>
        <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon"/>
    </head>
    <body>

        <jsp:include page="../nav/banner.jsp" />

        <section class="bg h-100">
            <div class="container py-5 h-100 col-12 d-flex flex-column" style="position: relative; z-index: 3;">
                <div class="container d-flex justify-content-between col-12 h-100">
                    <div class="row h-100 col-4">
                        <div class="col-md-12 col-xl-12 mb-4">
                            <div class="card text-center d-flex justify-content-center flex-column text-white">

                                <img class="bg-image cat-img" src="https://images.goodsmile.info/cgm/images/product/20221124/13590/107692/large/efc502d2ea6f2bc8ab1f01629699714e.jpg">

                                <div class="card-description d-flex flex-column justify-content-end text-start p-4">
                                    <div class="h4 card-description-title mb-2">
                                        Figurines
                                    </div>
                                    <p class=" card-description-description mb-2">
                                        Anime-inspired collectible figures for fans and collectors.
                                    </p>
                                    <div class="card-description-btn">
                                        <a href="${pageContext.request.contextPath}/FilterItems?category=Figurine" class="btn btn-primary">View More</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="row h-100 col-4">
                        <div class="col-md-12 col-xl-12 mb-4">
                            <div class="card text-center d-flex justify-content-center flex-column text-white">

                                <img class="bg-image cat-img" src="https://m.media-amazon.com/images/I/715ftyyuJUL._AC_SX425_.jpg">

                                <div class="card-description d-flex flex-column justify-content-end text-start p-4">
                                    <div class="h4 card-description-title mb-2">
                                        Posters
                                    </div>
                                    <p class=" card-description-description mb-2">
                                        Decorate your walls with your favorite anime characters.
                                    </p>
                                    <div class="card-description-btn">
                                        <a href="${pageContext.request.contextPath}/FilterItems?category=Poster" class="btn btn-primary">View More</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="row h-100 col-4">
                        <div class="col-md-12 col-xl-12 mb-4">
                            <div class="card text-center d-flex justify-content-center flex-column text-white">

                                <img class="bg-image cat-img" src="https://i.ebayimg.com/images/g/9w4AAOSwBgxdkZBZ/s-l500.jpg">

                                <div class="card-description d-flex flex-column justify-content-end text-start p-4">
                                    <div class="h4 card-description-title mb-2">
                                        Badges
                                    </div>
                                    <p class=" card-description-description mb-2">
                                        Show off your love for your favorite anime series with these stylish badges.
                                    </p>
                                    <div class="card-description-btn">
                                        <a href="${pageContext.request.contextPath}/FilterItems?category=Badge" class="btn btn-primary">View More</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="container d-flex justify-content-between col-12">
                    <div class="row h-100 col-4">
                        <div class="col-md-12 col-xl-12 ">
                            <div class="card text-center d-flex justify-content-center flex-column text-white">

                                <img class="bg-image cat-img" src="https://cf.shopee.com.my/file/7aac4dc0feebd70e36c263e65b7f5d7e">

                                <div class="card-description d-flex flex-column justify-content-end text-start p-4">
                                    <div class="h4 card-description-title mb-2">
                                        Plushies
                                    </div>
                                    <p class=" card-description-description mb-2">
                                        Collect your favorite anime characters as soft and cuddly plushies.
                                    </p>
                                    <div class="card-description-btn">
                                        <a href="${pageContext.request.contextPath}/FilterItems?category=Plushy" class="btn btn-primary">View More</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="row h-100 col-4">
                        <div class="col-md-12 col-xl-12 ">
                            <div class="card text-center d-flex justify-content-center flex-column text-white">

                                <img class="bg-image cat-img" src="https://jw-webmagazine.com/wp-content/uploads/2020/07/Best-Light-Novels.jpg">

                                <div class="card-description d-flex flex-column justify-content-end text-start p-4">
                                    <div class="h4 card-description-title mb-2">
                                        Light Novels
                                    </div>
                                    <p class=" card-description-description mb-2">
                                        Immerse yourself in the world of your favorite anime series with these light novels.
                                    </p>
                                    <div class="card-description-btn">
                                        <a href="${pageContext.request.contextPath}/FilterItems?category=Light-Novel" class="btn btn-primary">View More</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="row h-100 col-4">
                        <div class="col-md-12 col-xl-12 ">
                            <div class="card text-center d-flex justify-content-center flex-column text-white">

                                <img class="bg-image cat-img" src="https://down-my.img.susercontent.com/file/a0047cdc9b63852fb33d16377afb3b30_tn">

                                <div class="card-description d-flex flex-column justify-content-end text-start p-4">
                                    <div class="h4 card-description-title mb-2">
                                        T-Shirts
                                    </div>
                                    <p class=" card-description-description mb-2">
                                        Anime-inspired graphic tees for fans and collectors, featuring your favorite characters and moments from popular series.
                                    </p>
                                    <div class="card-description-btn">
                                        <a href="${pageContext.request.contextPath}/FilterItems?category=T-Shirt" class="btn btn-primary">View More</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <jsp:include page="../shared/backtotop.jsp" />
        <jsp:include page="../shared/music-player.jsp" />
        <jsp:include page="../nav/footer.jsp" />
    </body>
</html>
<style>
    .bg {
        background-image: url("./bg.jpg");
        background-repeat: no-repeat;
        background-size: cover;
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

    .cat-img {
        border-radius: 15px !important;
        height: 350px;
        background-position: center;
        object-fit: cover;
        background-attachment: fixed;
    }

    .card {
        border-radius: 15px !important;
        transition: 0.4s ease-out;
    }

    .card:hover {
        transform: translateY(20px);   
    }

    .card:hover:after {
        opacity: 1;
    }

    .card:hover .card-description {
        opacity: 1;
        transform: translateY(0px);
    }

    .card:after {
        display: block;
        content: '';
        position: absolute;
        left: 0px;
        top: 0px;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        border-radius: 15px;
        transition: 0.5s;
        opacity: 0;
    }

    .card-description {
        opacity: 0;
        position: absolute;
        bottom: 0;
        height: 100%;
        z-index: 3;
        transform: translateY(30px);
        transition: 0.5s;
        text-shadow: 1px 2px 3px black;
    }

    /*Reference Code: https://codepen.io/Gelsot/pen/xpGYyd*/
</style>

<%-- 
    Document   : add-items
    Created on : Apr 3, 2023, 4:13:30 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Item</title>
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
            <%
                response.sendRedirect("/epda-assignment-war/authentication/login.jsp");
            %>
        </c:if>
        <c:if test="${not empty sessionScope.uname && sessionScope.role ne 'seller'}">
            <%
                response.sendRedirect("/epda-assignment-war/home.jsp");
            %>
        </c:if>

        <jsp:include page="../nav/banner.jsp" />

        <section class="h-100 bg py-4">
            <div class="container vh-100 d-flex justify-content-center align-items-center" style="position: relative; z-index: 2;">
                <div class="row w-100">
                    <div class="col-lg-12 col-xl-11">
                        <div class="card card-bg text-white" style="border-radius: 25px;">
                            <div class="card-body p-md-5">
                                <div class="btn btn-danger" style="width:fit-content; height: fit-content;">
                                    <a href="${pageContext.request.contextPath}/seller/manage-items.jsp" style="color: white; font-size: 1rem;">
                                        <i class="fa fa-arrow-left"></i>
                                    </a>
                                </div>
                                <div class="row justify-content-center">
                                    <div class="col-12">

                                        <p class="text-start h1 fw-bold mb-4 mx-1 mx-md-4 mt-4">Add New Item</p>

                                        <form class="mx-1 mx-md-4" method="POST" action="${pageContext.request.contextPath}/Item">

                                            <div class="row">
                                                <div class="d-flex flex-row align-items-center mb-4 col">
                                                    <i class="fas fa-gifts fa-lg me-2 fa-fw"></i>
                                                    <div class="form-outline flex-fill mb-0">
                                                        <input type="text" id="item-name" class="form-control text-white" name="item-name" required 
                                                               oninput="checkInputs()"/>
                                                        <label class="form-label text-white" for="item-name">Item Name</label>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-row align-items-center mb-4 col ms-1">
                                                    <i class="fas fa-clipboard-list fa-lg me-2 fa-fw"></i>
                                                    <div class="form-outline flex-fill mb-0">
                                                        <select class="form-control text-white" id="category" onchange="checkInputs()" name="category">
                                                            <option class="text-black" value="Figurine">Figurine</option>
                                                            <option class="text-black" value="Poster">Poster</option>
                                                            <option class="text-black" value="Badge">Badge</option>
                                                            <option class="text-black" value="Plushy">Plushy</option>
                                                            <option class="text-black" value="Light-Novel">Light Novel</option>
                                                            <option class="text-black" value="T-Shirt">T-Shirt</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="d-flex flex-row align-items-center mb-4 col">
                                                <i class="fas fa-file-lines fa-lg me-2 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <textarea id="item-desc" class="form-control text-white" name="item-desc" required 
                                                              oninput="checkInputs()" rows="3" style="resize: none;"></textarea>
                                                    <label class="form-label text-white" for="item-desc">Item Description</label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="d-flex flex-row align-items-center mb-4 col">
                                                    <i class="fas fa-tags fa-lg me-2 fa-fw"></i>
                                                    <div class="form-outline flex-fill mb-0">
                                                        <input type="text" id="item-price" class="form-control text-white" name="item-price" required 
                                                               oninput="checkInputs()"/>
                                                        <label class="form-label text-white" for="item-price">Unit Price (x.xx)</label>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-row align-items-center mb-4 col">
                                                    <i class="fas fa-box fa-lg me-2 fa-fw"></i>
                                                    <div class="form-outline flex-fill mb-0">
                                                        <input type="text" id="ava-qty" class="form-control text-white" name="ava-qty" required 
                                                               oninput="checkInputs()"/>
                                                        <label class="form-label text-white" for="ava-qty">Available Quantity (x)</label>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-row align-items-center mb-4 col">
                                                    <i class="fas fa-truck fa-lg me-1 fa-fw"></i>
                                                    <div class="form-outline flex-fill mb-0">
                                                        <select class="form-control text-white" id="deli-type" onchange="checkInputs()" name="deli-type">
                                                            <option class="text-black" value="Free">Free</option>
                                                            <option class="text-black" value="Standard">Standard (RM 3.00)</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="d-flex flex-row align-items-center mb-4 col">
                                                <i class="fas fa-images fa-lg me-1 fa-fw"></i>
                                                <div class="form-outline flex-fill mb-0">
                                                    <input type="text" id="img-url" class="form-control text-white" name="img-url" required 
                                                           oninput="checkInputs()"/>
                                                    <label class="form-label text-white" for="img-url">Image Url</label>
                                                </div>
                                            </div>
                                            <input type="hidden" name="operation" value="add">

                                            <div class="d-flex justify-content-end mb-3 mb-lg-4">
                                                <button type="submit" value="Items" class="btn btn-primary btn-lg" id="itemSubmit" disabled>Add Item</button>
                                            </div>

                                        </form>
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

        <!-- Alert -->
        <c:if test="${not empty addItemSuccess}">
            <div class="alert alert-success" id="alert-success">
                ${addItemSuccess}
                <i class="far fa-circle-check" style="font-size: 25px; margin-left: 10px;"></i>
            </div>
        </c:if>

        <c:if test="${not empty otherError}">
            <div class="alert alert-danger" id="alert-error">
                ${registerationError}
                ${otherError}
                <i class="far fa-circle-xmark" style="font-size: 25px; margin-left: 10px;"></i>
            </div>
        </c:if>
        <!-- Alert -->

        <script type="text/javascript">
            function checkInputs() {

                var itemName = document.getElementById("item-name").value;
                var itemDesc = document.getElementById("item-desc").value;
                var avaQty = document.getElementById("ava-qty").value;
                var unitPrice = document.getElementById("item-price").value;
                var category = document.getElementById("category").value;
                var deliType = document.getElementById("deli-type").value;
                var itemPicURL = document.getElementById("img-url").value;
                var btnSubmit = document.getElementById("itemSubmit");

                if (itemName && itemDesc && avaQty && unitPrice
                        && category && deliType && itemPicURL) {
                    var validItemName = validateStringInput(itemName);
                    var validItemDesc = validateStringInput(itemDesc);
                    var validAvaQty = validateIntegerInput(avaQty);
                    var validUnitPrice = validateUnitPrice(unitPrice);
                    var validItemPicUrl = validateItemPicURL(itemPicURL);

                    console.log(validItemName, validItemDesc, validAvaQty, validUnitPrice, validItemPicUrl);

                    if (validItemName && validItemDesc && validAvaQty
                            && validUnitPrice && validItemPicUrl) {
                        btnSubmit.disabled = false;
                    } else {
                        btnSubmit.disabled = true;
                    }
                }

            }

            function validateStringInput(input) {
                if (/^[a-zA-Z0-9.,!?'"()\s-]*$/.test(input)) {
                    return true;
                } else {
                    return false;
                }
            }

            function validateIntegerInput(input) {
                if (/^[0-9]+$/.test(input)) {
                    return true;
                } else {
                    return false;
                }
            }

            function validateUnitPrice(input) {
                if (/^\d+(\.\d{1,2})?$/.test(input)) {
                    return true;
                } else {
                    return false;
                }
            }


            function validateItemPicURL(input) {
                if (/^(https?:\/\/)?[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?\.(jpg|jpeg|png)(\?.*)?$/.test(input)) {
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
        background-image: url("https://picstatio.com/large/3669e5/anime-girl-Ika-Musume-curious.jpg");
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
</style>

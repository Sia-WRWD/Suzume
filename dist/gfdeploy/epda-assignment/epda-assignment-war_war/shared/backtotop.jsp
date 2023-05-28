<%-- 
    Document   : backtotop
    Created on : Mar 30, 2023, 10:30:52 PM
    Author     : Sia_RTX3070
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <button
            type="button"
            class="btn btn-danger btn-floating btn-lg"
            id="btn-back-to-top"
            >
            <i class="fa fa-arrow-up"></i>
        </button>
        <script>
            //Get the button
            let mybutton = document.getElementById("btn-back-to-top");

            // When the user scrolls down 20px from the top of the document, show the button
            window.onscroll = function () {
                scrollFunction();
            };

            function scrollFunction() {
                if (
                        document.body.scrollTop > 20 ||
                        document.documentElement.scrollTop > 20
                        ) {
                    mybutton.style.display = "block";
                } else {
                    mybutton.style.display = "none";
                }
            }

            // When the user clicks on the button, scroll to the top of the document
            mybutton.addEventListener("click", backToTop);

            function backToTop() {
                document.body.scrollTop = 0;
                document.documentElement.scrollTop = 0;
            }
        </script>
    </body>
</html>
<style>
    #btn-back-to-top {
        position: fixed;
        bottom: 30px;
        right: 20px;
        border-radius: 50%;
        z-index: 2;
    }
</style>

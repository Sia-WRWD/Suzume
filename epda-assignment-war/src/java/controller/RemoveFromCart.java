/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;

/**
 *
 * @author Sia_RTX3070
 */
@WebServlet(name = "RemoveFromCart", urlPatterns = {"/RemoveFromCart"})
public class RemoveFromCart extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
                // Retrieve cart from session
            HttpSession session = request.getSession(true);
            List<Cart> cart = (List<Cart>) session.getAttribute("cart");

            // Get item ID to remove
            String itemId = request.getParameter("itemId");

            // Remove item from cart
            cart.removeIf(item -> item.getId().equals(itemId));

                        //Calculate Cart Total
            double total = 0.0;
            for (Cart c: cart) {
                total += c.getPrice() * c.getQuantity();
            }
            session.removeAttribute("cartTotal");
            session.setAttribute("cartTotal", total);
            
            //Calculate Shipping Total
            double shippingTotal = 0.0;
            for (Cart c: cart) {
                if (c.getDeliveryType().equals("Standard")) {
                    shippingTotal += 3;
                } else {
                    shippingTotal += 0;
                }
            }
            session.removeAttribute("shippingTotal");
            session.setAttribute("shippingTotal", shippingTotal);
            
            //Calculate Final Total
            double finalTotal = 0.0;
            finalTotal = total + shippingTotal;
            session.removeAttribute("finalTotal");
            session.setAttribute("finalTotal", finalTotal);
            
            // Redirect to cart page
            request.setAttribute("removeItemFromCartSuccess", "Item has been removed from your cart!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("customer/cart.jsp");
            dispatcher.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

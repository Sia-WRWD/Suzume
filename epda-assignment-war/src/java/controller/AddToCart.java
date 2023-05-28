/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;
import model.Items;
import model.ItemsFacade;

/**
 *
 * @author Sia_RTX3070
 */
@WebServlet(name = "AddToCart", urlPatterns = {"/AddToCart"})
public class AddToCart extends HttpServlet {

    @EJB
    private ItemsFacade itemsFacade;

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
            // Retrieve cart from session or create a new one if not exists
            try {
                HttpSession session = request.getSession(true);
                List<Cart> cart = (List<Cart>) session.getAttribute("cart");
                if (cart == null) {
                    cart = new ArrayList<>();
                    session.setAttribute("cart", cart);
                }

                // Get item details from form & itemFacade
                String itemId = request.getParameter("itemId");
                int itemQty = Integer.parseInt(request.getParameter("itemQty"));
                Items itemFound = itemsFacade.find(itemId);

                // Check if item is already in cart
                boolean itemExists = false;
                for (Cart c : cart) {
                    if (c.getId().equals(itemId)) {
                        int newQty = c.getQuantity() + itemQty;
                        
                        if (newQty > itemFound.getAvailableQuantity()) {
                            c.setQuantity(itemFound.getAvailableQuantity());
                        } else {
                            c.setQuantity(newQty);
                        }
                        
                        itemExists = true;
                        break;
                    }
                }

                // Add item to cart if it doesn't exist
                if (!itemExists) {
                    Cart item = new Cart();
                    item.setId(itemId);
                    item.setName(itemFound.getName());
                    item.setPrice(itemFound.getUnitPrice());
                    item.setQuantity(itemQty);
                    item.setImgUrl(itemFound.getImgUrl());
                    item.setCategory(itemFound.getCategory());
                    item.setDeliveryType(itemFound.getDeliveryType());
                    cart.add(item);
                }

                //Calculate Cart Total
                double total = 0.0;
                for (Cart c : cart) {
                    total += c.getPrice() * c.getQuantity();
                }
                session.setAttribute("cartTotal", total);

                //Calculate Shipping Total
                double shippingTotal = 0.0;
                for (Cart c : cart) {
                    if (c.getDeliveryType().equals("Standard")) {
                        shippingTotal += 3;
                    } else {
                        shippingTotal += 0;
                    }
                }
                session.setAttribute("shippingTotal", shippingTotal);

                //Calculate Final Total
                double finalTotal = 0.0;
                finalTotal = total + shippingTotal;
                session.setAttribute("finalTotal", finalTotal);

                // Redirect to cart page
                request.setAttribute("addItemToCartSuccess", "Item has been added to your cart!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("customer/cart.jsp");
                dispatcher.forward(request, response);
            } catch (IllegalArgumentException e) {
                request.setAttribute("otherError", "Some Error has Occured, Please try again later!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("customer/cart.jsp");
                dispatcher.forward(request, response);
            }
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

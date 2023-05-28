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
import model.Items;
import model.ItemsFacade;

/**
 *
 * @author Sia_RTX3070
 */
@WebServlet(name = "FilterItems", urlPatterns = {"/FilterItems"})
public class FilterItems extends HttpServlet {

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
            String category = request.getParameter("category");
            List<Items> itemList = itemsFacade.findAll();
            List<Items> filteredList = new ArrayList<>();

            try {
                if (category.equals("all")) {
                    request.removeAttribute("filteredList");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("market/all-items.jsp");
                    dispatcher.forward(request, response);
                }

                for (Items item : itemList) {
                    if (item.getCategory().equals(category)) {
                        filteredList.add(item);
                    }
                }

                request.setAttribute("filteredList", filteredList);
                RequestDispatcher dispatcher = request.getRequestDispatcher("market/all-items.jsp");
                dispatcher.forward(request, response);
            } catch (Exception e) {
                request.setAttribute("otherError", "Some Error has Occured, Please try again later!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("market/all-items.jsp");
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

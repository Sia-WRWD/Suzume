/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CustomerAccount;
import model.CustomerAccountFacade;
import model.Items;
import model.ItemsFacade;
import model.SellerAccount;
import model.SellerAccountFacade;

/**
 *
 * @author Sia_RTX3070
 */
@WebServlet(name = "GetAllBest", urlPatterns = {"/GetAllBest"})
public class GetAllBest extends HttpServlet {

    @EJB
    private CustomerAccountFacade customerAccountFacade;

    @EJB
    private SellerAccountFacade sellerAccountFacade;

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
            try {
                HttpSession s = request.getSession();

                List<Items> itemList = itemsFacade.findAll();
                double bestItemRating = itemList.get(0).getRatings();
                double bestItemPrice = itemList.get(0).getUnitPrice();
                Items bestItem = itemList.get(0);

                List<SellerAccount> sellerList = sellerAccountFacade.findAll();
                double bestSellerRating = sellerList.get(0).getRatings();
                SellerAccount bestSeller = sellerList.get(0);

                List<CustomerAccount> customerList = customerAccountFacade.findAll();
                double bestCustomerRating = customerList.get(0).getRatings();
                CustomerAccount bestCustomer = customerList.get(0);

                for (int i = 1; i < sellerList.size(); i++) {
                    SellerAccount currentSeller = sellerList.get(i);
                    double currentRating = currentSeller.getRatings();
                    int currentTransactions = currentSeller.getTransactionList().size();
                    if (currentRating > bestSellerRating || (currentRating == bestSellerRating && currentTransactions > bestSeller.getTransactionList().size())) {
                        bestSellerRating = currentRating;
                        bestSeller = currentSeller;
                    }
                }

                for (int i = 1; i < customerList.size(); i++) {
                    CustomerAccount currentCustomer = customerList.get(i);
                    double currentRating = currentCustomer.getRatings();
                    int currentTransactions = currentCustomer.getTransactionList().size();
                    if (currentRating > bestCustomerRating || (currentRating == bestCustomerRating && currentTransactions > bestCustomer.getTransactionList().size())) {
                        bestCustomerRating = currentRating;
                        bestCustomer = currentCustomer;
                    }
                }

                for (int i = 1; i < itemList.size(); i++) {
                    Items currentItem = itemList.get(i);
                    double currentPrice = currentItem.getUnitPrice();
                    double currentRating = currentItem.getSeller().getRatings();
                    int currentTransactions = currentItem.getTransactions().size();
                    if (currentPrice > bestItemPrice || (currentPrice == bestItemPrice && (currentRating > bestItemRating || (currentRating == bestItemRating && currentTransactions > bestItem.getTransactions().size())))) {
                        bestItemPrice = currentPrice;
                        bestItemRating = currentRating;
                        bestItem = currentItem;
                    }
                }

                s.setAttribute("bestSeller", bestSeller);
                s.setAttribute("bestCustomer", bestCustomer);
                s.setAttribute("bestItem", bestItem);
            } catch (Exception e) {

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

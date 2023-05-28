/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.AdminAccount;
import model.AdminAccountFacade;
import model.CustomerAccount;
import model.CustomerAccountFacade;
import model.SellerAccount;
import model.SellerAccountFacade;
import model.TransactionRecords;
import model.TransactionRecordsFacade;

/**
 *
 * @author Sia_RTX3070
 */
@WebServlet(name = "GetViewProfileDetails", urlPatterns = {"/GetViewProfileDetails"})
public class GetViewProfileDetails extends HttpServlet {

    @EJB
    private AdminAccountFacade adminAccountFacade;

    @EJB
    private CustomerAccountFacade customerAccountFacade;

    @EJB
    private TransactionRecordsFacade transactionRecordsFacade;

    @EJB
    private SellerAccountFacade sellerAccountFacade;

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
            String accountId = request.getParameter("accountId");
            String role = request.getParameter("role");
            String loca = request.getParameter("loca");
            ArrayList<TransactionRecords> transactionRecords = new ArrayList<>();

            try {
                if (role.equals("seller")) {
                    SellerAccount seller = sellerAccountFacade.find(accountId);
                    transactionRecords = seller.getTransactionList();
                    
                    request.setAttribute("vpAccd", seller);
                    request.setAttribute("vpTrans", transactionRecords);

                } else if (role.equals("customer")) {
                    CustomerAccount cust = customerAccountFacade.find(accountId);
                    transactionRecords = cust.getTransactionList();

                    request.setAttribute("vpAccd", cust);
                    request.setAttribute("vpTrans", transactionRecords);
                }
                
                request.setAttribute("vpRole", role);
                RequestDispatcher dispatcher = request.getRequestDispatcher("shared/view-profile.jsp");
                dispatcher.forward(request, response);
            } catch (Exception e) {
                if (loca.equals("market")) {
                    RequestDispatcher dispatcher = request.getRequestDispatcher("shared/view-profile.jsp");
                    dispatcher.forward(request, response);
                } else if (loca.equals("manageTransaction")) {
                    RequestDispatcher dispatcher = request.getRequestDispatcher("shared/manage-transaction.jsp");
                    dispatcher.forward(request, response);
                } else if (loca.equals("home")) {
                    RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
                    dispatcher.forward(request, response);
                }
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

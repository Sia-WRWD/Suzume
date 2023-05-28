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
import model.CustomerAccount;
import model.CustomerAccountFacade;
import model.Items;
import model.ItemsFacade;
import model.SellerAccount;
import model.SellerAccountFacade;
import model.TransactionRecords;
import model.TransactionRecordsFacade;
import model.UserInfo;
import model.UserInfoFacade;

/**
 *
 * @author Sia_RTX3070
 */
@WebServlet(name = "ManageTransaction", urlPatterns = {"/ManageTransaction"})
public class ManageTransaction extends HttpServlet {

    @EJB
    private ItemsFacade itemsFacade;

    @EJB
    private CustomerAccountFacade customerAccountFacade;

    @EJB
    private SellerAccountFacade sellerAccountFacade;

    @EJB
    private UserInfoFacade userInfoFacade;

    @EJB
    private TransactionRecordsFacade transactionRecordsFacade;

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
            String ops = request.getParameter("ops");
            String transactionId = request.getParameter("transactionId");
            ArrayList<TransactionRecords> transactionRecords = new ArrayList<>();
            RequestDispatcher dispatcher = null;
            HttpSession s = request.getSession(false);
            String uname = (String) s.getAttribute("uname");
            double ratings = 0.0;
            String feedback = "";
            
            switch (ops) {
                case "collection":
                    try {
                        TransactionRecords transaction = transactionRecordsFacade.find(transactionId);
                        transaction.setSellerCollectionStatus("Completed");
                        transactionRecordsFacade.edit(transaction);
                        
                        UserInfo found = userInfoFacade.find(uname);
                        transactionRecords = found.getSeller().get(0).getTransactionList();
                        s.removeAttribute("trans");
                        s.setAttribute("trans", transactionRecords);
                        
                    } catch (Exception e) {
                        request.setAttribute("otherError", "Some Error has Occured, Please try again later!");
                        dispatcher = request.getRequestDispatcher("shared/manage-transaction.jsp");
                        dispatcher.forward(request, response);
                    }   
                    
                    request.setAttribute("collectionSuccess", "Collection Success! Funds will be deposited to your Bank Account soon.");
                    dispatcher = request.getRequestDispatcher("shared/manage-transaction.jsp");
                    dispatcher.forward(request, response);
                    break;
                case "custFeedback":
                    try {
                        // Update Transaction Ratings & Feedback & Status
                        feedback = request.getParameter("custFeedback");
                        ratings = Double.parseDouble(request.getParameter("cust-review-ratings"));
                        
                        TransactionRecords transaction = transactionRecordsFacade.find(transactionId);
                        transaction.setCustStatus("Completed");
                        transaction.setCustRatings(ratings);
                        transaction.setCustFeedback(feedback);
                        transactionRecordsFacade.edit(transaction);
                        
                        UserInfo found = userInfoFacade.find(uname);
                        transactionRecords = found.getCust().get(0).getTransactionList();
                        s.removeAttribute("trans");
                        s.setAttribute("trans", transactionRecords);
                        
                        //Update Seller's Ratings
                        SellerAccount selr = sellerAccountFacade.find(transaction.getSeller().getId()); //Get Seller
                        ArrayList<TransactionRecords> allSelrTrans = selr.getTransactionList(); //Get List of Transactions
                        int totalTransaction = allSelrTrans.size(); //Get Total Number of Transaction
                        int validTotalTransaction = 0;
                        double sumOfRatings = 0.0;
                        if (totalTransaction < 2 && selr.getRatings() == 0) {
                            selr.setRatings(ratings);
                            sellerAccountFacade.edit(selr);
                        } else {
                            for (TransactionRecords t: allSelrTrans) { //Sum up rating for each transaction.
                                sumOfRatings += t.getSelrRatings();
                                if (t.getSelrRatings() > 0) {
                                    validTotalTransaction += 1;
                                }
                            }
                        
                            double newRating = sumOfRatings / validTotalTransaction;
                            selr.setRatings(newRating);
                            sellerAccountFacade.edit(selr);   
                        }
                        
                        //Reset Item Details
                        List<Items> allItemList = itemsFacade.findAll();
                        s.removeAttribute("allItemList");
                        s.setAttribute("allItemList", allItemList);
                        
                    } catch (Exception e) {
                        request.setAttribute("otherError", "Some Error has Occured, Please try again later!");
                        dispatcher = request.getRequestDispatcher("shared/review.jsp?id=" + transactionId);
                        dispatcher.forward(request, response);
                    }
                    
                    request.setAttribute("custReviewSuccess", "Thank you for your Feedback!");
                    dispatcher = request.getRequestDispatcher("shared/review.jsp?id=" + transactionId);
                    dispatcher.forward(request, response);
                    break;
                case "selrFeedback":
                    try {
                        // Update Transaction Ratings & Feedback & Status
                        feedback = request.getParameter("selrFeedback");
                        ratings = Double.parseDouble(request.getParameter("selr-review-ratings"));
                        
                        TransactionRecords transaction = transactionRecordsFacade.find(transactionId);
                        transaction.setSellerStatus("Completed");
                        transaction.setSelrRatings(ratings);
                        transaction.setSelrFeedback(feedback);
                        transactionRecordsFacade.edit(transaction);
                        
                        UserInfo found = userInfoFacade.find(uname);
                        transactionRecords = found.getSeller().get(0).getTransactionList();
                        s.removeAttribute("trans");
                        s.setAttribute("trans", transactionRecords);
                        
                        //Update Customer's Ratings
                        CustomerAccount cust = customerAccountFacade.find(transaction.getCustomer().getId()); //Get Customer
                        ArrayList<TransactionRecords> allCustTrans = cust.getTransactionList(); //Get List of Transactions
                        int totalTransaction = allCustTrans.size(); //Get Total Number of Transaction
                        int validTotalTransaction = 0;
                        double sumOfRatings = 0.0;
                        if (totalTransaction < 2 && cust.getRatings() == 0) { //Checks if it's customer's first transaction?
                            cust.setRatings(ratings);
                            customerAccountFacade.edit(cust);
                        } else {
                            for (TransactionRecords t: allCustTrans) { //Sum up rating for each transaction.
                                sumOfRatings += t.getCustRatings();
                                if (t.getCustRatings() > 0) {
                                    validTotalTransaction += 1;
                                }
                            }
                        
                            double newRating = sumOfRatings / validTotalTransaction;
                            cust.setRatings(newRating);
                            customerAccountFacade.edit(cust);
                        }
                        
                    } catch (Exception e) {
                        request.setAttribute("otherError", "Some Error has Occured, Please try again later!");
                        dispatcher = request.getRequestDispatcher("shared/review.jsp?id=" + transactionId);
                        dispatcher.forward(request, response);
                    }
                    
                    request.setAttribute("selrReviewSuccess", "Thank you for your Feedback!");
                    dispatcher = request.getRequestDispatcher("shared/review.jsp?id=" + transactionId);
                    dispatcher.forward(request, response);
                    break;
                case "itemFeedback":
                    try {
                        // Update Transaction Ratings & Feedback & Status
                        feedback = request.getParameter("itemFeedback");
                        ratings = Double.parseDouble(request.getParameter("item-review-ratings"));
                        
                        TransactionRecords transaction = transactionRecordsFacade.find(transactionId);
                        transaction.setItemStatus("Completed");
                        transaction.setItemRatings(ratings);
                        transaction.setItemFeedback(feedback);
                        transactionRecordsFacade.edit(transaction);
                        
                        UserInfo found = userInfoFacade.find(uname);
                        transactionRecords = found.getCust().get(0).getTransactionList();
                        s.removeAttribute("trans");
                        s.setAttribute("trans", transactionRecords);
                        
                        //Update Item's Ratings
                        Items item = itemsFacade.find(transaction.getItem().getId()); //Get Item
                        ArrayList<TransactionRecords> allItemTrans = item.getTransactions(); //Get List of Transactions
                        int totalTransaction = allItemTrans.size(); //Get Total Number of Transaction
                        int validTotalTransaction = 0;
                        double sumOfRatings = 0.0;
                        if (totalTransaction < 2 && item.getRatings() == 0) {
                            item.setRatings(ratings);
                            itemsFacade.edit(item);
                        } else {
                            for (TransactionRecords t: allItemTrans) { //Sum up rating for each transaction.
                                sumOfRatings += t.getItemRatings();
                                if (t.getItemRatings() > 0) {
                                    validTotalTransaction += 1;
                                }
                            }
                        
                            double newRating = sumOfRatings / validTotalTransaction;
                            item.setRatings(newRating);
                            itemsFacade.edit(item);   
                        }
                        
                        //Reset Item Details
                        List<Items> allItemList = itemsFacade.findAll();
                        s.removeAttribute("allItemList");
                        s.setAttribute("allItemList", allItemList);
                        
                    } catch (Exception e) {
                        request.setAttribute("otherError", "Some Error has Occured, Please try again later!");
                        dispatcher = request.getRequestDispatcher("shared/review.jsp?id=" + transactionId);
                        dispatcher.forward(request, response);
                    }
                                        
                    request.setAttribute("itemReviewSuccess", "Thank you for your Feedback!");
                    dispatcher = request.getRequestDispatcher("shared/review.jsp?id=" + transactionId);
                    dispatcher.forward(request, response);
                    break;
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

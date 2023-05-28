/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;
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
@WebServlet(name = "CreateTransaction", urlPatterns = {"/CreateTransaction"})
public class CreateTransaction extends HttpServlet {

    @EJB
    private UserInfoFacade userInfoFacade;

    @EJB
    private ItemsFacade itemsFacade;

    @EJB
    private SellerAccountFacade sellerAccountFacade;

    @EJB
    private TransactionRecordsFacade transactionRecordsFacade;

    @EJB
    private CustomerAccountFacade customerAccountFacade;

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
            try {
                HttpSession session = request.getSession(false);

                //Get TransactionRecords Details
                List<Cart> cart = (List<Cart>) session.getAttribute("cart");
                double finalTotal = (double) session.getAttribute("finalTotal");
                
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                Date date = new Date();
                String currentDate = dateFormat.format(date);
                
                //Generate Unique UUID for transaction
                String uniqueTransactionIdentifier = UUID.randomUUID().toString();
                
                String initialStatus = "Pending";
                ArrayList<TransactionRecords> transactionRecords = new ArrayList<>();
                String ccType = request.getParameter("ccType");
                String ccNum = request.getParameter("ccNum");
                String refNo = ccNum.substring(ccNum.length() - 4);
                
                //Get Customer
                String uname = request.getParameter("uname");
                UserInfo found = userInfoFacade.find(uname);
                CustomerAccount cust = customerAccountFacade.find(found.getCust().get(0).getId());

                for (Cart c : cart) {
                    //Find Seller of Item
                    Items item = itemsFacade.find(c.getId());
                    SellerAccount selr = sellerAccountFacade.find(item.getSeller().getId());
                    
                    //Create a TransactionRecords
                    TransactionRecords newTransaction = new TransactionRecords();
                    newTransaction.setTransactionIdentifier(uniqueTransactionIdentifier);
                    newTransaction.setDate(currentDate);
                    newTransaction.setItemQuantity(c.getQuantity());
                    newTransaction.setIndividualTransactionTotal(c.getPrice());
                    newTransaction.setWholeTransactionTotal(finalTotal);
                    newTransaction.setCustRatings(0);
                    newTransaction.setCustFeedback("");
                    newTransaction.setSelrRatings(0);
                    newTransaction.setSelrFeedback("");
                    newTransaction.setItemRatings(0);
                    newTransaction.setItemFeedback("");
                    newTransaction.setCustomer(cust);
                    newTransaction.setSeller(selr);
                    newTransaction.setItem(item);
                    newTransaction.setCcType(ccType);
                    newTransaction.setCcRefDigits(refNo);
                    newTransaction.setCustStatus(initialStatus);
                    newTransaction.setSellerStatus(initialStatus);
                    newTransaction.setSellerCollectionStatus(initialStatus);
                    newTransaction.setItemStatus(initialStatus);
                    transactionRecordsFacade.create(newTransaction);
                    
                    //Link it to Customer & Seller & Item - TransactionRecords List
                    cust.getTransactionList().add(newTransaction);
                    customerAccountFacade.edit(cust);
                    selr.getTransactionList().add(newTransaction);
                    sellerAccountFacade.edit(selr);
                    item.getTransactions().add(newTransaction);
                    
                    //Remove Item Quantity
                    int quantityLeft = item.getAvailableQuantity() - c.getQuantity();
                    
                    item.setAvailableQuantity(quantityLeft);
                    if (quantityLeft == 0) {
                        item.setStatus("Out of Stock");
                    }
                    
                    itemsFacade.edit(item);
                }
                
                //Remove other cart info to reset
                session.removeAttribute("cart");
                session.removeAttribute("finalTotal");
                session.removeAttribute("shippingTotal");
                session.removeAttribute("cartTotal");
                
                //Reset Transaction Records
                transactionRecords = cust.getTransactionList();
                session.removeAttribute("trans");
                session.setAttribute("trans", transactionRecords);
                
                request.setAttribute("transactionSuccess", "Transaction is Successful!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
                
            } catch (Exception e) {
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

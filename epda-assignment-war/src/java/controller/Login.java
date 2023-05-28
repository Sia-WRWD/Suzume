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
import model.AdminAccount;
import model.CustomerAccount;
import model.Items;
import model.ItemsFacade;
import model.SellerAccount;
import model.TransactionRecords;
import model.TransactionRecordsFacade;
import model.UserInfo;
import model.UserInfoFacade;

/**
 *
 * @author Sia_RTX3070
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    @EJB
    private ItemsFacade itemsFacade;

    @EJB
    private TransactionRecordsFacade transactionRecordsFacade;

    @EJB
    private UserInfoFacade userInfoFacade;

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
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            UserInfo found = userInfoFacade.find(username);
            ArrayList<TransactionRecords> transactionRecords = new ArrayList<>();
            double onestar = 0;
            double twostar = 0;
            double threestar = 0;
            double fourstar = 0;
            double fivestar = 0;
            int validTransaction = 0;

            try {
                if (found == null) {
                    throw new IllegalArgumentException();
                }

                if (!(password.equals(found.getPassword()))) { //Check here if Error
                    throw new IllegalArgumentException();
                }

                HttpSession s = request.getSession();

                switch (found.getRole()) {
                    case "customer":
                        if (found.getCust().get(0).getStatus().equals("Deactivated")) {
                            throw new IllegalStateException();
                        }

                        ArrayList<CustomerAccount> custDetails = found.getCust();
                        transactionRecords = custDetails.get(0).getTransactionList();
                        s.setAttribute("accd", custDetails); //Set Account Details
                        s.setAttribute("trans", transactionRecords); //Set Transaction Records

                        for (TransactionRecords t : transactionRecords) {

                            if (t.getCustRatings() > 0) {
                                validTransaction += 1;
                            }

                            if (t.getCustRatings() == 1) {
                                onestar += 1;
                            } else if (t.getCustRatings() == 2) {
                                twostar += 1;
                            } else if (t.getCustRatings() == 3) {
                                threestar += 1;
                            } else if (t.getCustRatings() == 4) {
                                fourstar += 1;
                            } else if (t.getCustRatings() == 5) {
                                fivestar += 1;
                            }
                        }

                        //Convert Ratings to Percentage
                        onestar = (onestar / validTransaction) * 100;
                        twostar = (twostar / validTransaction) * 100;
                        threestar = (threestar / validTransaction) * 100;
                        fourstar = (fourstar / validTransaction) * 100;
                        fivestar = (fivestar / validTransaction) * 100;

                        break;
                    case "seller":
                        if (found.getSeller().get(0).getStatus().equals("Deactivated")) {
                            throw new IllegalStateException();
                        }

                        ArrayList<SellerAccount> selrDetails = found.getSeller();
                        ArrayList<Items> ItemList = selrDetails.get(0).getItemList();
                        transactionRecords = selrDetails.get(0).getTransactionList();
                        s.setAttribute("accd", selrDetails);
                        s.setAttribute("itemList", ItemList);
                        s.setAttribute("trans", transactionRecords);

                        for (TransactionRecords t : transactionRecords) {

                            if (t.getSelrRatings() > 0) {
                                validTransaction += 1;
                            }

                            if (t.getSelrRatings() == 1) {
                                onestar += 1;
                            } else if (t.getSelrRatings() == 2) {
                                twostar += 1;
                            } else if (t.getCustRatings() == 3) {
                                threestar += 1;
                            } else if (t.getCustRatings() == 4) {
                                fourstar += 1;
                            } else if (t.getCustRatings() == 5) {
                                fivestar += 1;
                            }
                        }

                        //Convert Ratings to Percentage
                        onestar = (onestar / validTransaction) * 100;
                        twostar = (twostar / validTransaction) * 100;
                        threestar = (threestar / validTransaction) * 100;
                        fourstar = (fourstar / validTransaction) * 100;
                        fivestar = (fivestar / validTransaction) * 100;

                        break;
                    case "admin":
                        if (found.getAdmin().get(0).getStatus().equals("Deactivated")) {
                            throw new IllegalStateException();
                        }

                        ArrayList<AdminAccount> admDetails = found.getAdmin();
                        List<Items> allItemList = itemsFacade.findAll();
                        List<TransactionRecords> allTransactionRecords = transactionRecordsFacade.findAll();
                        List<UserInfo> allUsers = userInfoFacade.findAll();
                        s.setAttribute("userList", allUsers);
                        s.setAttribute("accd", admDetails);
                        s.setAttribute("itemList", allItemList);
                        s.setAttribute("trans", allTransactionRecords);

                        break;
                }

                //Set Username
                s.setAttribute("uname", found.getId());
                s.setAttribute("role", found.getRole());

                //Set Ratings Value
                s.setAttribute("onestar", onestar);
                s.setAttribute("twostar", twostar);
                s.setAttribute("threestar", threestar);
                s.setAttribute("fourstar", fourstar);
                s.setAttribute("fivestar", fivestar);

                request.setAttribute("loginSuccess", "Login is Successful!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);

            } catch (IllegalArgumentException e) {
                request.setAttribute("loginError", "Username or Password is Incorrect!");

                RequestDispatcher dispatcher = request.getRequestDispatcher("authentication/login.jsp");
                dispatcher.forward(request, response);
            } catch (IllegalStateException e) {
                request.setAttribute("deactivatedError", "Your account has been deactivated, contact the admin for more info!");

                RequestDispatcher dispatcher = request.getRequestDispatcher("authentication/login.jsp");
                dispatcher.forward(request, response);
            } catch (Exception e) {
                request.setAttribute("otherError", "Some Error has Occured, Please try again later!");

                RequestDispatcher dispatcher = request.getRequestDispatcher("authentication/login.jsp");
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

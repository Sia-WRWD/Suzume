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
import javax.servlet.http.HttpSession;
import model.AdminAccount;
import model.AdminAccountFacade;
import model.CustomerAccount;
import model.CustomerAccountFacade;
import model.SellerAccount;
import model.SellerAccountFacade;
import model.UserInfo;
import model.UserInfoFacade;

/**
 *
 * @author Sia_RTX3070
 */
@WebServlet(name = "Profile", urlPatterns = {"/Profile"})
public class Profile extends HttpServlet {

    @EJB
    private SellerAccountFacade sellerAccountFacade;

    @EJB
    private AdminAccountFacade adminAccountFacade;

    @EJB
    private UserInfoFacade userInfoFacade;

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

            String operation = request.getParameter("operation");
            HttpSession s = request.getSession(false);
            String username = (String) s.getAttribute("uname");
            String accountID = "";
            UserInfo found = userInfoFacade.find(username);

            //Request for Data based on operation
            if (operation.equals("acc")) {

                try {
                    String email = request.getParameter("email");
                    String name = request.getParameter("name");
                    char gender = request.getParameter("gender").charAt(0);
                    String address = request.getParameter("address");

                    //Get User's Details.
                    switch (found.getRole()) {
                        case "customer":
                            
                            ArrayList<CustomerAccount> custDetails = found.getCust();
                            //Get Account ID
                            accountID = custDetails.get(0).getId();
                            //Find the Account
                            CustomerAccount cust = customerAccountFacade.find(accountID);
                            //Update Details
                            cust.setEmail(email);
                            cust.setName(name);
                            cust.setGender(gender);
                            cust.setAddress(address);
                            
                            customerAccountFacade.edit(cust);
                            
                            //Reset Customer Account Details
                            found = userInfoFacade.find(username);
                            ArrayList<CustomerAccount> newCustDetails = new ArrayList<>(found.getCust());
                            s.removeAttribute("accd");
                            s.setAttribute("accd", newCustDetails);
                            
                            break;
                        case "seller":
                            ArrayList<SellerAccount> selrDetails = found.getSeller();

                            accountID = selrDetails.get(0).getId();
                            //Find the Account
                            SellerAccount selr = sellerAccountFacade.find(accountID);
                            //Update Details
                            selr.setEmail(email);
                            selr.setName(name);
                            selr.setGender(gender);
                            selr.setAddress(address);
                            
                            sellerAccountFacade.edit(selr);
                            
                            //Reset Seller Account Details
                            found = userInfoFacade.find(username);
                            ArrayList<SellerAccount> newSelrDetails = new ArrayList<>(found.getSeller());
                            s.removeAttribute("accd");
                            s.setAttribute("accd", newSelrDetails);
                            
                            break;
                        case "admin":
                            ArrayList<AdminAccount> admDetails = found.getAdmin();
                            //Get Account ID
                            accountID = admDetails.get(0).getId();
                            //Find the Account
                            AdminAccount adm = adminAccountFacade.find(accountID);
                            //Update Details
                            adm.setEmail(email);
                            adm.setName(name);
                            adm.setGender(gender);
                            adm.setAddress(address);
                            
                            adminAccountFacade.edit(adm);
                            
                            //Reset Admin Account Details
                            found = userInfoFacade.find(username);
                            ArrayList<AdminAccount> newAdmDetails = new ArrayList<>(found.getAdmin());
                            s.removeAttribute("accd");
                            s.setAttribute("accd", newAdmDetails);
                            
                            break;
                    }

                    //Send Success Message.
                    request.setAttribute("updateAccSuccess", "Account Details Update is Successful!");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("shared/profile.jsp");
                    dispatcher.forward(request, response);

                } catch (Exception e) {
                    request.setAttribute("updateAccError", "An error has occured! Please try again later.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("shared/profile.jsp");
                    dispatcher.forward(request, response);
                }
            }

            if (operation.equals("pwd")) {

                try {
                    String oldpwd = request.getParameter("oldpass");
                    String newpwd = request.getParameter("newpass");
                    
                    if (found.getPassword().equals(oldpwd)) {
                        found.setPassword(newpwd);
                        userInfoFacade.edit(found);
                    } else {
                        throw new IllegalArgumentException();
                    }

                    //Send Success Message.
                    request.setAttribute("updatePwdSuccess", "Password Update is Successful!");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("shared/profile.jsp");
                    dispatcher.forward(request, response);

                } catch (IllegalArgumentException e) {
                    request.setAttribute("oldPwdError", "Your old password is incorrect!");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("shared/profile.jsp");
                    dispatcher.forward(request, response);
                } catch (Exception e) {
                    request.setAttribute("updatePwdError", "An error has occured! Please try again later.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("shared/profile.jsp");
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import model.UserInfo;
import model.UserInfoFacade;

/**
 *
 * @author Sia_RTX3070
 */
@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {

    @EJB
    private AdminAccountFacade adminAccountFacade;

    @EJB
    private SellerAccountFacade sellerAccountFacade;

    @EJB
    private CustomerAccountFacade customerAccountFacade;

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

            String shopName = "";
            String department = "";
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");
            String name = "";
            String address = request.getParameter("address");

            try {

                UserInfo found = userInfoFacade.find(username);

                if (found != null) {
                    throw new IllegalArgumentException();
                }

                if (role.equals("customer") || role.equals("seller")) {

                    if (role.equals("customer")) {
                        name = request.getParameter("name");

                        CustomerAccount cust = new CustomerAccount();
                        cust.setEmail(email);
                        cust.setName(name);
                        cust.setGender('M');
                        cust.setRatings(0);
                        cust.setStatus("Active");
                        cust.setAddress(address);
                        cust.setTotalTransactions(0);
                        customerAccountFacade.create(cust);

                        UserInfo ui = new UserInfo(username, password, role);
                        ui.getCust().add(cust);
                        userInfoFacade.create(ui);
                    } else {
                        shopName = request.getParameter("shopName");

                        SellerAccount selr = new SellerAccount();
                        selr.setEmail(email);
                        selr.setShopName(shopName);
                        selr.setName("");
                        selr.setGender('M');
                        selr.setRatings(0);
                        selr.setStatus("Pending");
                        selr.setAddress(address);
                        selr.setTotalTransactions(0);
                        sellerAccountFacade.create(selr);

                        UserInfo ui = new UserInfo(username, password, role);
                        ui.getSeller().add(selr);
                        userInfoFacade.create(ui);
                    }

                    request.setAttribute("registerationSuccess", "Registeration is Successful!");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("authentication/login.jsp");
                    dispatcher.forward(request, response);
                } else if (role.equals("admin")) {
                    department = request.getParameter("department");

                    AdminAccount adm = new AdminAccount();
                    adm.setName("");
                    adm.setGender('M');
                    adm.setEmail(email);
                    adm.setDepartment(department);
                    adm.setAddress(address);
                    adm.setStatus("Active");
                    adminAccountFacade.create(adm);

                    UserInfo ui = new UserInfo(username, password, role);
                    ui.getAdmin().add(adm);
                    userInfoFacade.create(ui);

                    request.setAttribute("registerationSuccess", "Registeration is Successful!");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("authentication/admin-register.jsp");
                    dispatcher.forward(request, response);
                }

            } catch (IllegalArgumentException e) {
                request.setAttribute("registerationError", "Username inputted already exist!");

                switch (role) {
                    case "customer": {
                        RequestDispatcher dispatcher = request.getRequestDispatcher("authentication/customer-register.jsp");
                        dispatcher.forward(request, response);
                        break;
                    }
                    case "seller": {
                        RequestDispatcher dispatcher = request.getRequestDispatcher("authentication/seller-register.jsp");
                        dispatcher.forward(request, response);
                        break;
                    }
                    case "admin": {
                        RequestDispatcher dispatcher = request.getRequestDispatcher("authentication/admin-register.jsp");
                        dispatcher.forward(request, response);
                        break;
                    }
                }

            } catch (Exception e) {
                request.setAttribute("otherError", "Some Error has Occured, Please try again later!");

                switch (role) {
                    case "customer": {
                        RequestDispatcher dispatcher = request.getRequestDispatcher("authentication/customer-register.jsp");
                        dispatcher.forward(request, response);
                        break;
                    }
                    case "seller": {
                        RequestDispatcher dispatcher = request.getRequestDispatcher("authentication/seller-register.jsp");
                        dispatcher.forward(request, response);
                        break;
                    }
                    case "admin": {
                        RequestDispatcher dispatcher = request.getRequestDispatcher("authentication/admin-register.jsp");
                        dispatcher.forward(request, response);
                        break;
                    }
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

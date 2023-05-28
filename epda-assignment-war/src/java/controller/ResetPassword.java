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
import model.AdminAccountFacade;
import model.CustomerAccountFacade;
import model.SellerAccountFacade;
import model.UserInfo;
import model.UserInfoFacade;

/**
 *
 * @author Sia_RTX3070
 */
@WebServlet(name = "ResetPassword", urlPatterns = {"/ResetPassword"})
public class ResetPassword extends HttpServlet {

    @EJB
    private CustomerAccountFacade customerAccountFacade;

    @EJB
    private SellerAccountFacade sellerAccountFacade;

    @EJB
    private UserInfoFacade userInfoFacade;

    @EJB
    private AdminAccountFacade adminAccountFacade;

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
            String uname = request.getParameter("uname");
            String email = request.getParameter("email");
            String newpwd = request.getParameter("newpwd");
            UserInfo user = userInfoFacade.find(uname);
            
            try {
                if (user == null) {
                    throw new IllegalArgumentException();
                }
                
                switch (user.getRole()) {
                    case "customer":
                        if (!user.getCust().get(0).getEmail().equals(email)) {
                            throw new IllegalArgumentException();
                        }
                        
                        break;
                    case "admin":
                        if (!user.getAdmin().get(0).getEmail().equals(email)) {
                            throw new IllegalArgumentException();
                        }
                        
                        break;
                    case "seller":
                        if (!user.getSeller().get(0).getEmail().equals(email)) {
                            throw new IllegalArgumentException();
                        }
                        
                        break;
                }
                
                user.setPassword(newpwd);
                userInfoFacade.edit(user);
                
                request.setAttribute("passwordResetSuccess", "Successfully resetted your Account's Password!");

                RequestDispatcher dispatcher = request.getRequestDispatcher("authentication/login.jsp");
                dispatcher.forward(request, response);
                
            } catch (IllegalArgumentException e) {
                request.setAttribute("passwordResetError", "Username or Email provided is Incorrect!");

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

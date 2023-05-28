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
import model.AdminAccountFacade;
import model.CustomerAccount;
import model.CustomerAccountFacade;
import model.ItemsFacade;
import model.SellerAccount;
import model.SellerAccountFacade;
import model.UserInfo;
import model.UserInfoFacade;

/**
 *
 * @author Sia_RTX3070
 */
@WebServlet(name = "ManageUser", urlPatterns = {"/ManageUser"})
public class ManageUser extends HttpServlet {

    @EJB
    private AdminAccountFacade adminAccountFacade;

    @EJB
    private ItemsFacade itemsFacade;

    @EJB
    private CustomerAccountFacade customerAccountFacade;

    @EJB
    private SellerAccountFacade sellerAccountFacade;

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
            
            String ops = request.getParameter("ops");
            String uname = request.getParameter("uname");
            RequestDispatcher dispatcher = null;
            HttpSession s = request.getSession(false);
            UserInfo user = userInfoFacade.find(uname);
            CustomerAccount cust = new CustomerAccount();
            SellerAccount selr = new SellerAccount();
            AdminAccount adm = new AdminAccount();
            List<UserInfo> allUsers = new ArrayList<>();
            String userId = "";
            
            switch (ops) {
                case "approve":
                    try {
                        userId = user.getSeller().get(0).getId();
                        selr = sellerAccountFacade.find(userId);
                        selr.setStatus("Active");
                        sellerAccountFacade.edit(selr);
                        
                    } catch (Exception e) {
                        request.setAttribute("otherError", "Some Error has Occured, Please try again later!");
                        dispatcher = request.getRequestDispatcher("admin/manage-user.jsp");
                        dispatcher.forward(request, response);
                    }
                    
                    //Reset User Details
                    allUsers = userInfoFacade.findAll();
                    s.removeAttribute("userList");
                    s.setAttribute("userList", allUsers);
                    
                    request.setAttribute("approveSuccess", "Successfully approved the Seller");
                    dispatcher = request.getRequestDispatcher("admin/manage-user.jsp");
                    dispatcher.forward(request, response);
                    break;
                    
                case "deactivate":
                    try {
                        switch (user.getRole()) {
                            case "customer":
                                userId = user.getCust().get(0).getId();
                                cust = customerAccountFacade.find(userId);
                                cust.setStatus("Deactivated");
                                customerAccountFacade.edit(cust);
                                break;
                            case "seller":
                                userId = user.getSeller().get(0).getId();
                                selr = sellerAccountFacade.find(userId);
                                selr.setStatus("Deactivated");
                                sellerAccountFacade.edit(selr);
                                break;
                            case "admin":
                                userId = user.getAdmin().get(0).getId();
                                adm = adminAccountFacade.find(userId);
                                adm.setStatus("Deactivated");
                                adminAccountFacade.edit(adm);
                                break;
                        }
                    } catch (Exception e) {
                        request.setAttribute("otherError", "Some Error has Occured, Please try again later!");
                        dispatcher = request.getRequestDispatcher("admin/manage-user.jsp");
                        dispatcher.forward(request, response);
                    }
                    
                    //Reset User Details
                    allUsers = userInfoFacade.findAll();
                    s.removeAttribute("userList");
                    s.setAttribute("userList", allUsers);
                    
                    request.setAttribute("deactivateSuccess", "Successfully deactivated the user");
                    dispatcher = request.getRequestDispatcher("admin/manage-user.jsp");
                    dispatcher.forward(request, response);
                    break;
                    
                case "reactivate":
                    try {
                        switch (user.getRole()) {
                            case "customer":
                                userId = user.getCust().get(0).getId();
                                cust = customerAccountFacade.find(userId);
                                cust.setStatus("Active");
                                customerAccountFacade.edit(cust);
                                break;
                            case "seller":
                                userId = user.getSeller().get(0).getId();
                                selr = sellerAccountFacade.find(userId);
                                selr.setStatus("Active");
                                sellerAccountFacade.edit(selr);
                                break;
                            case "admin":
                                userId = user.getAdmin().get(0).getId();
                                adm = adminAccountFacade.find(userId);
                                adm.setStatus("Active");
                                adminAccountFacade.edit(adm);
                                break;
                        }
                    } catch (Exception e) {
                        request.setAttribute("otherError", "Some Error has Occured, Please try again later!");
                        dispatcher = request.getRequestDispatcher("admin/manage-user.jsp");
                        dispatcher.forward(request, response);
                    }
                    
                    //Reset User Details
                    allUsers = userInfoFacade.findAll();
                    s.removeAttribute("userList");
                    s.setAttribute("userList", allUsers);
                    
                    request.setAttribute("reactivateSuccess", "Successfully reactivated the user");
                    dispatcher = request.getRequestDispatcher("admin/manage-user.jsp");
                    dispatcher.forward(request, response);
                    break;
                    
                case "edit":
                    try {
                        switch (user.getRole()) {
                            case "customer":
                                String custName = request.getParameter("custName");
                                char custGender = request.getParameter("custGender").charAt(0);
                                String custEmail = request.getParameter("custEmail");
                                String custAddress = request.getParameter("custAddress");
                                
                                cust = customerAccountFacade.find(user.getCust().get(0).getId());
                                cust.setName(custName);
                                cust.setGender(custGender);
                                cust.setEmail(custEmail);
                                cust.setAddress(custAddress);
                                customerAccountFacade.edit(cust);
                                
                                break;
                            case "seller":
                                String selrShopName = request.getParameter("selrShopName");
                                String selrName = request.getParameter("selrName");
                                char selrGender = request.getParameter("selrGender").charAt(0);
                                String selrEmail = request.getParameter("selrEmail");
                                String selrAddress = request.getParameter("selrAddress");
                                
                                selr = sellerAccountFacade.find(user.getSeller().get(0).getId());
                                selr.setShopName(selrShopName);
                                selr.setName(selrName);
                                selr.setGender(selrGender);
                                selr.setEmail(selrEmail);
                                selr.setAddress(selrAddress);
                                sellerAccountFacade.edit(selr);
                                
                                break;
                            case "admin":
                                String admName = request.getParameter("admName");
                                char admGender = request.getParameter("admGender").charAt(0);
                                String admEmail = request.getParameter("admEmail");
                                String admDept = request.getParameter("admDept");
                                String admAddress = request.getParameter("admAddress");
                                
                                adm = adminAccountFacade.find(user.getAdmin().get(0).getId());
                                adm.setDepartment(admDept);
                                adm.setName(admName);
                                adm.setGender(admGender);
                                adm.setEmail(admEmail);
                                adm.setAddress(admAddress);
                                adminAccountFacade.edit(adm);
                                
                                break;
                        }
                    } catch (Exception e) {
                        request.setAttribute("otherError", "Some Error has Occured, Please try again later!");
                        dispatcher = request.getRequestDispatcher("admin/manage-user.jsp");
                        dispatcher.forward(request, response);
                    }
                    
                    //Reset User Details
                    allUsers = userInfoFacade.findAll();
                    s.removeAttribute("userList");
                    s.setAttribute("userList", allUsers);
                    
                    request.setAttribute("userEditSuccess", "Successfully edited user's detail!");
                    dispatcher = request.getRequestDispatcher("admin/manage-user.jsp");
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

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
import model.Items;
import model.ItemsFacade;
import model.SellerAccount;
import model.SellerAccountFacade;
import model.UserInfo;
import model.UserInfoFacade;

/**
 *
 * @author Sia_RTX3070
 */
@WebServlet(name = "Item", urlPatterns = {"/Item"})
public class Item extends HttpServlet {

    @EJB
    private UserInfoFacade userInfoFacade;

    @EJB
    private ItemsFacade itemsFacade;

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
            String operation = request.getParameter("operation");
            HttpSession s = request.getSession(false);
            String username = (String) s.getAttribute("uname");
            UserInfo found = userInfoFacade.find(username);
            String accountId  = found.getSeller().get(0).getId();

            try {
                switch (operation) {
                    case "add":
                        {
                            String itemName = request.getParameter("item-name");
                            String itemDesc = request.getParameter("item-desc");
                            int avaQty = Integer.parseInt(request.getParameter("ava-qty"));
                            double unitPrice = Double.parseDouble(request.getParameter("item-price"));
                            String category = request.getParameter("category");
                            double ratings = 0;
                            String deliType = request.getParameter("deli-type");
                            String itemPicURL = request.getParameter("img-url");
                            String status = "Available";
                            
                            SellerAccount ss = sellerAccountFacade.find(accountId);
                            
                            Items item = new Items();
                            item.setName(itemName);
                            item.setDescription(itemDesc);
                            item.setAvailableQuantity(avaQty);
                            item.setUnitPrice(unitPrice);
                            item.setCategory(category);
                            item.setRatings(ratings);
                            item.setDeliveryType(deliType);
                            item.setImgUrl(itemPicURL);
                            item.setStatus(status);
                            item.setSeller(ss);
                            itemsFacade.create(item);
                            
                            ss.getItemList().add(item);
                            sellerAccountFacade.edit(ss);
                            
                            ArrayList<Items> itemList = ss.getItemList();
                            s.removeAttribute("itemList");
                            s.setAttribute("itemList", itemList);
                            
                            request.setAttribute("addItemSuccess", "New item has been successfully added!");
                            RequestDispatcher dispatcher = request.getRequestDispatcher("seller/add-items.jsp");
                            dispatcher.forward(request, response);
                            break;
                        }
                    case "edit":
                        {
                            String itemName = request.getParameter("item-name");
                            String itemDesc = request.getParameter("item-desc");
                            int avaQty = Integer.parseInt(request.getParameter("ava-qty"));
                            double unitPrice = Double.parseDouble(request.getParameter("item-price"));
                            String category = request.getParameter("category");
                            String deliType = request.getParameter("deli-type");
                            String itemPicURL = request.getParameter("img-url");
                            String status = request.getParameter("status");
                            String itemID = request.getParameter("item-id");
                            
                            Items itemToEdit = itemsFacade.find(itemID);
                            itemToEdit.setName(itemName);
                            itemToEdit.setDescription(itemDesc);
                            itemToEdit.setAvailableQuantity(avaQty);
                            itemToEdit.setUnitPrice(unitPrice);
                            itemToEdit.setCategory(category);
                            itemToEdit.setDeliveryType(deliType);
                            itemToEdit.setImgUrl(itemPicURL);
                            itemToEdit.setStatus(status);
                            itemsFacade.edit(itemToEdit);
                            
                            SellerAccount ss = sellerAccountFacade.find(accountId);
                            ArrayList<Items> itemList = ss.getItemList();
                            s.removeAttribute("itemList");
                            s.setAttribute("itemList", itemList);
                            
                            request.setAttribute("editItemSuccess", "Item has been successfully edited!");
                            RequestDispatcher dispatcher = request.getRequestDispatcher("seller/manage-items.jsp");
                            dispatcher.forward(request, response);
                            break;
                        }
                    case "delete":
                        {
                            String itemID = request.getParameter("modal-item-id");
                            
                            Items itemToDelete = itemsFacade.find(itemID); //Find the Item to be deleted.
                            SellerAccount ss = sellerAccountFacade.find(accountId); //Get the Seller Account which the item is attached to.
                            
                            ss.getItemList().remove(itemToDelete); //Remove the to be deleted item from the selleraccount_items or foreign key attached table.
                            sellerAccountFacade.edit(ss); //Commit the result or update.
                            itemsFacade.delete(itemToDelete); //Finally, delete the item when the foreign key has been removed.
                            
                            ArrayList<Items> itemList = ss.getItemList();
                            s.removeAttribute("itemList");
                            s.setAttribute("itemList", itemList);
                            
                            request.setAttribute("deleteItemSuccess", "Item has been successfully deleted!");
                            RequestDispatcher dispatcher = request.getRequestDispatcher("seller/manage-items.jsp");
                            dispatcher.forward(request, response);
                            break;
                        }
                }
                

            } catch (Exception e) {
                request.setAttribute("otherError", "Some Error has Occured, Please try again later!");
                
                switch (operation) {
                    case "add":
                        {
                            RequestDispatcher dispatcher = request.getRequestDispatcher("seller/add-items.jsp");
                            dispatcher.forward(request, response);
                            break;
                        }
                    case "edit":
                        {
                            RequestDispatcher dispatcher = request.getRequestDispatcher("seller/edit-item.jsp");
                            dispatcher.forward(request, response);
                            break;
                        }
                    case "delete":
                        {
                            RequestDispatcher dispatcher = request.getRequestDispatcher("seller/manage-items.jsp");
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

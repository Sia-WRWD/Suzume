/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.TransactionRecords;

/**
 *
 * @author Sia_RTX3070
 */
@WebServlet(name = "GetRatings", urlPatterns = {"/GetRatings"})
public class GetRatings extends HttpServlet {

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
            HttpSession s = request.getSession();
            String role = (String) s.getAttribute("role");
            ArrayList<TransactionRecords> trans = (ArrayList<TransactionRecords>) s.getAttribute("trans");
            double onestar = 0;
            double twostar = 0;
            double threestar = 0;
            double fourstar = 0;
            double fivestar = 0;
            int validTransaction = 0;

            try {
                for (TransactionRecords t : trans) {
                    if (role.equals("seller")) {

                        if (t.getSelrRatings() > 0) {
                            validTransaction += 1;
                        }

                        if (t.getSelrRatings() == 1) {
                            onestar += 1;
                        } else if (t.getSelrRatings() == 2) {
                            twostar += 1;
                        } else if (t.getSelrRatings() == 3) {
                            threestar += 1;
                        } else if (t.getSelrRatings() == 4) {
                            fourstar += 1;
                        } else if (t.getSelrRatings() == 5) {
                            fivestar += 1;
                        }

                    } else if (role.equals("customer")) {
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

                    s.setAttribute("onestar", onestar);
                    s.setAttribute("twostar", twostar);
                    s.setAttribute("threestar", threestar);
                    s.setAttribute("fourstar", fourstar);
                    s.setAttribute("fivestar", fivestar);
                }
            } catch (Exception e) {
                request.setAttribute("otherError", "Some Error has Occured, Please try again later!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("seller/manage-items.jsp");
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

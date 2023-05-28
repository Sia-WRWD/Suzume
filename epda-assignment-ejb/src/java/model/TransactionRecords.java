/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.util.ArrayList;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

/**
 *
 * @author Sia_RTX3070
 */
@Entity
public class TransactionRecords implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private String id;
    private String transactionIdentifier;
    private String date;
    private int itemQuantity;
    private double individualTransactionTotal;
    private double wholeTransactionTotal;
    private double custRatings;
    private String custFeedback;
    private double selrRatings;
    private String selrFeedback;
    private double itemRatings;
    private String itemFeedback;
    private String ccType;
    private String ccRefDigits;    
    private String custStatus; //Has customer reviewed seller?
    private String itemStatus; //Has customer reviewed item?
    private String sellerStatus; //Has seller reviewed customer?
    private String sellerCollectionStatus; //Has seller collected payment?
    
    @OneToOne
    private SellerAccount seller;
    
    @OneToOne
    private CustomerAccount customer;

    @ManyToOne
    private Items item;
    
    public TransactionRecords() {
        
    }

    public TransactionRecords(String id, String transactionIdentifier, String date, int itemQuantity, double individualTransactionTotal, double wholeTransactionTotal, double custRatings, String custFeedback, double selrRatings, String selrFeedback, double itemRatings, String itemFeedback, String ccType, String ccRefDigits, String custStatus, String itemStatus, String sellerStatus, String sellerCollectionStatus, SellerAccount seller, CustomerAccount customer, Items item) {
        this.id = id;
        this.transactionIdentifier = transactionIdentifier;
        this.date = date;
        this.itemQuantity = itemQuantity;
        this.individualTransactionTotal = individualTransactionTotal;
        this.wholeTransactionTotal = wholeTransactionTotal;
        this.custRatings = custRatings;
        this.custFeedback = custFeedback;
        this.selrRatings = selrRatings;
        this.selrFeedback = selrFeedback;
        this.itemRatings = itemRatings;
        this.itemFeedback = itemFeedback;
        this.ccType = ccType;
        this.ccRefDigits = ccRefDigits;
        this.custStatus = custStatus;
        this.itemStatus = itemStatus;
        this.sellerStatus = sellerStatus;
        this.sellerCollectionStatus = sellerCollectionStatus;
        this.seller = seller;
        this.customer = customer;
        this.item = item;
    }

    public String getTransactionIdentifier() {
        return transactionIdentifier;
    }

    public void setTransactionIdentifier(String transactionIdentifier) {
        this.transactionIdentifier = transactionIdentifier;
    }

    public String getItemFeedback() {
        return itemFeedback;
    }

    public void setItemFeedback(String itemFeedback) {
        this.itemFeedback = itemFeedback;
    }

    public String getSellerCollectionStatus() {
        return sellerCollectionStatus;
    }

    public void setSellerCollectionStatus(String sellerCollectionStatus) {
        this.sellerCollectionStatus = sellerCollectionStatus;
    }
    
    public String getCcType() {
        return ccType;
    }

    public void setCcType(String ccType) {
        this.ccType = ccType;
    }

    public String getCcRefDigits() {
        return ccRefDigits;
    }

    public void setCcRefDigits(String ccRefDigits) {
        this.ccRefDigits = ccRefDigits;
    }

    public String getCustStatus() {
        return custStatus;
    }

    public void setCustStatus(String custStatus) {
        this.custStatus = custStatus;
    }

    public String getItemStatus() {
        return itemStatus;
    }

    public void setItemStatus(String itemStatus) {
        this.itemStatus = itemStatus;
    }

    public String getSellerStatus() {
        return sellerStatus;
    }

    public void setSellerStatus(String sellerStatus) {
        this.sellerStatus = sellerStatus;
    }

    public double getCustRatings() {
        return custRatings;
    }

    public void setCustRatings(double custRatings) {
        this.custRatings = custRatings;
    }

    public String getCustFeedback() {
        return custFeedback;
    }

    public void setCustFeedback(String custFeedback) {
        this.custFeedback = custFeedback;
    }

    public double getSelrRatings() {
        return selrRatings;
    }

    public void setSelrRatings(double selrRatings) {
        this.selrRatings = selrRatings;
    }

    public String getSelrFeedback() {
        return selrFeedback;
    }

    public void setSelrFeedback(String selrFeedback) {
        this.selrFeedback = selrFeedback;
    }

    public double getItemRatings() {
        return itemRatings;
    }

    public void setItemRatings(double itemRatings) {
        this.itemRatings = itemRatings;
    }
    
    public Items getItem() {
        return item;
    }

    public void setItem(Items item) {
        this.item = item;
    }

    public int getItemQuantity() {
        return itemQuantity;
    }

    public void setItemQuantity(int itemQuantity) {
        this.itemQuantity = itemQuantity;
    }

    public double getIndividualTransactionTotal() {
        return individualTransactionTotal;
    }

    public void setIndividualTransactionTotal(double individualTransactionTotal) {
        this.individualTransactionTotal = individualTransactionTotal;
    }

    public double getWholeTransactionTotal() {
        return wholeTransactionTotal;
    }

    public void setWholeTransactionTotal(double wholeTransactionTotal) {
        this.wholeTransactionTotal = wholeTransactionTotal;
    }

    public SellerAccount getSeller() {
        return seller;
    }

    public void setSeller(SellerAccount seller) {
        this.seller = seller;
    }

    public CustomerAccount getCustomer() {
        return customer;
    }

    public void setCustomer(CustomerAccount customer) {
        this.customer = customer;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TransactionRecords)) {
            return false;
        }
        TransactionRecords other = (TransactionRecords) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Transaction[ id=" + id + " ]";
    }
    
}

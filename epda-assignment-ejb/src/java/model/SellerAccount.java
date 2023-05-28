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
import javax.persistence.OneToMany;

/**
 *
 * @author Sia_RTX3070
 */
@Entity
public class SellerAccount implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private String id;
    private String email;
    private String shopName;
    private String name;
    private char gender;
    private int totalTransactions;
    private double ratings;
    private String address;
    private String status;

    @OneToMany
    private ArrayList<Items> itemList = new ArrayList<Items>();

    @OneToMany(mappedBy = "seller")
    private ArrayList<TransactionRecords> transactionList = new ArrayList<TransactionRecords>();

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public char getGender() {
        return gender;
    }

    public double getRatings() {
        return ratings;
    }

    public void setRatings(double ratings) {
        this.ratings = ratings;
    }

    public void setGender(char gender) {
        this.gender = gender;
    }

    public ArrayList<TransactionRecords> getTransactionList() {
        return transactionList;
    }

    public void setTransactionList(ArrayList<TransactionRecords> transactionList) {
        this.transactionList = transactionList;
    }

    public int getTotalTransactions() {
        return totalTransactions;
    }

    public void setTotalTransactions(int totalTransactions) {
        this.totalTransactions = totalTransactions;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ArrayList<Items> getItemList() {
        return itemList;
    }

    public void setItemList(ArrayList<Items> itemList) {
        this.itemList = itemList;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
        if (!(object instanceof SellerAccount)) {
            return false;
        }
        SellerAccount other = (SellerAccount) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.NewEntity[ id=" + id + " ]";
    }

}

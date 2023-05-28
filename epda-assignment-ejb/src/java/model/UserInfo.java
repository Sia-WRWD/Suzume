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
public class UserInfo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private String id; //username
    private String password;
    private String role;

    @OneToMany
    private ArrayList<AdminAccount> admin = new ArrayList<AdminAccount>();
    
    @OneToMany
    private ArrayList<CustomerAccount> cust = new ArrayList<CustomerAccount>();
    
    @OneToMany
    private ArrayList<SellerAccount> seller = new ArrayList<SellerAccount>();
    
    public UserInfo() {}
    
    public UserInfo(String id, String password, String role) {
        this.id = id;
        this.password = password;
        this.role = role;
    }

    public ArrayList<AdminAccount> getAdmin() {
        return admin;
    }

    public void setAdmin(ArrayList<AdminAccount> admin) {
        this.admin = admin;
    }

    public ArrayList<CustomerAccount> getCust() {
        return cust;
    }

    public void setCust(ArrayList<CustomerAccount> cust) {
        this.cust = cust;
    }

    public ArrayList<SellerAccount> getSeller() {
        return seller;
    }

    public void setSeller(ArrayList<SellerAccount> seller) {
        this.seller = seller;
    }
    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
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
        if (!(object instanceof UserInfo)) {
            return false;
        }
        UserInfo other = (UserInfo) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.UserInfo[ id=" + id + " ]";
    }
    
}

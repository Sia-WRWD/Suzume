package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.Items;
import model.TransactionRecords;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-05-16T16:46:55")
@StaticMetamodel(SellerAccount.class)
public class SellerAccount_ { 

    public static volatile SingularAttribute<SellerAccount, Integer> totalTransactions;
    public static volatile SingularAttribute<SellerAccount, String> address;
    public static volatile SingularAttribute<SellerAccount, Character> gender;
    public static volatile SingularAttribute<SellerAccount, Double> ratings;
    public static volatile SingularAttribute<SellerAccount, String> name;
    public static volatile ListAttribute<SellerAccount, TransactionRecords> transactionList;
    public static volatile SingularAttribute<SellerAccount, String> shopName;
    public static volatile ListAttribute<SellerAccount, Items> itemList;
    public static volatile SingularAttribute<SellerAccount, String> id;
    public static volatile SingularAttribute<SellerAccount, String> email;
    public static volatile SingularAttribute<SellerAccount, String> status;

}
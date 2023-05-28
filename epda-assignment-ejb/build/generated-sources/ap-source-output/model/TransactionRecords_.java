package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.CustomerAccount;
import model.Items;
import model.SellerAccount;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-05-16T16:46:55")
@StaticMetamodel(TransactionRecords.class)
public class TransactionRecords_ { 

    public static volatile SingularAttribute<TransactionRecords, String> date;
    public static volatile SingularAttribute<TransactionRecords, SellerAccount> seller;
    public static volatile SingularAttribute<TransactionRecords, Double> individualTransactionTotal;
    public static volatile SingularAttribute<TransactionRecords, Double> custRatings;
    public static volatile SingularAttribute<TransactionRecords, Items> item;
    public static volatile SingularAttribute<TransactionRecords, Integer> itemQuantity;
    public static volatile SingularAttribute<TransactionRecords, String> sellerStatus;
    public static volatile SingularAttribute<TransactionRecords, String> transactionIdentifier;
    public static volatile SingularAttribute<TransactionRecords, Double> selrRatings;
    public static volatile SingularAttribute<TransactionRecords, Double> itemRatings;
    public static volatile SingularAttribute<TransactionRecords, String> ccRefDigits;
    public static volatile SingularAttribute<TransactionRecords, String> selrFeedback;
    public static volatile SingularAttribute<TransactionRecords, String> ccType;
    public static volatile SingularAttribute<TransactionRecords, String> custFeedback;
    public static volatile SingularAttribute<TransactionRecords, String> itemFeedback;
    public static volatile SingularAttribute<TransactionRecords, Double> wholeTransactionTotal;
    public static volatile SingularAttribute<TransactionRecords, String> itemStatus;
    public static volatile SingularAttribute<TransactionRecords, String> id;
    public static volatile SingularAttribute<TransactionRecords, String> sellerCollectionStatus;
    public static volatile SingularAttribute<TransactionRecords, String> custStatus;
    public static volatile SingularAttribute<TransactionRecords, CustomerAccount> customer;

}
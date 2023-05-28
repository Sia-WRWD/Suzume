package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.TransactionRecords;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-05-16T16:46:55")
@StaticMetamodel(CustomerAccount.class)
public class CustomerAccount_ { 

    public static volatile SingularAttribute<CustomerAccount, Integer> totalTransactions;
    public static volatile SingularAttribute<CustomerAccount, String> address;
    public static volatile SingularAttribute<CustomerAccount, Character> gender;
    public static volatile SingularAttribute<CustomerAccount, Double> ratings;
    public static volatile SingularAttribute<CustomerAccount, String> name;
    public static volatile ListAttribute<CustomerAccount, TransactionRecords> transactionList;
    public static volatile SingularAttribute<CustomerAccount, String> id;
    public static volatile SingularAttribute<CustomerAccount, String> email;
    public static volatile SingularAttribute<CustomerAccount, String> status;

}
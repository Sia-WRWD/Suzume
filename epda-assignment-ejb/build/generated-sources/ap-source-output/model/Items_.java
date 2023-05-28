package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.SellerAccount;
import model.TransactionRecords;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-05-16T16:46:55")
@StaticMetamodel(Items.class)
public class Items_ { 

    public static volatile SingularAttribute<Items, Double> unitPrice;
    public static volatile SingularAttribute<Items, SellerAccount> seller;
    public static volatile SingularAttribute<Items, String> imgUrl;
    public static volatile SingularAttribute<Items, Integer> availableQuantity;
    public static volatile SingularAttribute<Items, Double> ratings;
    public static volatile SingularAttribute<Items, String> deliveryType;
    public static volatile SingularAttribute<Items, String> name;
    public static volatile SingularAttribute<Items, String> description;
    public static volatile SingularAttribute<Items, String> id;
    public static volatile ListAttribute<Items, TransactionRecords> transactions;
    public static volatile SingularAttribute<Items, String> category;
    public static volatile SingularAttribute<Items, String> status;

}
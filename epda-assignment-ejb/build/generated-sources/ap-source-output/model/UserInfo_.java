package model;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import model.AdminAccount;
import model.CustomerAccount;
import model.SellerAccount;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-05-16T16:46:55")
@StaticMetamodel(UserInfo.class)
public class UserInfo_ { 

    public static volatile ListAttribute<UserInfo, SellerAccount> seller;
    public static volatile SingularAttribute<UserInfo, String> password;
    public static volatile SingularAttribute<UserInfo, String> role;
    public static volatile ListAttribute<UserInfo, AdminAccount> admin;
    public static volatile SingularAttribute<UserInfo, String> id;
    public static volatile ListAttribute<UserInfo, CustomerAccount> cust;

}
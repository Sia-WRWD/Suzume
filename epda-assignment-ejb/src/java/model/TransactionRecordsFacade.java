/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Sia_RTX3070
 */
@Stateless
public class TransactionRecordsFacade extends AbstractFacade<TransactionRecords> {

    @PersistenceContext(unitName = "epda-assignment-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public TransactionRecordsFacade() {
        super(TransactionRecords.class);
    }
    
}

package com.smd.service;
import com.smd.util.DBConnection;

import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

import com.smd.model.CustomerAgedRecivable;
import com.smd.model.NewOrdersConf;
import com.smd.model.Payment;


public class CreditSalesM{
//database connection of payment 
public Payment[] getPaymentdetails() {
	List<Payment> ll = new LinkedList<Payment>();
	Payment[] array = null;
	DBConnection con = new DBConnection();
	try {
		Statement stmt = con.getConnection().createStatement();
		ResultSet rs = stmt.executeQuery("select * from paymentdetails");
		while (rs.next()) {
			Payment n = new Payment(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),
					rs.getString(5), rs.getInt(6), rs.getDouble(7), rs.getDouble(8),rs.getDouble(9));
			ll.add(n);
		}
		array = ll.toArray(new Payment[ll.size()]);

	} catch (Exception e) {}
	
	return array;

}


//database connection of New orders
public NewOrdersConf[] getNewOrderDetails() {
	List<NewOrdersConf> ll = new LinkedList<NewOrdersConf>();
	NewOrdersConf[] array = null;
	DBConnection con = new DBConnection();
	try {
		Statement stmt = con.getConnection().createStatement();
		ResultSet rs = stmt.executeQuery("select * from neworders ");
		while (rs.next()) {
			NewOrdersConf n = new NewOrdersConf(rs.getString(1), rs.getString(2), rs.getInt(3), rs.getDouble(4));
			ll.add(n);
		}

		array = ll.toArray(new NewOrdersConf[ll.size()]);

	} catch (Exception e) {
	}
	return array;
}

//database connection of CustomerAged
public CustomerAgedRecivable[] getCreditDetails() {
	List<CustomerAgedRecivable> ll = new LinkedList<CustomerAgedRecivable>();
	CustomerAgedRecivable[] array = null;
	DBConnection con = new DBConnection();
	try {
		Statement stmt = con.getConnection().createStatement();
		ResultSet rs = stmt.executeQuery("select * from customeraged");
		while (rs.next()) {
			CustomerAgedRecivable n = new CustomerAgedRecivable(rs.getString(1),rs.getString(2),rs.getDouble(3),rs. getDouble(4),
					rs.getDouble(5));
			ll.add(n);
		}

		array = ll.toArray(new CustomerAgedRecivable[ll.size()]);

	} catch (Exception e) {
	}
	return array;
}
}
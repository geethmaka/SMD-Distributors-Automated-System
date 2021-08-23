package com.smd.service;

import com.smd.util.DBConnection;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;



import com.smd.model.Customer;
import com.smd.model.CustomerAgedRecivable;
import com.smd.model.NewOrdersConf;
import com.smd.model.Order;
import com.smd.model.Payment;
import com.smd.model.PaymentDetails;
import com.smd.model.Product;

public class CreditSalesM {
	
	public CreditSalesM() {}
	DBConnection con = new DBConnection();
//database connection of payment	
	public Payment[] getPayment() {

		List<Payment> ll = new LinkedList<Payment>();
		Payment[] array = null;
		DBConnection con = new DBConnection();
		try {
			Statement stmt = con.getConnection().createStatement();
			ResultSet rs = stmt.executeQuery("select * from payment");
			while (rs.next()) {
				Payment n = new Payment(rs.getString(1), rs.getString(2), rs.getNString(3), rs.getString(4),
						rs.getDouble(5), rs.getString(6));
				ll.add(n);
			}
			array = ll.toArray(new Payment[ll.size()]);

		} catch (Exception e) {
		}

		return array;

	}

//database connection of payment details
	public PaymentDetails[] getPaymentdetails() {

		List<PaymentDetails> ll = new LinkedList<PaymentDetails>();
		PaymentDetails[] array = null;
	
		try {
			Statement stmt = con.getConnection().createStatement();
			ResultSet rs = stmt.executeQuery("select * from paymentdetails");
			while (rs.next()) {
				// rs.getNString(2)
				PaymentDetails n = new PaymentDetails(rs.getString(1), rs.getNString(2), rs.getString(3),
						rs.getDouble(4), rs.getDouble(5), rs.getDouble(6));
				ll.add(n);
			}
			array = ll.toArray(new PaymentDetails[ll.size()]);

		} catch (Exception e) {
		}

		return array;

	}

//database connection for payments
	public PaymentDetails[] getPayments(int i) {

		List<PaymentDetails> ll = new LinkedList<PaymentDetails>();
		PaymentDetails[] array = null;
		
		try {
			Statement stmt = con.getConnection().createStatement();
			ResultSet rs = stmt.executeQuery("select * from paymentdetails where Order_ID=" + i);
			while (rs.next()) {
				PaymentDetails n = new PaymentDetails(rs.getString(1), rs.getNString(3), rs.getString(4),
						rs.getDouble(5), rs.getDouble(6), rs.getDouble(7));
				ll.add(n);
			}
			array = ll.toArray(new PaymentDetails[ll.size()]);

		} catch (Exception e) {
		}

		return array;

	}

//database connection to get Remaining amount
	public int getRemainingAmount(int id) {
		
		try {
			DBConnection radbc = new DBConnection();
			Statement stmt = radbc.getConnection().createStatement();
			String command = "select Remaining_Amount from orders where Order_ID=" + id;
			ResultSet rs = stmt.executeQuery(command);
			while (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
		}
		return id;
	}

//database connection of New orders
	public NewOrdersConf[] getNewOrderDetails() {
		List<NewOrdersConf> ll = new LinkedList<NewOrdersConf>();
		NewOrdersConf[] array = null;
	
		try {
			Statement stmt = con.getConnection().createStatement();
			ResultSet rs = stmt.executeQuery("select * from neworders ");
			while (rs.next()) {
				NewOrdersConf n = new NewOrdersConf(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4),
						rs.getDouble(5));
				ll.add(n);
			}

			array = ll.toArray(new NewOrdersConf[ll.size()]);

		} catch (Exception e) {
		}
		return array;
	}

//database connection of CustomerAged
	public CustomerAgedRecivable[] getCreditAgedDetails() {
		List<CustomerAgedRecivable> ll = new LinkedList<CustomerAgedRecivable>();
		CustomerAgedRecivable[] array = null;
		
		try {
			Statement stmt = con.getConnection().createStatement();
			ResultSet rs = stmt.executeQuery("select * from customeraged");
			while (rs.next()) {
				CustomerAgedRecivable n = new CustomerAgedRecivable(rs.getString(1), rs.getString(2), rs.getString(3),
						rs.getDouble(4), rs.getDouble(5), rs.getDouble(6));
				ll.add(n);
			}

			array = ll.toArray(new CustomerAgedRecivable[ll.size()]);

		} catch (Exception e) {
		}
		return array;
	}

////Cash Calcactors details
//public Employee[] getCashCalactorsDetails() {
//	List<Employee> ll = new LinkedList<Employee>();
//	Employee[] array = null;
//	DBConnection con = new DBConnection();
//	try {
//		Statement stmt = con.getConnection().createStatement();
//		ResultSet rs = stmt.executeQuery("select * from employee where Emp_Type='cashCollector'");
//		while (rs.next()) {
//			Employee n = new CustomerAgedRecivable(rs.getString(1), rs.getString(2), rs.getString(3),
//					rs.getDouble(4), rs.getDouble(5), rs.getDouble(6));
//			ll.add(n);
//		}
//
//		array = ll.toArray(new Employee[ll.size()]);
//
//	} catch (Exception e) {
//	}
//	return array;
//}

//customers Details
	public Customer[] getCustomrDetailstocredit() {
		List<Customer> ll = new LinkedList<Customer>();
		Customer[] array = null;
		DBConnection con = new DBConnection();
		try {
			Statement stmt = con.getConnection().createStatement();
			ResultSet rs = stmt.executeQuery(
					"select Cus_ID,Hardware_Name,Phone,Email,Address from customer where Status='Active'");
			while (rs.next()) {
				Customer n = new Customer(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),
						rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9),
						rs.getString(10));
				ll.add(n);
			}

			array = ll.toArray(new Customer[ll.size()]);

		} catch (Exception e) {
		}
		return array;
	}

	//PaymentVerification
	public boolean getPayCredit(int CID,int OID) {
		
		List<Order> ll = new LinkedList<Order>();
		Order[] array = null;
		
		
		try {
			Statement stmt = con.getConnection().createStatement();
			ResultSet rs = stmt.executeQuery(
					"select * from orders"+ "where order_ID ="+OID+"and"+"Cust_ID"+"="+CID+";");
			while (rs.next()) {
				Order n = new Order(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getDouble(5),
						rs.getDouble(6), rs.getDouble(7), rs.getInt(8), rs.getInt(9));
				ll.add(n);
			}

			array = ll.toArray(new Order[ll.size()]);
			
		} catch (Exception e) {
		}
		
		if(array.length>0) {
			return false;
		}
		else {
			return true;
		}

	}
	
	
	//Search
	public PaymentDetails[] search(String search) {
		List<PaymentDetails> ll = new LinkedList<PaymentDetails>();
		PaymentDetails[] array = null;
		try {
			Statement stmt=con.getConnection().createStatement();
			String command= "SELECT * from smd.paymentdetails WHERE Hardware_Name LIKE '%"+search+"%'";
			ResultSet rs=stmt.executeQuery(command);
			while(rs.next()) {
				PaymentDetails n = new PaymentDetails(rs.getString(1), rs.getNString(3), rs.getString(4),
						rs.getDouble(5), rs.getDouble(6), rs.getDouble(7));
				ll.add(n);
			}
			
			array = ll.toArray(new PaymentDetails[ll.size()]);
			 
		} catch (Exception e) {
			System.out.println(e);
		}
		return array;
	}
	
	
	
}

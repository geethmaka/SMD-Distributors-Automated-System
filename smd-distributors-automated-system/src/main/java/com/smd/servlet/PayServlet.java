package com.smd.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smd.service.CreditSalesM;
import com.smd.util.DBConnection;
import com.smd.model.Order;
import com.smd.model.PaymentDetails;

@WebServlet("/pay")
public class PayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	@SuppressWarnings("unused")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int CID = (Integer.parseInt(request.getParameter("CID")));
		int OID = (Integer.parseInt(request.getParameter("OID")));
		CreditSalesM check = new CreditSalesM();
		Order add = check.getOrder(CID, OID);
//		PaymentDetails pay = (PaymentDetails) request.getSession().getAttribute("Emp_ID");

//		pay.setPaidAmount(Double.parseDouble(request.getParameter("PaidAmount")));
//		pay.setDate(request.getParameter("Date"));
//		check.setOID(Integer.parseInt(request.getParameter("OID")));
//		check.setCID(Integer.parseInt(request.getParameter("CID")));
//		pay.setEmpID(request.getParameter("EmpID"));

		// Check customer ID and order ID
		boolean status = check.getPayCredit(CID, OID);

		if (status == false) {

			try {

				DBConnection pdbc = new DBConnection();
				Statement stmt = pdbc.getConnection().createStatement();
				// insert data into payment table
				String command = "INSERT INTO payment(Amount,Date,Order_ID,Cus_ID,Emp_ID)" + "VALUES('"
						+ request.getParameter("PaidAmount") + "'" + "," + "'" + request.getParameter("Date") + "'"
						+ "," + "'" + OID + "'" + "," + "'" + CID + "'" + "," + "'1'" + ")";
				double pamount = add.getPAMOUNT();
				double ramount = add.getRAMOUNT();
				double paidAmount = Double.parseDouble(request.getParameter("PaidAmount"));
				double TotalPaid = pamount + paidAmount;
				double TotalRemain = ramount - paidAmount;

				// update the order table
				String command1 = "update orders SET Paid_Amount =" + TotalPaid + "," + " Remaining_Amount="
						+ TotalRemain + " WHERE Cust_ID =" + CID + " and Order_ID=" + OID;

				// update order status into paid
				String command2 = "update orders SET Order_Status ='Paid'  WHERE Remaining_Amount=0 and Cust_ID =" + CID
						+ " and Order_ID=" + OID;

				stmt.execute(command);
				stmt.executeUpdate(command1);
				stmt.executeUpdate(command2);

//				response.getWriter().append(command);
//				response.getWriter().append(command1);

				RequestDispatcher dispatcher = getServletContext()
						.getRequestDispatcher("/admin/CreditSalesManagement/CreditPayment.jsp");
				request.setAttribute("message", "You have successfully paid");
				dispatcher.forward(request, response);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		else {
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher("/admin/CreditSalesManagement/CreditPayment.jsp");
			request.setAttribute("message", "You entered the Order ID or Customer ID incorrectly, please try again !!");
			dispatcher.forward(request, response);

		}

	}

}

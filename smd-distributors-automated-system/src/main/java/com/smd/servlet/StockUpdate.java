
package com.smd.servlet;

import java.io.IOException;

import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smd.service.StockDB;
import com.smd.util.DBConnection;
import com.smd.model.Stock;

@WebServlet("/StockUpdate")
public class StockUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public StockUpdate() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		StockDB stockdb = new StockDB();
		
		if(request.getParameter("button").equals("add")) {
			
			try {
				DBConnection sdbc = new DBConnection();
				Statement stmt = sdbc.getConnection().createStatement();
				String command = "INSERT INTO stock(Item_name,Date,Quantity,Status)" + "" + "VALUES('" +request.getParameter("itemname")
						+ "','" + request.getParameter("Date") + "','" + request.getParameter("quntity") +"', 'add')";
				stmt.execute(command);
				
//response.getWriter().append(command.toString());
				response.sendRedirect("admin/StockManagement/StockPage.jsp");
			} catch (Exception e) {
				e.printStackTrace();
			}
				
			}
		else if (request.getParameter("button").equals("delete"))	{
			try {
				DBConnection sdbc = new DBConnection();
				Statement stmt = sdbc.getConnection().createStatement();
				String command = "INSERT INTO stock(Item_name,Date,Quantity,Status)" + "" + "VALUES('" +request.getParameter("itemname")
						+ "','" + request.getParameter("Date") + "','" + request.getParameter("quntity") + "','delete')";
				stmt.execute(command);

				response.sendRedirect("admin/StockManagement/StockPage.jsp");
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
		}
			
			
		}
		
	
	}


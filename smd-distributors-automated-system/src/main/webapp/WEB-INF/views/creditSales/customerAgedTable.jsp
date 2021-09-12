<%@ page import="com.smd.model.PaymentDetails"%><!--Import NewOrderCOnf.class-->
<%@ page import="com.smd.service.CreditSalesM"%><!-- Import Database connection of creditSales -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!--checking user logged or not -->
<!-- creating array to get data from database -->
<%
if (request.getSession().getAttribute("Logged") == null) {
	request.getSession().setAttribute("Logged", "Guest");
}

CreditSalesM cdbc = new CreditSalesM();
PaymentDetails[] customerAged = (PaymentDetails[]) cdbc.getPaymentdetails();
request.setAttribute("data", customerAged);
%>

<div class="col-9">
	<!-- Horizontal navigation bar -->
	<jsp:include page="centerNav.jsp"></jsp:include>
	<center>
		<h5>Customer Aged Recivable</h5>
	</center>
	<!--Creating customerage table-->
	<table id="customerDetails" class="display nowrap" style="width: 100%">
		<c:choose>
			<c:when test="${param.search==null}">
				<%
				CreditSalesM con = new CreditSalesM();
				PaymentDetails[] allPayments = con.getPaymentdetails();
				request.setAttribute("allPayments", allPayments);
				%>

				<thead>
					<tr>

						<th scope="col">Hardware Name</th>
						<th scope="col">Invoice ID</th>
						<th scope="col">Total Price</th>
						<th scope="col">Paid Amount</th>
						<th scope="col">Remaining Amount</th>
						<th scope="col">Status</th>


					</tr>
				</thead>
				<tbody>
					<c:forEach items="${data}" var="PaymentDetails">
						<tr>



							<td><c:out value="${PaymentDetails.getCusName()}" /></td>
							<td><c:out value="${PaymentDetails.getInvoiceID()}" /></td>
							<td><c:out value="${PaymentDetails.getTotalAmount()}" /></td>
							<td><c:out value="${PaymentDetails.getPaidAmount()}" /></td>
							<td><c:out value="${PaymentDetails.getBalance()}" /></td>
							<td><c:out value="${PaymentDetails.getStatus()}" /></td>



						</tr>
					</c:forEach>
				</tbody>
			</c:when>
			<c:otherwise>
				<%
				CreditSalesM con = new CreditSalesM();
				PaymentDetails[] searchPay = con.search(request.getParameter("search"));
				request.setAttribute("searchData", searchPay);
				%>
				<c:forEach items="${searchData}" var="PaymentDetails">
					<thead>
						<tr>

							<th scope="col">Hardware Name</th>
							<th scope="col">Invoice ID</th>
							<th scope="col">Total Price</th>
							<th scope="col">Paid Amount</th>
							<th scope="col">Remaining Amount</th>
							<th scope="col">Status</th>


						</tr>
					</thead>
					<tbody>
						<tr>

							<td><c:out value="${PaymentDetails.getCusName()}" /></td>
							<td><c:out value="${PaymentDetails.getInvoiceID()}" /></td>
							<td><c:out value="${PaymentDetails.getTotalAmount()}" /></td>
							<td><c:out value="${PaymentDetails.getPaidAmount()}" /></td>
							<td><c:out value="${PaymentDetails.getBalance()}" /></td>
							<td><c:out value="${PaymentDetails.getStatus()}" /></td>
						</tr>
				</c:forEach>
				</tbody>
			</c:otherwise>
		</c:choose>
	</table>

	<p align="right">
		<button type="button" class="btn btn-secondary"
			style="background-color: #b8b8b8">Generate Report</button>
	</p>
</div>

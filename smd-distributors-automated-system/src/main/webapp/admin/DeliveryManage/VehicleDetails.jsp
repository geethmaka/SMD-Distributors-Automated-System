<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../../WEB-INF/views/common/head.jsp">
	<jsp:param name="Title" value="SMD Distributors/Delivery Management" /></jsp:include>
	<meta charset="ISO-8859-1">
</head>
<body>
	
	
	
	
	<jsp:include page="../../WEB-INF/views/common/head.jsp"></jsp:include>
	<jsp:include page="../../WEB-INF/views/common/adminHeader.jsp"></jsp:include>
		
		<div class="row">
			<jsp:include
				page="../../WEB-INF/views/Delivery/AddVehicleNavi.jsp"></jsp:include>
			<div class="col-10">
	
		<center>
			<h3>Vehicle Details</h3>
		</center>
		
	
	<table class="table table-hover">
	
		<thead>
			<tr>
	
				<th scope="col">Vehicle Number</th>
				<th scope="col">Insurence_Exp</th>
				<th scope="col">Licence_Exp</th>
				<th scope="col">Status</th>
				<th scope="col">Supported_Weight</th>
				<th scope="col">Vehicle_Type</th>
			
			</tr>
		</thead>
		
		<tbody>
			<c:forEach var="veh" items="${vehicleDetails}">
				<form action=<%=request.getContextPath() + "/vupdated"%> method="post">
				
				<tr>
					<td><input type="text" value="${veh.getVehicleNum()}" name="vnum" class="form-control" readonly/></td>
					<td><input type="date" value="${veh.getInsurenceExp()}" name="vin" class="form-control" /></td>
					<td><input type="date" value="${veh.getLicenceExp()}" name="vl" class="form-control" /></td>
					<td><input type="text" value="${veh.getStatus()}" name="vs" class="form-control" /></td>
					<td><input type="text" value="${veh.getWeight()}" name="vw" class="form-control" readonly/></td>
					<td><input type="text" value="${veh.getType()}" name="vt" class="form-control" readonly/></td>	
					<td><input type="submit" name="uodate" value="Update" class="btn btn-primary"style="background-color:#fbda57; color:#000000"> </td>
				</tr>
				</form>
				
				<form  action=<%=request.getContextPath() + "/vdeleted"%>  method="post">
				<tr>
					<td/><td/><td/><td/><td/>
					<td><input type="hidden" value="${veh.getVehicleNum()}" name="did" class="form-control" id="formGroupExampleInput" readonly/></td>
					<td><input type="submit" name="delete" value="Delete" class="btn btn-primary"style="background-color:#fbda57; color:#000000"> </td>
				</tr>
				</form>
	
			</c:forEach>
	
		</tbody>
	</table>
	
	
	</div>
	</div>
	
			
		<jsp:include page="../../WEB-INF/views/common/adminFooter.jsp"></jsp:include>
		
</body>
</html>
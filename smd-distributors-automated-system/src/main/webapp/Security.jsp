<jsp:include page="WEB-INF/views/common/head.jsp">
	<jsp:param name="Title" value="SMD Distributors | Profile" /></jsp:include>
	<link rel="stylesheet" type="text/css" href=<%=request.getContextPath() + "/css/profile.css"%>>
<body>
	<script src=<%=request.getContextPath()+"/js/pwdValidation.js"%>></script>
	<jsp:include page="WEB-INF/views/common/header.jsp"></jsp:include>
	<jsp:include page="WEB-INF/views/customer/updatePwd.jsp"></jsp:include>
	<jsp:include page="WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>
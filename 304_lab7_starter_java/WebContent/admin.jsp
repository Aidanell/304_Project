<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

    <%@ include file="auth.jsp"%>
    <%@ include file="jdbc.jsp" %>

<h1 align='center'>Admin Page</h2>

<h2 align="center"><a href="dailySales.jsp">Daily Sales</a></h2> 

<h2 align="center"><a href="addProduct.jsp">Add Product</a></h2> 

<h2 align="center"><a href="deleteProduct.jsp">Delete/Update Product</a></h2> 

<h2 align="center"><a href="addWarehouse.jsp">Add Warehouse</a></h2>

<h2 align="center"><a href="listCust.jsp">List All Customers</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>


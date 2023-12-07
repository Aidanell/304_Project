<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
</head>
<body>

	<%@ include file="jdbc.jsp" %>
<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>
<br>
<form method="get" action="listprod.jsp">
<label for="categories">Browse by Category:</label> 
    <select name="categories" id="categories">
		<%
		String ActiveCategory = request.getParameter("categories");
		if(ActiveCategory != null){
			out.println("<option value="+ActiveCategory+">"+ActiveCategory+"</option>");
		}
		out.println("<option value=None>None</option>");
		getConnection();
		PreparedStatement stmt = con.prepareStatement("SELECT * FROM category");
		ResultSet rst1 = stmt.executeQuery();
		while(rst1.next()){
			String categoryname = rst1.getString("categoryName");
			out.println("<option value="+categoryname+">"+categoryname+"</option>");
		}
		closeConnection();
		%>
    </select>
	<input type="submit" value="Submit">
</form>
<br>
<form method="get" action="listprod.jsp">
	<input type="submit" style="height:35px; width:250px" value="Search Products With Photos" name="withImage">
</form>


<h3><a href='showcart.jsp'>View Cart</a></h3>

<% // Get product name to search for
String name = request.getParameter("productName");
String category = request.getParameter("categories");
String justImages = request.getParameter("withImage");
String sortBySales = request.getParameter("sortBySales");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}


try ( Connection con = DriverManager.getConnection(url, uid, pw);) 
	    {	

			//Using correct sql query based on search
			String SQL;
			PreparedStatement pstmt;
			ResultSet rst;

			if(name != null){
				SQL = "SELECT * FROM product WHERE productName LIKE '%"+name+"%'";
				pstmt = con.prepareStatement(SQL);
				rst = pstmt.executeQuery();
			}else if(category != null){
				SQL =  "SELECT * FROM product JOIN category ON product.categoryId = category.categoryId WHERE category.categoryName = ?";
				pstmt = con.prepareStatement(SQL);
				pstmt.setString(1, category);
				rst = pstmt.executeQuery();
			}else if(justImages != null){
				SQL = "SELECT * FROM product WHERE productImage IS NOT NULL OR productImageURL IS NOT NULL";
				pstmt = con.prepareStatement(SQL);
				rst = pstmt.executeQuery();
			}else if(sortBySales != null){
				SQL = "SELECT * FROM product JOIN (SELECT productId, SUM(totalPrice) AS grossSales FROM  (SELECT productId, price*quantity AS totalPrice FROM orderproduct) GROUP BY productId) AS right ON product.productId = right.productId ORDER BY grossSales";
				pstmt = con.prepareStatement(SQL);
				rst = pstmt.executeQuery();
			}else{
				SQL = "SELECT * FROM product";
				pstmt = con.prepareStatement(SQL);
				rst = pstmt.executeQuery();
			}
			


			NumberFormat currFormat = NumberFormat.getCurrencyInstance();

			//Starting table
			out.println("<h2>All Products</h2>");
			out.println("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");

			while(rst.next()){

				int currentPId = rst.getInt("productId");
				String currentPName = rst.getString("productName");
				double currentPrice = rst.getDouble("productPrice");

				//Creating link
				String link = "addcart.jsp?id="+currentPId+"&name="+currentPName+"&price="+currentPrice;
				String newurl = link.replaceAll(" ","%20");

				String productInfo = "product.jsp?id=" + currentPId;
				
				out.println("<tr><td><a href="+newurl+">Add to Cart</a></td>");
				out.println("<td><a href="+productInfo+">"+currentPName+"</a></td>");
				out.println("<td>"+currFormat.format(currentPrice)+"</td>");
			}
			out.println("</table>");

			out.println("<h3><a href='index.jsp'>Main Page</a></h3>");
		}
		catch (SQLException ex)
		{
			out.println(ex);
		}	

%>

</body>
</html>
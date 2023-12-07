<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Make connection

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";
try ( Connection con = DriverManager.getConnection(url, uid, pw);
	          Statement stmt = con.createStatement();) 
	    {			


// Write query to retrieve all order summary records
			ResultSet rst = stmt.executeQuery("SELECT * FROM ordersummary JOIN customer ON ordersummary.customerId = customer.customerId");
			out.println("<table border='1'><tr><th>Order Id</th><th>Order Date</th>" +
					"<th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");



			NumberFormat currFormat = NumberFormat.getCurrencyInstance();

			while(rst.next()){

				int orderId = rst.getInt("orderId");

				out.println("<tr><td>"+orderId+"</td>");
				out.println("<td>"+rst.getTimestamp("orderDate")+"</td>");
				out.println("<td>"+rst.getInt("customerId")+"</td>");
				out.println("<td>"+rst.getString("firstName")+" "+rst.getString("lastName")+"</td>");
				out.println("<td>"+currFormat.format(rst.getDouble("totalAmount"))+"</td>");
				out.println("</tr>");

				out.println("<tr align='right'> <td colspan='4'>");
				out.println("<table border='1'> <th>ProductId</th> <th>Quantity</th> <th>Price</th> </tr>");

				//Getting all products from this order
				String SQL = "SELECT * FROM orderproduct WHERE orderId = ?";
				PreparedStatement customerPtmst = con.prepareStatement(SQL);
				customerPtmst.setInt(1, orderId);
				ResultSet rst2 = customerPtmst.executeQuery();

				//Add product to table 
				while(rst2.next()){
					out.println("<tr><td>"+rst2.getInt("productId")+"</td>");
					out.println("<td>"+rst2.getInt("quantity")+"</td>");
					out.println("<td>"+currFormat.format(rst2.getInt("price"))+"</td></tr>");
					
				}

				out.println("</table>");
			}

			out.println("</table>");
			out.println("<h3><a href='admin.jsp'>Back to Admin</a></h3>");
		}
		catch (SQLException ex)
		{
			out.println(ex);
		}	
%>

</body>
</html>


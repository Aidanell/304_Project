<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List Customer's Order's</title>
</head>
<body>
    <h1>Order List</h1>

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.NumberFormat" %>

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
              ) 
	    {			
            String sql = "SELECT * FROM ordersummary JOIN customer ON ordersummary.customerId = customer.customerId WHERE customer.userid = ?";
	          PreparedStatement pstmt = con.prepareStatement(sql);
              String userName = (String) session.getAttribute("authenticatedUser");
              pstmt.setString(1, userName);

// Write query to retrieve all order summary records
			ResultSet rst = pstmt.executeQuery();

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
		}
		catch (SQLException ex)
		{
			out.println(ex);
		}	
%>

</body>
</html>
<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>
<%@ page import="java.sql.*" %>
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// TODO: Print Customer information
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";
String sql = "SELECT * FROM customer WHERE userid = ?";



try (Connection con = DriverManager.getConnection(url, uid, pw);) 
	    {	
            PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userName);
			ResultSet rst = pstmt.executeQuery();
			rst.next();

			out.println("<h2>Customer Profile</h2>");
			out.println("<table border='1'>");
			out.println("<tr><th>Id</th><td>"+rst.getString("customerId")+"</td></tr>");
			out.println("<tr><th>First Name</th><td>"+rst.getString("firstName")+"</td></tr>");
			out.println("<tr><th>Last Name</th><td>"+rst.getString("lastName")+"</td></tr>");
			out.println("<tr><th>Email</th><td>"+rst.getString("email")+"</td></tr>");
			out.println("<tr><th>Phone</th><td>"+rst.getString("phonenum")+"</td></tr>");
			out.println("<tr><th>Address</th><td>"+rst.getString("address")+"</td></tr>");
			out.println("<tr><th>City</th><td>"+rst.getString("city")+"</td></tr>");
			out.println("<tr><th>State</th><td>"+rst.getString("state")+"</td></tr>");
			out.println("<tr><th>Postal Code</th><td>"+rst.getString("postalCode")+"</td></tr>");
			out.println("<tr><th>Country</th><td>"+rst.getString("country")+"</td></tr>");
			out.println("<tr><th>User Id</th><td>"+userName+"</td></tr>");
			out.println("<tr><th colspan=2><a href='updateCustomer.jsp'>Update Info</a></th></tr>");
			out.println("</table>");

			out.println("<h3><a href='index.jsp'>Main Page</a></h3>");
        }
		catch (SQLException ex)
		{
			out.println(ex);
		}



// Make sure to close connection
%>

</body>
</html>


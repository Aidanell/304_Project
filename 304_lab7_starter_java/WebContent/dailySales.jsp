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

<%




// TODO: Write SQL query that prints out total order amount by day

String sql = "SELECT CAST(orderDate AS DATE) AS date, SUM(totalAmount) AS totalSales FROM ordersummary GROUP BY CAST(orderDate AS DATE)";

// Make the connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try (Connection con = DriverManager.getConnection(url, uid, pw);) 
	    {	
            PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rst = pstmt.executeQuery();

            out.println("<h2>Administrator Sales Report By Day</h1>");
            out.println("<table border='1'><tr><th>Date</th><th>Total Sales</th></tr>");
            while(rst.next()){
                out.println("<tr align='right'><td>"+rst.getDate("date")+"</td>");
                out.println("<td>"+currFormat.format(rst.getDouble("totalSales"))+"</td></tr>");  
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

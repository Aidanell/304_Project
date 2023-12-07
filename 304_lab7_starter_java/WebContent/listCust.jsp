<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <%@ include file="jdbc.jsp" %>

    <%
    String delete = request.getParameter("delete");
    if(delete != null){
        out.println("<h2>Customer Deleted Successfully!</h2>");
    }


    getConnection();
    String sql = "SELECT * FROM customer";
    PreparedStatement stmt = con.prepareStatement(sql);
    ResultSet rst = stmt.executeQuery();
    out.println("<h2>All Customer Profiles</h2>");
    while(rst.next()){
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
			out.println("<tr><th>User Id</th><td>"+rst.getString("userid")+"</td></tr>");
            String url = "deleteCustomer.jsp?cid=" + rst.getString("customerId");
            out.println("<tr><th colspan='2'><a href="+url+">Delete Customer</a></th></tr>");
            out.println("</table><br>");
    }


    %>
    <h2><a href='admin.jsp'>Go Back</a></h2>
</body>
</html>
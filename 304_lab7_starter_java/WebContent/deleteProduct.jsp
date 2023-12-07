<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <%@ include file="jdbc.jsp" %>
    <%@ page import="java.text.NumberFormat" %>



    <%
    //Deletes product from database if id is given as parameter
    String pid = request.getParameter("id");
    if(pid != null){
        getConnection();

        try{
            String sql = "DELETE FROM product WHERE productId = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, pid);
        pstmt.executeUpdate();
        closeConnection();
        out.println("<h3 align='center'>Product "+pid+ " deleted succesfully!</h3>");
        }catch (SQLException ex)
		{
			out.println("<h3 align='center'> You cannot delete products that have been ordered!</h3>");
		}	
        
    }
    %>





    
    <%
    //Displays all products with a link to delete them
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    getConnection();
    //Starting table
			out.println("<h2>All Products</h2>");
			out.println("<table><tr><th>ID</th><th>Product Name</th><th>Price</th></tr>");
            
            String sql = "SELECT * FROM product";
            Statement stmt = con.createStatement();
            ResultSet rst = stmt.executeQuery(sql);

			while(rst.next()){

				int currentPId = rst.getInt("productId");
				String currentPName = rst.getString("productName");
				double currentPrice = rst.getDouble("productPrice");

				//Creating link
				String link = "deleteProduct.jsp?id="+currentPId;

				String productInfo = "product.jsp?id=" + currentPId;
				
                String updatelink = "updateProduct.jsp?id=" + currentPId;
				
                out.println("<tr><td>"+currentPId+"</td>");
				out.println("<td><a href="+productInfo+">"+currentPName+"</a></td>");
				out.println("<td>"+currFormat.format(currentPrice)+"</td>");
                out.println("<td><a href="+updatelink+">Update  </a></td>");
                out.println("<td><a href="+link+">Delete</a></td></tr>");
			}
			out.println("</table>");

        closeConnection();
        %>

        <h2><a href='admin.jsp'>Go Back</a></h2>
</body>
</html>
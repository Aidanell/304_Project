<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h2>ayo</h2>
    <%@ include file="jdbc.jsp" %>
    <%@ page import="java.io.InputStream" %>
    <%@ page import="java.io.IOException" %>
    <%@ page import="javax.servlet.http.Part" %>
    <%
    String pname = request.getParameter("pname");
    String price = request.getParameter("price");
    String desc = request.getParameter("desc");


    if(pname.length() < 1 || price.length() < 1 || desc.length() < 1){
        String redirectURL = "http://localhost/shop/addProduct.jsp?error=true";
        response.sendRedirect(redirectURL);
    }else{

        getConnection();

        try{
        String sql = "INSERT INTO product(productName, productPrice, productDesc) VALUES(?,?,?)";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, pname);
        pstmt.setDouble(2, Double.parseDouble(price));
        pstmt.setString(3, desc);
        pstmt.executeUpdate();
        }catch (SQLException ex)
		{
			out.println(ex);
		}
        
        closeConnection();
    }



    %>
</body>
</html>
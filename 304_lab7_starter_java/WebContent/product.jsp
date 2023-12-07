<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<%@ page import="java.io.*" %> 
<%@ page import="java.awt.image.BufferedImage" %> 
<%@ page import=" java.io.ByteArrayInputStream" %> 
<%@ page import="java.io.ByteArrayOutputStream" %> 
<%@ page import="java.io.File" %> 
<%@ page import="java.io.IOException" %>  
<%@ page import="javax.imageio.ImageIO" %> 


<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>


<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";
try ( Connection con = DriverManager.getConnection(url, uid, pw);) 
	    {	
            String sql = "SELECT * FROM product WHERE productId = " + productId;
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rst = pstmt.executeQuery();


            rst.next();
            String prodName = rst.getString("productName");
            String imURL = rst.getString("productImageURL");
            NumberFormat currFormat = NumberFormat.getCurrencyInstance();
            Double price = rst.getDouble("productPrice");
            byte[] byteImage = rst.getBytes("productImage");
            String desc = rst.getString("productDesc");


            out.println("<h1>"+prodName+"</h1>");
            // TODO: If there is a productImageURL, display using IMG tag
            if(imURL != null)
                out.println("<img src="+imURL+">");

            // TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
            if(byteImage != null)
                out.println("<img src='http://localhost/shop/displayImage.jsp?id=1'>");
            out.println("<h4>ID: "+productId+"</h4>");
            out.println("<h4>Price: "+currFormat.format(price)+"</h4>");

            out.println("<h3>Desciption:</h3> "+desc);

            // TODO: Add links to Add to Cart and Continue Shopping
            String link = "addcart.jsp?id="+productId+"&name="+prodName+"&price="+price;
			String newurl = link.replaceAll(" ","%20");
            out.println("<h2><a href="+newurl+">Add to Cart</a></h2>");
            out.println("<h2><a href='listprod.jsp'>Continue Shopping</a></h2>");


        }
        catch (SQLException ex)
		{
			out.println(ex);
		}



	
		
%>

</body>
</html>


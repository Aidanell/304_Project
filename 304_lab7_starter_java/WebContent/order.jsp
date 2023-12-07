<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.regex.Matcher"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.time.LocalDate"%>

<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

//Regex for appropriate customerId
Pattern pattern = Pattern.compile("^[1-9]\\d*$", Pattern.CASE_INSENSITIVE);
Matcher matcher = pattern.matcher(custId);
boolean matchFound = matcher.find();


NumberFormat currFormat = NumberFormat.getCurrencyInstance();

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";

//Checking if customerId is valid with regex
if(!matchFound){ 
	out.println("<h1>Invalid customer id. Go back to the previous page and try again.</h1>");
//check if cart is empty
}else if(productList == null){
	out.println("<h1>There are no products in your cart. Go back</h1>");
}else{

	//Current timestamp
	Timestamp datetime = new Timestamp(System.currentTimeMillis());

	//Calulating totalAmount of all products
	double totalAmount = 0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
		while (iterator.hasNext())
		{ 
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			String price = (String) product.get(2);
			double pr = Double.parseDouble(price);
			totalAmount += pr;
		}



	try ( Connection con = DriverManager.getConnection(url, uid, pw);) 
	    {
			//Inserting into ordersummary
			String sql = "INSERT INTO ordersummary(orderDate, totalAmount, customerId) VALUES(?, ?, ?)";
			PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstmt.setTimestamp(1, datetime);
			pstmt.setDouble(2, totalAmount);
			pstmt.setString(3, custId);
			pstmt.executeUpdate();	

			//Getting generated orderid
			ResultSet keys = pstmt.getGeneratedKeys();
			keys.next();
			int orderId = keys.getInt(1);

			//Start of table
			out.println("<h1>Your Order Summary</h1>");
			out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

	
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator2 = productList.entrySet().iterator();
				while (iterator2.hasNext())
				{ 
					//Getting data for current product
					Map.Entry<String, ArrayList<Object>> entry2 = iterator2.next();
					ArrayList<Object> product2 = (ArrayList<Object>) entry2.getValue();
					String productId = (String) product2.get(0);
					String productName = (String) product2.get(1);
					String price = (String) product2.get(2);
					double pr = Double.parseDouble(price);
					int qty = ( (Integer)product2.get(3)).intValue();



					//Printing out product data for current product
					out.println("<tr><td>"+productId+"</td><td>"+productName+"</td>");
					out.println("<td>"+qty+"</td><td>"+currFormat.format(pr)+"</td>");
					double subTotal = qty * pr;
					out.println("<td>"+currFormat.format(pr)+"</td></tr>");


					//Inserting data for orderproduct
					String SQL = "INSERT INTO orderproduct(orderId, productId, quantity, price) "
								 +"VALUES(?, ?, ?, ?)";
					PreparedStatement pstmt2 = con.prepareStatement(SQL);
					pstmt2.setInt(1, orderId);
					pstmt2.setString(2, productId);
					pstmt2.setInt(3, qty);
					pstmt2.setDouble(4, pr);

					pstmt2.executeUpdate();

				}
			
			//Finishing table and rest of page
			out.println("<tr><td colspan='4' align='right'><b>Order Total</b></td>");
			out.println("<td align=>"+currFormat.format(totalAmount)+"</td></tr>");
			out.println("</table>");
			out.println("<h2>Your order reference number is "+orderId+"</h2>");
			out.println("<h2>Shipping to Customer: "+custId+"</h2>");


			//Clear cart
			session.removeAttribute("productList");


		}	
		catch (SQLException ex)
		{
			out.println(ex);
		}	
}

%>
</BODY>
</HTML>


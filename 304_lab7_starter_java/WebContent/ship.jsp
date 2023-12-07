<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
	String orderId = (String) request.getParameter("orderId");

	// TODO: Check if valid order id in database
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw";

	Connection con = DriverManager.getConnection(url, uid, pw);
	    
	String sql = "SELECT * FROM ordersummary WHERE orderId = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, orderId);
	ResultSet rst = pstmt.executeQuery();

	boolean validOrderId = rst.isBeforeFirst();

	if(validOrderId){
		// TODO: Start a transaction (turn-off auto-commit)
		con.setAutoCommit(false);
	
	// TODO: Retrieve all items in order with given id
		String sql2 = "SELECT * FROM orderproduct WHERE orderId = ?";
		PreparedStatement pstmt2 = con.prepareStatement(sql2);
		pstmt2.setString(1, orderId);
		ResultSet rst2 = pstmt2.executeQuery();


		// TODO: Create a new shipment record.
		String sql3 = "INSERT INTO shipment(shipmentDate, warehouseId) VALUES (?,1)";
		Timestamp datetime = new Timestamp(System.currentTimeMillis());
		PreparedStatement pstmt3 = con.prepareStatement(sql3);
		pstmt3.setTimestamp(1, datetime);
		pstmt3.executeUpdate();



		// TODO: For each item verify sufficient quantity available in warehouse 1.
		boolean enoughProducts = true;

		while(rst2.next() && enoughProducts){
			String productId = rst2.getString("productId");

			String sql4 = "SELECT * FROM productInventory WHERE productId = ? AND warehouseId = 1";
			PreparedStatement pstmt4 = con.prepareStatement(sql4);
			pstmt4.setString(1, productId);
			ResultSet rst4 = pstmt4.executeQuery();
			rst4.next();
			
			Integer warehouseQuantity = (Integer) rst4.getObject("quantity");
			Integer quantityNeeded = (Integer) rst2.getObject("quantity");
			
			if(quantityNeeded > warehouseQuantity){
				enoughProducts = false;
				out.println("<h2>Shipment not done. Insufficient inventory for product id: "+productId+"</h2>");
			}else{
				int newInventory = warehouseQuantity - quantityNeeded;
				out.println("<h2>Ordered Product : "+productId+" Quantity: "+quantityNeeded+" Previous inventory: "+warehouseQuantity+ " New inventory: "+newInventory+"</h2>");
			}
		}

		// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
		if(!enoughProducts){
			con.rollback();


		}else{

			//This code will update inventory of all products in the warehouse
			//However, running this code will not allow to test shipment 1 multiple times 
			//as their will not be enough inventory after 1 test so I have left it commented out
			/*
			while(rst2.previous()){} //reset resultSet

			while(rst2.next()){
				String productId = rst2.getString("productId");

				String sql4 = "SELECT * FROM productInventory WHERE productId = ? AND warehouseId = 1";
				PreparedStatement pstmt4 = con.prepareStatement(sql4);
				pstmt4.setString(1, productId);
				ResultSet rst4 = pstmt4.executeQuery();
				rst4.next();
			
				Integer warehouseQuantity = (Integer) rst4.getObject("quantity");
				Integer quantityNeeded = (Integer) rst2.getObject("quantity");

				
				int changeInInventory = warehouseQuantity - quantityNeeded;

				String sql5 = "UPDATE productInventory SET warehouseQuantity = ? WHERE productId = ? AND warehouseId = ?";
				PreparedStatement pstmt5 = con.prepareStatement(sql5);

				pstmt5.setInteger(1, changeInInventory);
				pstmt5.setString(2, productId);
				pstmt5.setString(3, 1);
				pstmt5.executeUpdate();
			}

			*/


			con.commit();
			out.println("<h1>Shipment successfully processed</h1>");
		}

	
	// TODO: Auto-commit should be turned back on
	con.setAutoCommit(true);
	}
	
	
	
	con.close();
%>  .                     				

<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>

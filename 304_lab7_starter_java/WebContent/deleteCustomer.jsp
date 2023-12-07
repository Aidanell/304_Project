<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h2>Ayo</h2>
    <%@ include file="jdbc.jsp" %>
    <%
        getConnection();


        String sql = "DELETE FROM customer WHERE customerId = ?";
        String cid = request.getParameter("cid");

        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, cid);
        pstmt.executeUpdate();

        closeConnection();

        String redirectURL = "http://localhost/shop/listCust.jsp?delete=true";
        response.sendRedirect(redirectURL);

    %>
</body>
</html>
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
        
    String warehouseName = request.getParameter("wareName");

    if(warehouseName != null){
        getConnection();
        String sql = "INSERT INTO warehouse(warehouseName) VALUES(?)";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, warehouseName);
        pstmt.executeUpdate();
        closeConnection();

        String redirectURL = "http://localhost/shop/admin.jsp";
        response.sendRedirect(redirectURL);
    }

    %>
</body>
</html>
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
    try{
        getConnection();
        String sql = "UPDATE product SET productImageURL = ? WHERE productId = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);

        //Change these based on desired outcome
        String imageURL = "img/1.jpg";
        String pid = "1004";

        pstmt.setString(1, imageURL);
        pstmt.setString(2, pid);
        pstmt.executeUpdate();

        out.println("<h3>Success</h3>");

    }catch(Exception e){
        out.println(e);
    }finally{
        closeConnection();
    }
    
    %>
</body>
</html>
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
        String price = request.getParameter("price");
        String desc = request.getParameter("desc");

        String pid = request.getParameter("pid");

        out.println(pid);

        if(price.length() > 0){
            String sql = "UPDATE product SET productPrice = ? WHERE productId = ?";
        }

    %>
</body>
</html>
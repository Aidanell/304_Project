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
        String pid = request.getParameter("id");
        out.println("<h3 align='center'>Add what you want to change about product: "+pid+"</h3>");
    %>
        <form method="get" action="UpdateProductData.jsp">
            <table align="center">
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Price:</font></div></td>
                    <td><input type="number" name="price" ></td>
                </tr>
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Description:</font></div></td>
                    <td><input type="text" name="desc""></td>
                </tr>
                <%
            out.println("<tr>");
            out.println("<input type='hidden' name='pid' value="+pid+">");
            out.println("</tr>");
                %>
                <tr>
                    <td align='center' colspan="2"><input type="submit" value="Update Product"></td>
                </tr>
            </table>
        </form>
</body>
</html>
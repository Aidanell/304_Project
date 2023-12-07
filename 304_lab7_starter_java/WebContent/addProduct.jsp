<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add product</title>
</head>
<body>
    <h2 align="center">Add Product</h2>
    <form method="post" action="addProdToDatabase.jsp" enctype='multipart/form-data'>
        <table align="center">
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product Name:</font></div></td>
                <td><input type="text" name="pname"></td>
            </tr>
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Price:</font></div></td>
                <td><input type="number" name="price"></td>
            </tr>
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Description:</font></div></td>
                <td><input type="text" name="desc"></td>
            </tr>
            <tr>
                <td align='center' colspan="2"><input type="submit" value="Add Product"></td>
            </tr>
        </table>

        <%
            String error = request.getParameter("error");
            if(error != null){
                out.println("<h3 align='center'>There was an error in your entries, please try again.</h3>");
            }
        %>
    </form>
</body>
</html>
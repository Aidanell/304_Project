<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    

    <h3 align="center">Enter any information you would like to update</h3>
    <form method="get" action="updateCustDatabase.jsp">
        <table align="center">
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
                <td><input type="text" name="firstName"></td>
            </tr>
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
                <td><input type="text" name="lastName"></td>
            </tr>
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
                <td><input type="email" name="email"></td>
            </tr>
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone Num:</font></div></td>
                <td><input type="number" name="phonenum"></td>
            </tr>
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
                <td><input type="text" name="address"></td>
            </tr>
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
                <td><input type="text" name="city"></td>
            </tr>
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State:</font></div></td>
                <td><input type="text" name="state"></td>
            </tr>
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
                <td><input type="text" name="postalCode"></td>
            </tr>
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
                <td><input type="text" name="country"></td>
            </tr>
            <tr>
                <td><div align="'right"><a href="index.jsp">Go Back</a></div></td>
                <td><div align="'right"><input type="submit" name="signup" value="Update!"></div></td> 
            </tr>
    </table>
    
    </form>

    <%
    String fail = request.getParameter("fail");
    if(fail != null){
        out.println("<h3>Update Failed.</h3>");
    }


    %>
    
</body>
</html>
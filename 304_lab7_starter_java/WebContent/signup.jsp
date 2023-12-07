<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign up page</title>
</head>
<body>
    <h1 align="center">Enter Customer Information</h1>
    <br><hr><br> 


    <form method="get" action="createCustomer.jsp">
        <table align="center">
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
                <td><input type="text" name="username"></td>
            </tr>
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
                <td><input type="password" name="pass"></td>
            </tr>
            <tr>
                <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Confirm Password:</font></div></td>
                <td><input type="password" name="conpass"></td>
            </tr>
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
                <td><div align="'right"><input type="submit" name="signup" value="Sign up!"></div></td> 
            </tr>
    </table>
    
    </form>
    

    <%
    String errorMessage = request.getParameter("errMessage");
    if(errorMessage != null){
        out.println("<h2 align='center'>"+errorMessage+"</h2>");
    }
    %>



</body>
</html>
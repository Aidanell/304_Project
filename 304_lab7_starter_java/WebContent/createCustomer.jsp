<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1>Ayo</h1>

    <%@ include file="jdbc.jsp" %>
    

    <%
    String username = request.getParameter("username");
    String pass = request.getParameter("pass");
    String conpass = request.getParameter("conpass");
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phonenum = request.getParameter("phonenum");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String postalCode = request.getParameter("postalCode");
    String country = request.getParameter("country");


    String redirectURL = "http://localhost/shop/signup.jsp?errMessage=";
    //Check for empty username
    if(username.length() < 1){
        redirectURL = redirectURL + "Please enter a username.";
        redirectURL = redirectURL.replaceAll(" ", "%20");
        response.sendRedirect(redirectURL);
    }

    //Check for empty password
    else if(pass.length() < 1){
        redirectURL = redirectURL + "Please enter a password.";
        redirectURL = redirectURL.replaceAll(" ", "%20");
        response.sendRedirect(redirectURL);
    }

    //Check for wrong password
    else if(!conpass.equals(pass)){
        redirectURL = redirectURL + "Passwords do not match.";
        redirectURL = redirectURL.replaceAll(" ", "%20");
        response.sendRedirect(redirectURL);
    }

    //Check for First Name
    else if(firstName.length() < 1){
        redirectURL = redirectURL + "Please enter your First Name";
        redirectURL = redirectURL.replaceAll(" ", "%20");
        response.sendRedirect(redirectURL);
    }

    //Check for last Name
    else if(lastName.length() < 1){
        redirectURL = redirectURL + "Please enter your Last Name.";
        redirectURL = redirectURL.replaceAll(" ", "%20");
        response.sendRedirect(redirectURL);
    }


    try{

        getConnection();
        con.setAutoCommit(false);
        String SQL = "INSERT INTO customer(userid, password, firstName, lastName) VALUES(?,?,?,?)";
        PreparedStatement pstmt = con.prepareStatement(SQL);
        pstmt.setString(1, username);
        pstmt.setString(2, pass);
        pstmt.setString(3, firstName);
        pstmt.setString(4, lastName);
        pstmt.executeUpdate();



        String sql = "SELECT * FROM customer WHERE userid = ? AND password = ?";
        PreparedStatement getCusId = con.prepareStatement(sql);
        getCusId.setString(1, username);
        getCusId.setString(2, pass);
        ResultSet rst = getCusId.executeQuery();
        rst.next();

        String cid = rst.getString("customerId");


        //Email
        if(email.length() > 0){
            sql = "UPDATE customer SET email = ? WHERE customerId = ?";
            PreparedStatement updateEmail = con.prepareStatement(sql);
            updateEmail.setString(1, email);
            updateEmail.setString(2, cid);
            updateEmail.executeUpdate();
        }

        //Phone number
        if(phonenum.length() > 0){
            sql = "UPDATE customer SET phonenum = ? WHERE customerId = ?";
            PreparedStatement updatephone = con.prepareStatement(sql);
            updatephone.setString(1, phonenum);
            updatephone.setString(2, cid);
            updatephone.executeUpdate();
        }

        //Address
        if(address.length() > 0){
            sql = "UPDATE customer SET address = ? WHERE customerId = ?";
            PreparedStatement updateaddress = con.prepareStatement(sql);
            updateaddress.setString(1, address);
            updateaddress.setString(2, cid);
            updateaddress.executeUpdate();
        }

        //City
        if(city.length() > 0){
            sql = "UPDATE customer SET city = ? WHERE customerId = ?";
            PreparedStatement updatecity = con.prepareStatement(sql);
            updatecity.setString(1, city);
            updatecity.setString(2, cid);
            updatecity.executeUpdate();
        }

        //State
        if(state.length() > 0){
            sql = "UPDATE customer SET state = ? WHERE customerId = ?";
            PreparedStatement updatestate = con.prepareStatement(sql);
            updatestate.setString(1, state);
            updatestate.setString(2, cid);
            updatestate.executeUpdate();
        }

        //postalCode
        if(postalCode.length() > 0){
            sql = "UPDATE customer SET postalCode = ? WHERE customerId = ?";
            PreparedStatement updatepostalCode = con.prepareStatement(sql);
            updatepostalCode.setString(1, postalCode);
            updatepostalCode.setString(2, cid);
            updatepostalCode.executeUpdate();
        }

        //Country
        if(country.length() > 0){
            sql = "UPDATE customer SET country = ? WHERE customerId = ?";
            PreparedStatement updatecountry = con.prepareStatement(sql);
            updatecountry.setString(1, country);
            updatecountry.setString(2, cid);
            updatecountry.executeUpdate();
        }

        con.commit();

        redirectURL = "http://localhost/shop/index.jsp";
        response.sendRedirect(redirectURL);
    }catch(Exception e){
        con.rollback();
    }finally{
        con.setAutoCommit(true);
        closeConnection();
    }
    
    


    %>
</body>
</html>
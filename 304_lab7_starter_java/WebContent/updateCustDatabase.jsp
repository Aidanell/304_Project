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
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phonenum = request.getParameter("phonenum");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String postalCode = request.getParameter("postalCode");
    String country = request.getParameter("country");

    try{

        getConnection();
        con.setAutoCommit(false);


        String userName = (String) session.getAttribute("authenticatedUser");


        String sql = "SELECT * FROM customer WHERE userid = ?";
        PreparedStatement getCusId = con.prepareStatement(sql);
        getCusId.setString(1, userName);
        ResultSet rst = getCusId.executeQuery();
        rst.next();

        String cid = rst.getString("customerId");


        //firstName
        if(firstName.length() > 0){
            sql = "UPDATE customer SET firstName = ? WHERE customerId = ?";
            PreparedStatement updatefirstName = con.prepareStatement(sql);
            updatefirstName.setString(1, firstName);
            updatefirstName.setString(2, cid);
            updatefirstName.executeUpdate();
        }

        //lastName
        if(lastName.length() > 0){
            sql = "UPDATE customer SET lastName = ? WHERE customerId = ?";
            PreparedStatement updatelastName = con.prepareStatement(sql);
            updatelastName.setString(1, lastName);
            updatelastName.setString(2, cid);
            updatelastName.executeUpdate();
        }


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

        String redirectURL = "http://localhost/shop/index.jsp?updated=true";
        response.sendRedirect(redirectURL);
    }catch(Exception e){
        con.rollback();
        out.println(e);
        //String redirectURL = "http://localhost/shop/updateCustomer.jsp?fail=true";
        //response.sendRedirect(redirectURL);

    }finally{
        con.setAutoCommit(true);
        closeConnection();
    }

    %>
</html>
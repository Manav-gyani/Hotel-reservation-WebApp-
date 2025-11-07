<%-- 
    Document   : Login
    Created on : 24 Sept 2025, 11:33:52 am
    Author     : Manav
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="Login.css">
    <script>
        function check()
{
    var usn=document.getElementById("usnm").value;
    var pw=document.getElementById("pw").value;
    if(usn==="")
    {
        alert("Username is Compulsory");
    }
    if(pw==="")
    {
        alert("Password is Compulsory");
    }
}
    </script>
</head>
<body>
    <center>
    <form name="form1" method="post" action="Login.jsp">
        <div class="container">
            <div class="background"></div>
            <div class="content">
                <br>
            <h1>Login Account</h1>
        <table width="500px" align="center">
            <tr>
                <th><br>Username</th>
                <td><br><input type="text" id="usnm" name="user"><br></td>
            </tr>
            <tr>
                <th><br>Password</th>
                <td><br><input type="password" id="pw" name="pass"><br></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><br><input type="submit" class="button" onsubmit="return check();">&nbsp;<input type="reset" class="button"></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><h4>Don't Have an Account?<a href="Registration.jsp">Register Here</a></h4></td>
            </tr>
            
            
        </table>
        </div>
        </div>
    </form>
    </center>
</body>
</html>

<%
String username = request.getParameter("user");
String password = request.getParameter("pass");
if(username!=null&&password!=null){
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/hotel_reservation?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        Connection con = DriverManager.getConnection(url, "root", "");

        String query = "select username,password from registration where username=? and password=?";
        PreparedStatement ps = con.prepareStatement(query);
//        ps.setString(1, username);
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs=ps.executeQuery();
        
        if(rs.next()){
            response.sendRedirect("index.jsp");
//              out.println("<html><head></head><body>"
//              + "Welcome"
//              + "</body></html>");
        }else{
            out.println("<html><head><script>alert('Invalid Login');</script></head><body>"
              + "Login Failed"
              + "</body></html>");
        }
        

} catch (Exception e) {
    e.printStackTrace();
    out.println("<html><head></head><body>"
              + "Welcome"
              + "</body></html>");
}
    }
%>

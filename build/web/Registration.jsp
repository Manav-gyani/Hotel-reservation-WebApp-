<%-- 
    Document   : Registration
    Created on : 24 Sept 2025, 11:31:34 am
    Author     : Manav
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<html>
<head>
    
    <title>Document</title>
    <link rel="stylesheet" href="Registration.css">
    <script>
    function check(){
        var name=document.form1.nm.value;
        var email=document.form1.em.value;
        var phone=document.form1.phn.value;
        var phonelen=phone.length;
        var pw=document.form1.pss.value;
        var pwlen=pw.length;
        var cpw=document.form1.cpss.value;
        
        if(name===""||email==="")
        {
            alert("Name or Email is Required");
        }
        else if(phone==="")
        {
            alert("Phone Number is Required");
        }
        else if(phonelen!=10){
            alert("Enter a Valid Phone Number");
        }
        else if(pw!=cpw)
        {
            alert("Confirm Password do not matched!...");
        }
        else if(pwlen<6)
        {
            alert("The Password Must Contain 6 Characters");
        }
        else{
            //var num_code=document.getElementById("NC").value;
         
            
            
        var a=document.getElementById("a").value;
        /*function check1(){
            var cc=document.getElementById("NC").value;
            document.getElementById("res").value=cc;
        }*/
        /*var cc=document.getElementById("NC").value;
            document.getElementById("res").value=cc;*/
        var g1=document.form1.gender[0].checked;
        var g2=document.form1.gender[1].checked;
//        if(g1==true)
//        {
//            alert("Hello Sir!");
//        }
//        else if(g2==true)
//        {
//            alert("Hello Mam!");
//        }
//        else
//        {
//            alert("Hello");
//        }
        alert(" Your Registration is Successfull");
    
    }
//        return false;
    
    }
   function check1(){
    var cc=document.getElementById("NC").value;
            document.getElementById("res").value=cc;
   }
    //cc.addEventListener("click",check);
    //onsubmit="return check();" onclick="return check1();"
    </script>
</head>
<body>
    <form name="form1" method="post"  action="Registration.jsp">
    <center>
        <div class="container">
            <div class="background"></div>
            <div class="content">
            <h1>Register Account</h1>
        <table width="500px">
            <tr>
                <th>Enter Your Name:</th>
                <td><input type="text" name="nm" placeholder="Enter Username"><br></td>
            </tr>
            <tr>
                <th><br>Enter Your Email:</th>
                <td><br><input type="email" name="em"><br></td>
            </tr>
            <tr>
                <th><br>Select Country</th>
                <td><br><select id="NC" onclick="check1()">
                    <option value="+91">India</option>
                    <option value="+1">Canada</option>
                    <option value="+971">UAE</option>
                    <option value="+44">UK</option>
                    <option value="+61">Australia</option>
                </select></td>
            </tr>
            <tr>
                <th><br>Enter Phone Number:</th>
                <td><br><input type="text" id="res" size="3">&nbsp;&nbsp;<input type="number" name="phn"><br></td>
            </tr>
            <tr>
<!--            <th><br>Select Your Course:</th>-->
            <!--<td><br>-->
<!--            <select id="a">
            <option value="BCA">BCA</option>
            <option value="MCA">MCA</option>
            <option value="BSCIT">BSCIT</option>
            <option value="MSCIT">MSCIT</option>
            </select><br>-->
            <!--</td>-->
            <!--</tr>-->
            <tr>
                <br>
            <th><br>Select Gender:</th>
            <td><br><input type="radio" name="gender" value="Male"><font>Male</font><input type="radio" name="gender" value="Female"><font>
                Female</font>
            <input type="radio" name="gender" value="Other"><font>Other</font><br></td>
            </tr>
    
            <tr>
                <th>Enter Password:</th>
                <td><input type="password" name="pss"></td>
            </tr>
            <tr>
                <th>Confirm Password:</th>
                <td><input type="password" name="cpss"></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><br><input type="submit" name="input" value="Submit" class="button" onclick="check()">
            
                <input type="reset" name="reset" value="Reset" class="button"></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><br><h4>Already Have an Account?<a href="Login.jsp">Login Here</a></h4></td>
            </tr>
        </table>
        </div>
        
        </div>
    </center>
    </form>
</body>
</html>
<%
    String username = request.getParameter("nm");
String email = request.getParameter("em");
String password = request.getParameter("pss");
if(username!=null&&email!=null&&password!=null){
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/hotel_reservation?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        Connection con = DriverManager.getConnection(url, "root", "");

        String query = "INSERT INTO registration (username,email,password) VALUES (?,?,?)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, username);
        ps.setString(2, email);
        ps.setString(3, password);

        int rows = ps.executeUpdate();
        if (rows > 0) {
        response.sendRedirect("Login.jsp");
        }

        ps.close();
        con.close();

} catch (Exception e) {
    e.printStackTrace();
}
    }
%>

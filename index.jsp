<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 
<!DOCTYPE html>
<html>
    <head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="newcss1.css">
    </head>
<body>
    <h2 style="text-align:center">Image Gallery</h2>
    <%
try {
String connectionURL = "jdbc:mysql://localhost:3306/jspdb";
Connection connection = null;
Statement statement = null;
ResultSet rs = null;
ResultSet rs1 = null;
Class.forName("com.mysql.jdbc.Driver").newInstance();
connection = DriverManager.getConnection(connectionURL, "root", "root");
statement = connection.createStatement();
String QueryString = "SELECT * from imagetable";
rs = statement.executeQuery(QueryString);
%>




<div class="row">
    <%
   
while (rs.next()) {
%>
  <div class="column">
      <%
            Blob image=rs.getBlob("image");
            byte[] image_array=image.getBytes(1,(int)image.length());
            byte [] x64_image= Base64.getEncoder().encode(image_array);
            String xstring=new String(x64_image,"UTF-8");
         %>
    <img src="data: image/png;base64,<%=xstring %>" style="width:100%;height: 100%" onclick="openModal();currentSlide(1)" class="hover-shadow cursor">
  </div>
  <%  } %>
<%
rs.close();
statement.close();
connection.close();
} catch (Exception ex) {
%>
<%
out.println("Unable to connect to database.");
}
%>
  
</div>
  </body>
</html>


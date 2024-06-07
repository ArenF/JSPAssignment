<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.*" %>
<%
    Class.forName("org.sqlite.JDBC");

    try {
        Connection conn = DriverManager.getConnection("jdbc:sqlite:identifier.sqlite");
        Statement statement = conn.createStatement();

        ResultSet rst = statement.executeQuery("");

        String sql = "";
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>
</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: hjh04
  Date: 2024-06-07
  Time: AM 11:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.File" %>

<html>
<head>
    <title>oracle jdbc</title>
</head>
<body>
<%
    Class.forName("org.sqlite.JDBC");

    Connection conn = DriverManager.getConnection("jdbc:sqlite:identifier.sqlite");
    Statement stat = conn.createStatement();

    ResultSet rs = stat.executeQuery("select * from member;");
    while (rs.next()) {
        out.println("name = " + rs.getString("name"));
        out.println("<BR>");
    }
    rs.close();
    conn.close();
%>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.*" %>
<%
    Class.forName("org.sqlite.JDBC");

    try {
        Connection conn = DriverManager.getConnection("jdbc:sqlite:identifier.sqlite");
        Statement statement = conn.createStatement();

        String createMemberSql = "CREATE TABLE IF NOT EXISTS member(" +
                "    ID INTEGER primary key autoincrement, " +
                "    NAME varchar(10) not null," +
                "    EMAIL varchar(30) not null," +
                "    PASSWORD varchar(15) not null" +
                ")";
        statement.executeUpdate(createMemberSql);
        String createToDoSql = "CREATE TABLE IF NOT EXISTS todo(" +
                "    NAME VARCHAR(20) not null," +
                "    STATE VARCHAR(8) not null," +
                "    OWNER_ID INTEGER," +
                "    CONSTRAINT OWNER_IDfk FOREIGN KEY(OWNER_ID)" +
                "                 REFERENCES member(ID)" +
                ")";
        statement.executeUpdate(createToDoSql);
        ResultSet rst = statement.executeQuery("SELECT count(ID) as 'length' from member;");
        int length = rst.getInt("length");
        out.println("<p>length : " + length + "</p>");

        if (length == 0) {
//            값이 없을 때 실행
//            TODO 나중에 발표할 때는 없애기
            String insertMemberSql = "INSERT INTO member" +
                    "(NAME, EMAIL, PASSWORD)" +
                    "VALUES('rise', 'and@gmail.com', 'shine!');";
            statement.executeUpdate(insertMemberSql);

            String insertToDoSql = "INSERT INTO todo" +
                    "(NAME, STATE, OWNER_ID)" +
                    "VALUES ('할 일', 'check', 1);";
            statement.executeUpdate(insertToDoSql);
        }

        rst.close();
        statement.close();
        conn.close();
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
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.*" %>
<%

    try {
        Class.forName("org.sqlite.JDBC");
        Connection conn = DriverManager.getConnection("jdbc:sqlite:identifier.sqlite");
        Statement statement = conn.createStatement();

        String createMemberSql = "CREATE TABLE IF NOT EXISTS member(\n" +
                "    ID INTEGER primary key autoincrement,\n" +
                "    NAME varchar(10) not null,\n" +
                "    EMAIL varchar(30) not null,\n" +
                "    PASSWORD varchar(15) not null\n" +
                ")";
        statement.executeUpdate(createMemberSql);
        String createToDoSql = "CREATE TABLE IF NOT EXISTS todo (\n" +
                "    ID INTEGER NOT NULL,\n" +
                "    NAME TEXT,\n" +
                "    STATE TEXT,\n" +
                "    OWNER_ID INTEGER NOT NULL,\n" +
                "    DEADLINE TEXT,\n" +
                "    PRIMARY KEY (\"ID\" AUTOINCREMENT),\n" +
                "    CONSTRAINT OWNER_IDfk FOREIGN KEY (OWNER_ID)\n" +
                "                  REFERENCES member(ID)\n" +
                ")";
        statement.executeUpdate(createToDoSql);

        statement.close();
        conn.close();

        response.sendRedirect("main.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
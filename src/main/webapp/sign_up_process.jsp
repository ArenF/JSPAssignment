<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("org.sqlite.JDBC");
        String dbFilePath = "jdbc:sqlite:C:/intelliJ/JSPAssignment-develop/identifier.sqlite";
        conn = DriverManager.getConnection(dbFilePath);

        String sql = "INSERT INTO member (NAME, EMAIL, PASSWORD) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, password);
        pstmt.executeUpdate();

        response.sendRedirect("login.jsp");
    } catch (Exception e) {
        e.printStackTrace(response.getWriter());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(response.getWriter()); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(response.getWriter()); }
    }
%>
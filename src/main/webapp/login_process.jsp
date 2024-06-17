<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.sqlite.JDBC");
        String dbFilePath = "jdbc:sqlite:C:/intelliJ/JSPAssignment-develop/identifier.sqlite";
        conn = DriverManager.getConnection(dbFilePath);

        String sql = "SELECT ID FROM member WHERE EMAIL = ? AND PASSWORD = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            int userId = rs.getInt("ID");
            session.setAttribute("memberId", userId);
            response.sendRedirect("todo.jsp");
        } else {
            response.getWriter().println("Login failed: Incorrect email or password.");
        }
    } catch (Exception e) {
        e.printStackTrace(response.getWriter());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(response.getWriter()); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(response.getWriter()); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(response.getWriter()); }
    }
%>

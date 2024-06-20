<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    JSONObject jsonResponse = new JSONObject();

    try {
        Class.forName("org.sqlite.JDBC");

        String dbURL = "jdbc:sqlite:C:/intelliJ/JSPAssignment-develop/identifier.sqlite";
        conn = DriverManager.getConnection(dbURL);

        String sql = "SELECT ID FROM member WHERE EMAIL = ? AND PASSWORD = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            int memberId = rs.getInt("ID");

            String deleteTasksSql = "DELETE FROM todo WHERE OWNER_ID = ?";
            pstmt = conn.prepareStatement(deleteTasksSql);
            pstmt.setInt(1, memberId);
            pstmt.executeUpdate();

            String deleteMemberSql = "DELETE FROM member WHERE ID = ?";
            pstmt = conn.prepareStatement(deleteMemberSql);
            pstmt.setInt(1, memberId);
            pstmt.executeUpdate();

            // 세션 무효화
            HttpSession currentSession = request.getSession(false); // 변수명을 변경하여 중복을 피함
            if (currentSession != null) {
                currentSession.invalidate();
            }

            jsonResponse.put("status", "success");
        } else {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "일치하는 정보가 없습니다.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        jsonResponse.put("status", "error");
        jsonResponse.put("message", "Error: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    out.print(jsonResponse.toString());
%>

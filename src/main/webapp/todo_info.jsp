<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>

<%
    Integer memberId = (Integer) session.getAttribute("memberId");
    if (memberId == null) {
        System.err.println("memberId is null. Redirecting to login page.");
        response.sendRedirect("login.jsp");
        return;
    }

    BufferedReader reader = request.getReader();
    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = reader.readLine()) != null) {
        sb.append(line);
    }
    String json = sb.toString();
    System.out.println("Received JSON data: " + json);

    JSONParser parser = new JSONParser();
    JSONArray todoArray = null;
    try {
        todoArray = (JSONArray) parser.parse(json);
    } catch (ParseException e) {
        e.printStackTrace();
    }

    if (todoArray != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("org.sqlite.JDBC");
            String dbFilePath = "jdbc:sqlite:C:/intelliJ/JSPAssignment-develop/identifier.sqlite";
            conn = DriverManager.getConnection(dbFilePath);

            // 트랜잭션 시작
            conn.setAutoCommit(false);

            // 기존 할 일 목록 삭제
            String deleteSql = "DELETE FROM todo WHERE OWNER_ID = ?";
            pstmt = conn.prepareStatement(deleteSql);
            pstmt.setInt(1, memberId);
            pstmt.executeUpdate();
            pstmt.close();

            // 새 할 일 목록 삽입
            String sql = "INSERT INTO todo (NAME, STATE, DEADLINE, OWNER_ID) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);

            for (Object obj : todoArray) {
                JSONObject todoObject = (JSONObject) obj;
                String todoItem = (String) todoObject.get("todoItem");
                String state = (String) todoObject.get("state");
                String deadline = (String) todoObject.get("deadline");
                System.out.println("Inserting item: " + todoItem + ", state: " + state + ", deadline: " + deadline);

                pstmt.setString(1, todoItem);
                pstmt.setString(2, state);
                pstmt.setString(3, deadline);
                pstmt.setInt(4, memberId);
                pstmt.addBatch();
            }
            pstmt.executeBatch();

            // 트랜잭션 커밋
            conn.commit();
            System.out.println("Data inserted and committed successfully.");
        } catch (Exception e) {
            // 트랜잭션 롤백
            if (conn != null) {
                try {
                    conn.rollback();
                    System.err.println("Transaction rolled back due to error.");
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>

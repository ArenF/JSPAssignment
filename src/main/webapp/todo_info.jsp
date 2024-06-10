<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONValue" %>

<%
    // 세션에서 사용자 ID 가져오기
    Integer memberId = (Integer) session.getAttribute("memberId");
    if (memberId != null) {
        // 클라이언트로부터 받은 JSON 형식의 데이터를 읽기 위한 BufferedReader 생성
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        String json = sb.toString();

        // 받은 JSON 데이터를 파싱하여 todo 데이터 추출
        JSONArray todoArray = (JSONArray) JSONValue.parse(json);

        // SQLite 데이터베이스 연결 설정
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("org.sqlite.JDBC");
            String dbFilePath = "C:/intelliJ/JSPAssignment-develop/identifier.sqlite";
            conn = DriverManager.getConnection("jdbc:sqlite:" + dbFilePath);

            // 기존 TODO 항목 삭제 (옵션: 사용자의 기존 TODO 항목을 모두 삭제하고 새로 추가하는 방식)
            String deleteSql = "DELETE FROM todo WHERE OWNER_ID = ?";
            pstmt = conn.prepareStatement(deleteSql);
            pstmt.setInt(1, memberId);
            pstmt.executeUpdate();
            pstmt.close();

            // SQL 쿼리 작성
            String sql = "INSERT INTO todo (NAME, STATE, DEADLINE, OWNER_ID) VALUES (?, ?, ?, ?)";

            // PreparedStatement 객체 생성 및 데이터베이스에 삽입
            pstmt = conn.prepareStatement(sql);
            for (int i = 0; i < todoArray.size(); i++) {
                JSONObject todoObject = (JSONObject) todoArray.get(i);
                pstmt.setString(1, (String) todoObject.get("todoItem"));
                pstmt.setString(2, (String) todoObject.get("state"));
                pstmt.setString(3, (String) todoObject.get("deadline"));
                pstmt.setInt(4, memberId);
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 연결 및 리소스 해제
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToDo List</title>
    <link rel="stylesheet" href="style.css">
    <script>
        // 창이 닫힐 때 데이터를 서버에 전송하는 함수
        window.onbeforeunload = function() {
            saveDataToServer();
        };

        function saveDataToServer() {
            const todoItems = document.querySelectorAll('.todoitem');
            const todoData = [];
            todoItems.forEach(todo => {
                const checkbox = todo.querySelector('.todo_checkbox');
                const todoInput = todo.querySelector('.todo_input');
                const deadlineInput = todo.querySelector('.deadline_input');
                if (todoInput.value) {
                    todoData.push({
                        todoItem: todoInput.value,
                        deadline: deadlineInput.value,
                        state: checkbox.checked ? "DONE" : "PENDING"
                    });
                }
            });

            // AJAX 요청을 사용하여 서버로 데이터를 전송
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'todo_info.jsp', true);
            xhr.setRequestHeader('Content-Type', 'application/json');
            xhr.send(JSON.stringify(todoData));
        }

        function addTodo() {
            const todoItems = document.querySelector('.todoitems');
            const newTodo = document.createElement('div');
            newTodo.classList.add('todoitem');
            newTodo.innerHTML = `
                <input type="checkbox" class="todo_checkbox">
                <input type="text" class="todo_input" placeholder="할 일을 입력하세요">
                <input type="text" class="deadline_input" placeholder="날짜/시간을 입력하세요">
            `;
            todoItems.appendChild(newTodo);
        }

        function deleteTodo() {
            const todoItems = document.querySelector('.todoitems');
            const todos = todoItems.querySelectorAll('.todoitem');
            todos.forEach(todo => {
                const checkbox = todo.querySelector('.todo_checkbox');
                if (checkbox.checked) {
                    todoItems.removeChild(todo);
                }
            });
        }
    </script>
</head>
<body>
<div class="all">
    <div class="header">
        <div class="header_button">
            Github
        </div>
        <div class="header_item">
            <div>
                <a href="main.jsp" class="header_button">main</a>
            </div>
            <div>
                <a href="todo.jsp" class="header_button">todo</a>
            </div>
            <a href="login.html" class="header_button_login">login/sign up</a>
        </div>
    </div>

    <div class="content_todo">
        <div class="todoform">
            <div>
                <p class="login">TODO LIST</p>
            </div>
            <div class="todobutton_box">
                <button type="button" class="todobutton_add" onclick="addTodo()">add</button>
                <button type="button" class="todobutton_del" onclick="deleteTodo()">del</button>
            </div>
            <div class="todoitems">
                <%
                    // 세션에서 사용자 ID 가져오기
                    Integer memberId = (Integer) session.getAttribute("memberId");
                    if (memberId != null) {
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("org.sqlite.JDBC");
                            String dbFilePath = "C:/intelliJ/JSPAssignment-develop/identifier.sqlite";
                            conn = DriverManager.getConnection("jdbc:sqlite:" + dbFilePath);

                            String sql = "SELECT NAME, STATE, DEADLINE FROM todo WHERE OWNER_ID = ?";
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setInt(1, memberId);
                            rs = pstmt.executeQuery();

                            while (rs.next()) {
                                String name = rs.getString("NAME");
                                String state = rs.getString("STATE");
                                String deadline = rs.getString("DEADLINE");
                                boolean isChecked = "DONE".equals(state);

                %>
                <div class="todoitem">
                    <input type="checkbox" class="todo_checkbox" <%= isChecked ? "checked" : "" %>>
                    <input type="text" class="todo_input" value="<%= name %>">
                    <input type="text" class="deadline_input" value="<%= deadline %>">
                </div>
                <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    }
                %>
            </div>
        </div>
    </div>
</div>
</body>
</html>
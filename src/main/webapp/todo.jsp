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
        function validateDeadline(input) {
            const regex = /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$/;
            if (!regex.test(input.value)) {
                alert("날짜/시간 형식은 YYYY-MM-DD hh:mm이어야 합니다.");
                input.value = "";
            }
        }

        function handleInput(event) {
            const input = event.target;
            const value = input.value;
            const regex = /^[0-9-:\s]*$/;
            if (!regex.test(value)) {
                alert("날짜/시간 형식은 YYYY-MM-DD hh:mm이어야 합니다.");
                input.value = "";
                return;
            }

            input.value = formatDeadlineInput(value);
        }

        function formatDeadlineInput(value) {
            const cleanValue = value.replace(/[^\d]/g, "");
            let formattedValue = "";

            if (cleanValue.length >= 4) {
                formattedValue += cleanValue.substring(0, 4) + "-";
            } else {
                formattedValue += cleanValue;
            }
            if (cleanValue.length >= 6) {
                formattedValue += cleanValue.substring(4, 6) + "-";
            } else if (cleanValue.length > 4) {
                formattedValue += cleanValue.substring(4);
            }
            if (cleanValue.length >= 8) {
                formattedValue += cleanValue.substring(6, 8) + " ";
            } else if (cleanValue.length > 6) {
                formattedValue += cleanValue.substring(6);
            }
            if (cleanValue.length >= 10) {
                formattedValue += cleanValue.substring(8, 10) + ":";
            } else if (cleanValue.length > 8) {
                formattedValue += cleanValue.substring(8);
            }
            if (cleanValue.length >= 12) {
                formattedValue += cleanValue.substring(10, 12);
            } else if (cleanValue.length > 10) {
                formattedValue += cleanValue.substring(10);
            }

            return formattedValue;
        }

        function addTodo() {
            const todoItems = document.querySelector('.todoitems');
            const newTodo = document.createElement('div');
            newTodo.classList.add('todoitem');
            newTodo.innerHTML = `
                <input type="checkbox" class="todo_checkbox">
                <input type="text" class="todo_input" placeholder="할 일을 입력하세요">
                <input type="text" class="deadline_input" placeholder="YYYY-MM-DD hh:mm" oninput="handleInput(event)">
            `;
            todoItems.appendChild(newTodo);
            saveDataToServer(); // 서버에 데이터를 저장
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
            saveDataToServer(); // 서버에 데이터를 저장
        }

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

            const jsonData = JSON.stringify(todoData);
            navigator.sendBeacon('todo_info.jsp', jsonData);
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
                <%-- Load existing todo items from the database --%>
                <%
                    Integer memberId = (Integer) session.getAttribute("memberId");
                    if (memberId != null) {
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("org.sqlite.JDBC");
                            String dbFilePath = "D:\\IntelliJ_workspace\\JSP\\JSPAssignment\\identifier.sqlite";
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
                    <input type="text" class="deadline_input" value="<%= deadline %>" oninput="handleInput(event)">
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
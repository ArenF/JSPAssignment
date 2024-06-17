<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    Integer memberId = (Integer) session.getAttribute("memberId");
    if (memberId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

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
                alert("숫자만 입력 가능합니다.");
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

        function saveDataToServer() {
            const todoItems = document.querySelectorAll('.todoitem');
            const todoData = [];
            todoItems.forEach(todo => {
                const todoInput = todo.querySelector('.todo_input');
                const checkbox = todo.querySelector('.todo_checkbox');
                const deadlineInput = todo.querySelector('.deadline_input');

                if (todoInput.value.trim()) {
                    const state = checkbox.checked ? "DONE" : "PENDING";
                    const deadline = deadlineInput.value.trim();

                    todoData.push({
                        todoItem: todoInput.value.trim(),
                        state: state,
                        deadline: deadline
                    });
                }
            });

            const jsonData = JSON.stringify(todoData);
            console.log("Sending data to server:", jsonData);

            const xhr = new XMLHttpRequest();
            xhr.open("POST", "todo_info.jsp", true);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    console.log("Data saved successfully");
                } else if (xhr.readyState === 4) {
                    console.error("Error saving data:", xhr.responseText);
                }
            };
            xhr.send(jsonData);
        }

        window.addEventListener('beforeunload', saveDataToServer);

        function addTodo() {
            const todoItems = document.querySelector('.todoitems');
            const newTodo = document.createElement('div');
            newTodo.classList.add('todoitem');
            newTodo.innerHTML = `
                <input type="checkbox" class="todo_checkbox">
                <input type="text" class="todo_input" placeholder="할 일을 입력하세요">
                <input type="text" class="deadline_input" placeholder="YYYY-MM-DD hh:mm" oninput="handleInput(event)" onblur="validateDeadline(this)">
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
            saveDataToServer();
        }
    </script>
</head>
<body>
<div class="all">
    <div class="header">
        <div class="header_button">
            <a href="https://github.com">Github</a>
        </div>
        <div class="header_item">
            <a href="main.jsp" class="header_button">main</a>
            <a href="todo.jsp" class="header_button">todo</a>
            <a href="login.jsp" class="header_button_login">login/sign up</a>
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
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("org.sqlite.JDBC");
                        String dbFilePath = "jdbc:sqlite:C:/intelliJ/JSPAssignment-develop/identifier.sqlite";
                        conn = DriverManager.getConnection(dbFilePath);

                        String sql = "SELECT NAME, STATE, DEADLINE FROM todo WHERE OWNER_ID = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, memberId);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            String name = rs.getString("NAME");
                            String state = rs.getString("STATE");
                            boolean isChecked = state.startsWith("DONE");
                            String deadline = rs.getString("DEADLINE");
                %>
                <div class="todoitem">
                    <input type="checkbox" class="todo_checkbox" <%= isChecked ? "checked" : "" %>>
                    <input type="text" class="todo_input" value="<%= name %>">
                    <input type="text" class="deadline_input" value="<%= deadline %>" oninput="handleInput(event)" onblur="validateDeadline(this)">
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
                %>
            </div>
        </div>
    </div>
</div>
</body>
</html>

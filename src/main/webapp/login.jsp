<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    Integer memberId = (session != null) ? (Integer) session.getAttribute("memberId") : null;
    if (memberId != null) {
        response.sendRedirect("todo.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="all">
    <div class="header">
        <div class="header_button">
            <a href="https://github.com">Github</a>
        </div>
        <div class="header_item">
            <button type="button" class="header_button" onclick="location.href='main.jsp'">main</button>
            <button type="button" class="header_button" onclick="location.href='todo.jsp'">todo</button>
            <button type="button" class="header_button_login" onclick="location.href='login.jsp'">login/sign up</button>
        </div>
    </div>

    <div class="content_main">
        <div class="loginform">
            <p class="login">LOGIN</p>
            <form action="login_process.jsp" method="post">
                <input type="email" name="email" placeholder="Email" required>
                <input type="password" name="password" placeholder="Password" required>
                <p class="sign_up_a" onclick="location.href='sign_up.jsp'">Sign Up</p>
                <button type="submit" class="submit_button">Submit</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>

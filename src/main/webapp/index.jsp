<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 폼</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .login-form h2 {
            margin-bottom: 20px;
        }
        .login-form input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .login-form button {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }
        .login-form button:hover {
            background-color: #0056b3;
        }
        .signup-link {
            display: block;
            margin-top: 10px;
            text-align: center;
        }
        .error {
            color: red;
            margin-bottom: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="login-form">
    <h2>로그인</h2>
    <% if (request.getParameter("error") != null) { %>
    <div class="error">이메일 또는 비밀번호가 잘못되었습니다.</div>
    <% } %>
    <form action="login" method="post">
        <input type="email" name="email" placeholder="이메일" required>
        <input type="password" name="password" placeholder="비밀번호" required>
        <button type="submit">로그인</button>
    </form>
    <a class="signup-link" href="signup.jsp">회원가입</a>
</div>
</body>
</html>

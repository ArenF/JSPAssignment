<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인화면</title>
    <link rel="stylesheet"; href="style.css";>
</head>
<body>
    <div class="all">
        <div class="header">
            <div class="header_button">
                Github
            </div>
            <div class="header_item">
                <div>
                    <button type="button" class="header_button">
                        main
                    </button>
                </div>
                <div>
                    <button type="button" class="header_button">
                        todo
                    </button>
                </div>
                <button type="button" class="header_button_login">
                    login/sign up
                </button>
            </div>
        </div>
    
        <div class="content_main">
            <div class="loginform">
                <p class="login">LOGIN</p>
                <input type="email" placeholder="email">
                <input type="password" placeholder="password">
                <p class="sign_up_a">회원가입</p>
                <button class="submit_button">
                    submit
                </button>
            </div>
        </div>
    </div>
</body>
</html>
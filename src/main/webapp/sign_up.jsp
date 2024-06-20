<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
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
            <p class="login">SIGN UP</p>
            <form action="sign_up_process.jsp" method="post">
                <input type="text" name="name" placeholder="Name" required>
                <input type="email" name="email" placeholder="Email" required>
                <input type="password" name="password" placeholder="Password" required>
                <button type="submit" class="submit_button">Submit</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>

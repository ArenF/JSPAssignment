<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인화면</title>
    <link rel="stylesheet" ; href="style.css" ;>
    <script>
        function shortcut() {
            window.location.href = "todo.jsp";
        }

    </script>
</head>
<body>
    <div class="all">
        <div class="header">
            <div class="header_button">
                <a href="https://github.com">
                    Github
                </a>
            </div>
            <div class="header_item">
                <div>
                    <a href="main.jsp">
                        <button type="button" class="header_button">
                            main
                        </button>
                    </a>
                </div>
                <div>
                    <a href="todo.jsp">
                        <button type="button" class="header_button">
                            todo
                        </button>
                    </a>
                </div>
                <a href="login.jsp">
                    <button type="button" class="header_button_login">
                        login/sign up
                    </button>
                </a>
            </div>
        </div>

        <div class="content_main">
            <button type="button" id="goto_button" onclick="shortcut()" class="header_button" >
                바로가기
            </button>
        </div>
    </div>

</body>
</html>
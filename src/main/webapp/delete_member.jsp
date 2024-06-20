<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원탈퇴</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            <p class="login">RESIGN</p>
            <form id="deleteMemberForm">
                <input type="email" id="email" name="email" placeholder="Email" required>
                <input type="password" id="password" name="password" placeholder="Password" required>
                <button type="submit" class="submit_button">Delete</button>
            </form>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $('#deleteMemberForm').on('submit', function(event) {
            event.preventDefault();

            $.ajax({
                url: 'delete_member_process.jsp', // URL이 올바른지 확인
                type: 'POST',
                dataType: 'json',
                data: {
                    email: $('#email').val(),
                    password: $('#password').val()
                },
                success: function(response) {
                    if (response.status === 'success') {
                        alert('회원 탈퇴가 성공적으로 처리되었습니다.');
                        window.location.href = 'login.jsp';
                    } else {
                        alert(response.message);
                        $('#email').val('');
                        $('#password').val('');
                    }
                },
                error: function(xhr, status, error) {
                    alert('요청을 처리하는 동안 오류가 발생했습니다. 상태: ' + status + ', 오류: ' + error);
                    console.error('Error details:', xhr.responseText);
                }
            });
        });
    });
</script>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: hjh04
  Date: 2024-06-16
  Time: PM 5:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        session.setAttribute("memberId", 1);
        out.println("<h2>당신의 세션은 " + session.getAttribute("memberId") + "입니다.</h2>");
    %>
</body>
</html>

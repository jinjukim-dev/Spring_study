<%--
  Created by IntelliJ IDEA.
  User: dntdm
  Date: 2023-01-03
  Time: 오후 7:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'LoginOut'}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Board_Project</title>
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/top.jsp"/>
<div style="text-align:center">
    <h1>Welecome To HOMEPAGE</h1>
</div>
</body>
</html>

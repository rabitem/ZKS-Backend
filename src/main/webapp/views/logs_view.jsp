<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import = "java.sql.*" %>

<div class="cMainContentManageUsers" id = "cMainContentSubFolder">
    <div class="cTableContent cMainBox">
        <h2>Logs</h2>
        <table>
            <tr>
                <th>User</th>
                <th>Location</th>
                <th>Date</th>
                <th>Time</th>
                <th>Action</th>
            </tr>
            <!-- Generated JSP Content -->
            <jsp:useBean id="logs" scope="request" type="java.util.List"/>
            <c:forEach items="${logs}" var="log">
                <tr>
                    <td>${log.user.name}</td>
                    <td>${log.location.label}</td>
                    <fmt:parseDate pattern="yyyy-mm-dd" value="${fn:split(log.timestamp, ' ')[0]}" var="parsedDate" />
                    <td><fmt:formatDate value="${parsedDate}" pattern="DD.MM.YYYY" /></td>
                    <fmt:parseDate pattern="HH:mm:ss" value="${fn:split(log.timestamp, ' ')[1]}" var="parsedTime" />
                    <td><fmt:formatDate value="${parsedTime}" pattern="HH:mm:ss" /></td>
                    <c:choose>
                        <c:when test="${log.wasSuccessful}">
                            <td class="colorGreenText">${log.status}</td>
                        </c:when>
                        <c:otherwise>
                            <td class="colorRedText">${log.status}</td>
                        </c:otherwise>
                    </c:choose>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
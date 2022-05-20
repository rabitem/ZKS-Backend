<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import = "java.sql.*" %>

<div class="cMainContentManageUsers" id = "cMainContentSubFolder">
    <div class="cTableContent cMainBox">
        <div id = "cHeaderIcon">
            <h2>Logs</h2>
            <svg id = "refreshLogs" width="2.5rem" height="2.5rem" viewBox="0 0 49 43" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M46.9402 3.83333V17.0833M46.9402 17.0833H34.7527M46.9402 17.0833L37.5152 7.45499C35.3321 5.0804 32.6313 3.34574 29.6648 2.41287C26.6983 1.48 23.5628 1.37932 20.5508 2.12023C17.5388 2.86114 14.7486 4.41949 12.4404 6.64988C10.1322 8.88026 8.38136 11.71 7.35117 14.875M2.25281 39.1667V25.9167M2.25281 25.9167H14.4403M2.25281 25.9167L11.6777 35.545C13.8608 37.9196 16.5616 39.6543 19.5281 40.5871C22.4946 41.52 25.6301 41.6207 28.6421 40.8798C31.6541 40.1388 34.4443 38.5805 36.7525 36.3501C39.0607 34.1197 40.8115 31.29 41.8417 28.125" stroke="#0a0c16" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>	
            </svg>
        </div>
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

<script>
    document.getElementById("refreshLogs").addEventListener("click", () => {
        console.log("refresh logs");
        $.fn.loadLogsViews();
    });
</script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import = "java.sql.*" %>

<div class="cMainContentManageUsers" id = "cMainContentSubFolder">
    <div class="cTableContent cMainBox">
        <h2>Temperature Data</h2>
        <table>
            <tr>
                <th>Temperature</th>
                <th>Timestamp</th>
            </tr>
            <!-- Generated JSP Content -->
            <jsp:useBean id="temperatures" scope="request" type="java.util.List"/>
            <c:forEach items="${temperatures}" var="temperature">
                <tr class = "trCurData" id = "trData${temperature.id}" data-valueID = ${temperature.id}>
                    <td>${temperature.temperature}</td>
                    <td>${temperature.timestamp}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
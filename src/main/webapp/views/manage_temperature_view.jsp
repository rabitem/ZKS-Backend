<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import = "java.sql.*" %>

<div class="cMainContentManageUsers" id = "cMainContentSubFolder">
    <div class="cTableContent cMainBox">
        <h2>Temperature Data</h2>
        <table>
            <tr>
                <th>User Name</th>
                <th>User Role</th>
                <th>User RFID</th>
                <th>Current Location</th>
            </tr>
            <!-- Generated JSP Content -->
            <jsp:useBean id="location_temperature" scope="request" type="java.util.List"/>
            <c:forEach items="${location_temperature}" var="temperature">
                <tr class = "trCurData" id = "trData${temperature.id}" data-valueID = ${temperature.id}>
                    <td>${temperature.temperature}</td>
                    <td>${temperature.timestamp}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
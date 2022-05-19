<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import = "java.sql.*" %>

<div class="cMainContentManageUsers" id = "cMainContentSubFolder">
    <div class="cAdjustments cMainBox">
        <h2>Manage Location</h2>
        <div class="cOptions">
            <p>Add Location</p>
            <svg class = "svgAdd" id = "svgAddSignLocation" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M10 6V14M6 10H14M3 1H17C18.1046 1 19 1.89543 19 3V17C19 18.1046 18.1046 19 17 19H3C1.89543 19 1 18.1046 1 17V3C1 1.89543 1.89543 1 3 1Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <p>Remove Location</p>
            <svg class = "svgRemove" id = "svgRemoveSignLocation" width="21" height="21" viewBox="0 0 21 21" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M7.50562 7.69464L13.5056 13.6946M13.5056 7.69464L7.50562 13.6946M3.50562 1.69464H17.5056C18.6102 1.69464 19.5056 2.59007 19.5056 3.69464V17.6946C19.5056 18.7992 18.6102 19.6946 17.5056 19.6946H3.50562C2.40105 19.6946 1.50562 18.7992 1.50562 17.6946V3.69464C1.50562 2.59007 2.40105 1.69464 3.50562 1.69464Z" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>                                
        </div>        
    </div>
    <div class="cTableContent cMainBox">
        <h2>Location Data</h2>
        <table>
            <tr>
                <th>Location Name</th>
                <th>Location MAC-Adress</th>
            </tr>
            <!-- Generated JSP Content -->
            <jsp:useBean id="locations" scope="request" type="java.util.List"/>
            <c:forEach items="${locations}" var="location">
                <tr class = "trCurData" id = "trData${location.label}" data-valueID = "${location.id}" data-name="${location.label}">
                    <td>${location.label}</td>
                    <td>${location.macAddress}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
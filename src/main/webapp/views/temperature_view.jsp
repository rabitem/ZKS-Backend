<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import = "java.sql.*" %>
<jsp:useBean id="temperatures" scope="request" type="java.util.List"/>
<script>
const ctx = document.getElementById('myChart').getContext('2d');
const myChart = new Chart(ctx, {
    type: 'line',
    data: {
         datasets: [{data: [
             <c:forEach items="${temperatures}" var="temperature">
             { x:'${temperature.timestamp}', y:'${temperature.temperature}' },
             </c:forEach>]
          }]
    }
});
</script>



<div class="cMainContentManageUsers" id = "cMainContentSubFolder">
    <div class="cTableContent cMainBox">
        <h2>Temperature Data</h2>
        <table>
            <tr>
                <th>Temperature</th>
                <th>Timestamp</th>
            </tr>
            <!-- Generated JSP Content -->
            <div style="width:400px;border:1px">
            <canvas id="myChart" width="400" height="400"></canvas>
            </div>
            <%--jsp:useBean id="temperatures" scope="request" type="java.util.List"/--%>
            <c:forEach items="${temperatures}" var="temperature">
                <tr class = "trCurData" id = "trData${temperature.id}" data-valueID = ${temperature.id}>
                    <td>${temperature.temperature}</td>
                    <td>${temperature.timestamp}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
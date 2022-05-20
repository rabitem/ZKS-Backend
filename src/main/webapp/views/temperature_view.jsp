<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="temperatures" scope="request" type="java.util.List"/>
<jsp:useBean id="locations" scope="request" type="java.util.List"/>

<script>
    ctx = document.getElementById('myChart').getContext('2d');
    myChart = new Chart(ctx, {
        type: 'line',
        data: {

            datasets: [
                <c:forEach items="${locations}" var="location">
                {
                    data: [
                        <c:forEach items="${location.locationTemperatures}" var="temperature">
                        <fmt:parseDate pattern="yyyy-MM-dd HH:mm:ss.S" value="${temperature.timestamp}" var="parsedTimestamp" />
                        <fmt:formatDate value="${parsedTimestamp}" pattern="HH:mm:ss dd.MM.yyyy" var="formatedTimestamp" />
                        {
                            x: '${formatedTimestamp}',
                            y: ${temperature.temperature},
                            backgroundColor: 'rgba(0, 0, 0, 0)',
                            borderColor: 'rgba(0, 0, 0, 0)',
                        }, </c:forEach>
                    ],
                    backgroundColor: '${location.color}',
                    borderColor: 'rgba(0,0,0,1)',
                    borderWidth: 1,
                    showLine: false,
                    pointRadius: 5,
                    pointHoverRadius: 7,
                    boxShadow: '0 0 100px 60px #f0f',
                    label: '${location.label}',
                },
                </c:forEach>
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                x: {display: true, title: {display: true, text: 'Timestamp'}},
                y: {
                    display: true,
                    title: {display: true, text: 'Temperature'},
                    suggestedMin: 20,
                    suggestedMax: 80,
                    ticks: {min: 20, max: 80, stepSize: 5}
                }
            },

        }
    });
</script>
<div class="cMainContentManageUsers" id="cMainContentSubFolder">
    <div class="cTableContent cMainBox">
        <div style="display: flex;flex-direction: column; height: 100%">
            <h2 style="flex: 0 1 auto">Temperature Data</h2>
            <div style="flex: 1 1 auto">
                <canvas id="myChart"></canvas>
            </div>
        </div>
    </div>
</div>
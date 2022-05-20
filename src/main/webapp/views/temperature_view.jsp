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
                        {
                            x: '${temperature.timestamp}',
                            y: ${temperature.temperature},
                        }, </c:forEach>
                    ],
                    backgroundColor: '${location.color}',
                    borderColor: '${location.color.substring(0, location.color.length()-2)}0.5)',
                    hoverBorderColor: '${location.color.substring(0, location.color.length()-2)}1)',
                    borderWidth: 2,
                    showLine: true,
                    tension: 0.3,
                    pointRadius: 3,
                    pointHoverRadius: 5,
                    label: '${location.label}'
                },
                </c:forEach>
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                x: {
                    type: 'time',
                    time: {
                        unit: 'minute',
                        displayFormats: {
                            minute: 'dd.MM.yy - HH:mm'
                        },
                        tooltipFormat: 'dd.MM.yy - HH:mm'
                    },
                    ticks: {
                        autoSkip: true,
                        maxTicksLimit: 50,
                    },
                    display: true,
                    title: {
                        display: true,
                        text: 'Timestamp'
                    },
                },
                y: {
                    display: true,
                    title: {display: true, text: 'Temperature in °C'},
                    suggestedMin: 30,
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
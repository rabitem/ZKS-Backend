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
                    title: {display: true, text: 'Temperature in �C'},
                    suggestedMin: 30,
                    suggestedMax: 80,
                    ticks: {min: 20, max: 80, stepSize: 5}
                }
            },
        }
    });
</script>
<div class="cMainContentManageUsers" id="cMainContentSubFolder">
    <div class="cTableContent cMainBox cMainBoxFullStretch">
        <div style="display: flex;flex-direction: column; height: 100%">
            <div id = "cHeaderIcon" style="flex: 0 1 auto">
                <h2>Temperature Data</h2>
                <svg id = "refreshTemperature" width="2.5rem" height="2.5rem" viewBox="0 0 49 43" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M46.9402 3.83333V17.0833M46.9402 17.0833H34.7527M46.9402 17.0833L37.5152 7.45499C35.3321 5.0804 32.6313 3.34574 29.6648 2.41287C26.6983 1.48 23.5628 1.37932 20.5508 2.12023C17.5388 2.86114 14.7486 4.41949 12.4404 6.64988C10.1322 8.88026 8.38136 11.71 7.35117 14.875M2.25281 39.1667V25.9167M2.25281 25.9167H14.4403M2.25281 25.9167L11.6777 35.545C13.8608 37.9196 16.5616 39.6543 19.5281 40.5871C22.4946 41.52 25.6301 41.6207 28.6421 40.8798C31.6541 40.1388 34.4443 38.5805 36.7525 36.3501C39.0607 34.1197 40.8115 31.29 41.8417 28.125" stroke="#0a0c16" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>	
                </svg>
            </div>
            <%-- <h2 style="flex: 0 1 auto">Temperature Data</h2> --%>
            <div style="flex: 1 1 auto">
                <canvas id="myChart"></canvas>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById("refreshTemperature").addEventListener("click", () => {
        
        $.fn.loadTempView();
    });
</script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List"%>
<%@ page import = "java.sql.*" %>
<jsp:useBean id="temperatures" scope="request" type="java.util.List"/>

<script>
ctx = document.getElementById('myChart').getContext('2d');
myChart = new Chart(ctx, {
    type: 'line',
    data: {

         datasets: [{

         borderColor: "rgba(0,0,0,0)",
         backgroundColor: function ( context ) {
                                   const index = context.dataIndex;
                                   const value = context.dataset.data[index];
                                   if (typeof value !="undefined"){
                                       //alert(value.id);
                                       return value.color ;
                                       }
                                   },

         data: [
             <c:forEach items="${temperatures}" var="temperature">
             <fmt:parseDate pattern="yyyy-MM-dd HH:mm:ss.S" value="${temperature.timestamp}" var="parsedTimestamp" />
             <fmt:formatDate value="${parsedTimestamp}" pattern="HH:mm:ss dd.MM.yyyy" var="formatedTimestamp" />
             { color:'${temperature.location.color}',x:'${formatedTimestamp}', y:'${temperature.temperature}' },
             </c:forEach>]
          }]
    },
    options: {
       scales: {
           x: { display: true, title: { display: true, text: 'Date/Time' } },
           y: { display: true, title: { display: true, text: 'Temperature' }, suggestedMin: 20, suggestedMax: 100 }
       },

   }
});
</script>
<div class="cMainContentManageUsers" id = "cMainContentSubFolder">
    <div class="cTableContent cMainBox">
        <h2>Temperature Data</h2>

            <!-- Generated JSP Content -->
            <div>
                <div style="width:1200px;border:1px;float:left;">
                    <canvas id="myChart" width="1200" height="700"></canvas>
                </div>
                <div style="width:220px;border:1px;float:right;">
                    <Table>
                        <tr>
                            <th width=20>&nbsp;</th>
                            <th width=200>Location</th>
                        </tr>
                        <jsp:useBean id="locations" scope="request" type="java.util.List"/>
                        <c:forEach items="${locations}" var="location">
                        <tr class = "trCurData" id = "trData${location.label}" data-valueID = "${location.id}" data-name="${location.label}">
                           <td style ="color : ${location.color}">&#9673;</td>
                           <td>${location.label}</td>
                        </tr>
                        </c:forEach>
                    </Table>
                </div>
            </div>
    </div>
</div>
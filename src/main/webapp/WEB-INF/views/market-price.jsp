<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp"/>
<html>
<head>
    <title>Market Price</title>
    <style>
        #customers {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        #customers td, #customers th {
            border: 1px solid #ddd;
            padding: 8px;
        }

        #customers tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        #customers tr:hover {
            background-color: #ddd;
        }

        #customers th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: #F1B24A;
            color: white;
        }

        .styled-table {
            border-collapse: collapse;
            margin: 25px 0;
            font-size: 0.9em;
            font-family: sans-serif;
            min-width: 1050px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
        }

        .styled-table thead tr {
            background-color: #F1B24A;
            color: #ffffff;
            text-align: left;
        }

        .styled-table th,
        .styled-table td {
            padding: 12px 15px;
        }

        .styled-table tbody tr.active-row {
            font-weight: bold;
            color: #F1B24A;
        }

        .styled-table tbody tr {
            border-bottom: 1px solid #dddddd;
        }

        .styled-table tbody tr:nth-of-type(even) {
            background-color: #f3f3f3;
        }

        .styled-table tbody tr:last-of-type {
            border-bottom: 2px solid #F1B24A;
        }
    </style>
</head>
<body class="background">
<div class="container" style="margin-top: 100px;">
    <div class="card">
        <div class="card-title secondary text-white">
            <h3 class="text-center">Kalimati Market Retail Price</h3>
        </div>
        <div class="card-body">
            <table class="table styled-table" id="customers">
                <tr class="background text-white">
                    <td>Item Code</td>
                    <td>Commodity Name</td>
                    <td>Unit</td>
                    <td>Min Rate</td>
                    <td>Max Rate</td>
                    <td>Avg Rate</td>
                </tr>
            </table>
        </div>
        <div class="card-footer">
            <span>
                <strong><i>Source:</i> Open Data Nepal , <i>website: </i>http://opendatanepal.com</strong>
            </span>
        </div>
    </div>
</div>
</body>
<script>
    $(document).ready(function () {
        showData();
    });

    function showData() {
        $.ajax({
            url: "http://168.63.241.180/kalimati-price/api/today",
            type: "GET",
            success: function (data) {

                if (data == null) {
                    alert("no data found !!");

                } else {
                    console.log(data);
                    data.result.forEach(d => {
                        if (d['retailPrice'].length > 0) {
                            var m = "<tr><td>" + d['id'] +
                                "</td> <td>" + d['commodityName'] + "</td>";

                            m += ("<td>" + d['retailPrice'][0]['unit'] + "</td>" +
                                "<td>Rs. " + d['retailPrice'][0]['min'] + "</td>" +
                                "<td>Rs. " + d['retailPrice'][0]['max'] + "</td>" +
                                "<td>Rs. " + d['retailPrice'][0]['avg'] + "</td>")

                            m += "</tr>";
                            var tableBody = $("table tbody");
                            tableBody.append(m);
                        }
                    });
                }
            },

        });

    }
</script>
</html>

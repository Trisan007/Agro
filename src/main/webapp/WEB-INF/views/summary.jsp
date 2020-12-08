<!DOCTYPE HTML>
<html>
<head>
    <script>
        /*let price_hundred_to_fivety = 0;
        let price_hundred_fivety_to_two_hundred = 0;
        let price_two_hundred_to_two_hundred_fivety = 0;
        let price_two_hundred_fivety_to_three_hundred= 0;
        let total = 0;
        $(document).ready(function () {

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
                                if( d['retailPrice'][0]['avg'] > 100 && d['retailPrice'][0]['avg'] < 150) {
                                    price_hundred_to_fivety += d['retailPrice'][0]['avg'];
                                } else if( d['retailPrice'][0]['avg'] >= 150 && d['retailPrice'][0]['avg'] <= 200) {
                                    price_hundred_fivety_to_two_hundred += d['retailPrice'][0]['avg'];
                                } else if( d['retailPrice'][0]['avg'] >= 200 && d['retailPrice'][0]['avg'] <= 250) {
                                    price_two_hundred_to_two_hundred_fivety += d['retailPrice'][0]['avg'];
                                }else if( d['retailPrice'][0]['avg'] >= 250 && d['retailPrice'][0]['avg'] <= 300) {
                                    price_two_hundred_fivety_to_three_hundred += d['retailPrice'][0]['avg'];
                                }
                                total += d['retailPrice'][0]['avg'];
                            }
                        });
                        console.log(total);
                    }
                },

            });
        });*/



        // asddsd
        window.onload = function () {

            var options = {
                title: {
                    text: "Feed back summary"
                },
                subtitles: [{
                    text: "Feedback"
                }],
                animationEnabled: true,
                data: [{
                    type: "pie",
                    startAngle: 40,
                    toolTipContent: "<b>{label}</b>: {y}%",
                    showInLegend: "true",
                    legendText: "{label}",
                    indexLabelFontSize: 16,
                    indexLabel: "{label} - {y}%",
                    dataPoints: [
                        { y: 48.36, label: "One Star" },
                        { y: 26.85, label: "Two Star" },
                        { y: 1.49, label: "Three Star" },
                        { y: 6.98, label: "Four Star" },
                        { y: 6.53, label: "Five Star" },
                    ]
                }]
            };
            $("#chartContainer").CanvasJSChart(options);

        }
    </script>
</head>
<body>
<div id="chartContainer" style="height: 370px; width: 100%;"></div>
<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
</body>
</html>
$(function () {

        $('.leader-results').css({height: $(window).innerHeight()});
        $('.loser-results').css({height: $(window).innerHeight()});
        $('.total-results').css({height: $(window).innerHeight() - 50});

        $('a[href*=#]:not([href=#])').click(function() {
          if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
            if (target.length) {
              $('html,body').animate({
                scrollTop: target.offset().top
              }, 1000);
              return false;
            }
          }
        });

        $.getJSON( "results.json", function( data ) {
            console.log(data)

            $('#leader-name').text("User " + data.leader.name)
            $('#loser-name').text("User " + data.loser.name)

            $('#chi_squared').text(data.chi_squared)

            $( ".winner" ).each(function( index ) {
                var $id = $(this).find(".badge").attr("id")
                $(this).find(".badge").text(data.leader[$id])
            });

            $( ".loser" ).each(function( index ) {
                var $id = $(this).find(".badge").attr("id")
                $(this).find(".badge").text(data.loser[$id])
            });

            $('#bar_graph').highcharts({
                chart: {
                    type: 'column'
                },
                backgroundColor: {
                        linearGradient: [0, 0, 500, 500],
                        stops: [
                            [0, 'rgb(255, 255, 255)'],
                            [1, 'rgb(240, 240, 255)']
                            ]
                },
                title: {
                    text: 'Split A/B Test Results'
                },
                xAxis: {
                    categories: [
                        "User" + data.leader.name,
                        "User" + data.loser.name,
                    ]
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Requests'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} Requests</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0
                    }
                },
                series: [{
                    name: 'Total Requests',
                    data: [data.leader.total, data.loser.total]
            
                }, {
                    name: 'Converted Requests',
                    data: [data.leader.found, data.loser.found]
            
                }]
            });

    
        $('#leader-pie-chart').highcharts({
               chart: {
                   
                   plotBorderWidth: 1,//null,
                   plotShadow: false
               },
               plotBackgroundColor: 'rgba(255, 255, 255, .9)',
               title: {
                   text: 'User ' + data.leader.name + ' Conversion Rate'
               },
               tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
               },
               plotOptions: {
                   pie: {
                       allowPointSelect: true,
                       cursor: 'pointer',
                       dataLabels: {
                           enabled: true,
                           format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                           style: {
                               color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                           }
                       }
                   }
               },
               series: [{
                   type: 'pie',
                   name: 'Converted Requests',
                   data: [
                       ['Unconverted',   data.leader.total],
                       {
                           name: 'Converted',
                           y: data.leader.found,
                           sliced: true,
                           selected: true
                       },
                   ]
               }]
           });

            $('#loser-pie-chart').highcharts({
                   chart: {
                       plotBackgroundColor: null,
                       plotBorderWidth: 1,//null,
                       plotShadow: false
                   },
                   title: {
                        text: 'User ' + data.loser.name + ' Conversion Rate'
                   },
                   tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                   },
                   plotOptions: {
                       pie: {
                           allowPointSelect: true,
                           cursor: 'pointer',
                           dataLabels: {
                               enabled: true,
                               format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                               style: {
                                   color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                               }
                           }
                       }
                   },
                   series: [{
                       type: 'pie',
                       name: 'Converted Requests',
                   data: [
                       ['Unconverted',   data.loser.total],
                       {
                           name: 'Converted',
                           y: data.loser.found,
                           sliced: true,
                           selected: true
                       },
                   ]
                   }]
               });

        });

    });



    
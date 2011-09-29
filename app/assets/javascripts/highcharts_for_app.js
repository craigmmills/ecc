var chart;
$(document).ready(function() {

   // define the options
   var options = {

      chart: {
         renderTo: 'chart_this'
      },
      
      title: {
         text: 'Recent results',
         align: 'left'
      },
      // 
      // subtitle: {
      //    // text: 'Source: Nowhere'
      // },
      // 
      xAxis: {
         type: 'datetime',
         tickInterval: 7 * 24 * 3600 * 1000, // one week
         tickWidth: 0,
         gridLineWidth: 1,
         labels: {
            align: 'left',
            x: 3,
            y: -3 
         }
      },
      
      yAxis: [{ // left y axis
         title: {
            text: null
         },
         labels: {
            align: 'left',
            x: 3,
            y: 16,
            formatter: function() {
               return Highcharts.numberFormat(this.value, 0);
            }
         },
         showFirstLabel: false
      }, { // right y axis
         linkedTo: 0,
         gridLineWidth: 0,
         opposite: true,
         title: {
            text: null
         },
         labels: {
            align: 'right',
            x: -3,
            y: 16,
            formatter: function() {
               return Highcharts.numberFormat(this.value, 0);
            }
         },
         showFirstLabel: false
      }],
      
      legend: {
         align: 'right',
         verticalAlign: 'top',
         // y: 10,
         floating: true,
         borderWidth: 0
      },
      
      tooltip: {
         shared: true,
         crosshairs: true,
         // formatter: function() {
         //             return 'Opponent: '+ this.points.opponent;
         //         }
      },
      
      plotOptions: {
         series: {
            cursor: 'pointer',
            point: {
               events: {
                  click: function() {
                     hs.htmlExpand(null, {
                        pageOrigin: {
                           x: this.pageX, 
                           y: this.pageY
                        },
                        headingText: this.series.name,
                        maincontentText: Highcharts.dateFormat('%A, %b %e, %Y', this.x) +':<br/> '+ 
                           this.y +' visits',
                        width: 200
                     });
                  }
               }
            },
            marker: {
               lineWidth: 1
            }
         }
      },
      
      series: [{
         name: 'Our score',
         lineWidth: 15,
         marker: {
            radius: 4
         }
      }, {
         name: 'Their score'
      }]
   }
   
   // Load data asynchronously using jQuery. On success, add the data
   // to the options and initiate the chart.
   // This data is obtained by exporting a GA custom report to TSV.
   // http://api.jquery.com/jQuery.get/
   jQuery.get('/matches.json', function(data) {
      var //lines = [],
         data,
         listen = true,
         opponent,
         result,

         // set up the two data series
         ourScores = [],
         theirScores = [];
         
      try {
      // split the data return into lines and parse them
      // csv = csv.split(/\n/g);
      // jQuery.each(csv, function(i, line) {
      jQuery.each(data, function(i, record) {

         // listen for data lines between the Graph and Table headers
         // if (record[''].match(/^Opponents.+/)) {
         //   listen == false;
         // } else { listen == true};  
         
         // 
         if (listen) {
            // line = line.split(",");
            
            date = Date.parse(record['match_date']); // dropped the "+ 'UTC' " which was causing probs in FF
            opponent = record['away_team_id'];

            // opponent = line[0];

            ourScores.push([
               date,
               parseInt(record['home_runs']),
               opponent
            ]);
            theirScores.push([
               date,
               parseInt(record['away_runs']),
               opponent
            ]);
         }
      });
      } catch (e) { alert(e.message) }
      options.series[0].data = ourScores;
      options.series[1].data = theirScores;
      
      chart = new Highcharts.Chart(options);
   });
   
});
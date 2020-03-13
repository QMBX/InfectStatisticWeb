function createLineChart(id, data)
{
	optionLine = {
	        title: {
	            text: '全国疫情变化情况',
	            left: 'center',
	            top:'top',
	            textStyle: {
	                color: '#000'
	            }
	        },
	        legend: {
	            left:'center',
	            top:'bottom',
	            //icon:'circle',
	        },
	        tooltip: {
	            trigger: 'axis',
	            showContent: true
	        },
	        dataset: {
	            source: data
	        },
	        xAxis: {type: 'category'},
	        yAxis: {gridIndex: 0},
	        series: [
	            {type: 'line', smooth: false, seriesLayoutBy: 'row'},
	            {type: 'line', smooth: false, seriesLayoutBy: 'row'},
	            {type: 'line', smooth: false, seriesLayoutBy: 'row'},
	        ]
	    };
	    var lineChart = echarts.init(document.getElementById(id));
	    lineChart.setOption(optionLine);
}
function createTimeMap(id, data)
{
	optionTimeLine = {
   			baseOption: {
   				timeline: {
   					data: ['01-01', '01-02', '01-03'],
   					axisType: 'category',
   					//orient: 'vertical',
   					autoPlay:false,
   					left: 'left',
   					bottom: '0%',
   					width: '95%',
   					symbol: 'none',
   					playInterval: 1000,
   					controlStyle: {
   						showNextBtn: false,
   						showPrevBtn: false,
   						color: '#666',
   						borderColor: '#666'
   					},
   					checkpointStyle: {
   						color: '#bbb',
   						borderColor: '#777',
   						borderWidth: 2
   					},
   					emphasis: {
   						label: {
   							color: '#fff'
   						},
   						controlStyle: {
   							color: '#aaa',
   							borderColor: '#aaa'
   						}
   					},
   					
   				},
   				backgroundColor: '#D7D7D7',
   				title: {
   					text: '全国疫情情况',
   					left: 'center',
   					textStyle: {
   						color: '#fff'
   					}
   				},
   				tooltip: {
   						formatter:function(params,ticket, callback){
   							return params.seriesName+'<br />'+params.name+'：'+params.value
   						}//数据格式化
   					},
   				visualMap: {
   					
   					min: 0, //最小值
   					max: 1500, //最大值
   					left: 'left',
   					bottom:'10%',
   					splitNumber:5, //分成 5 段数据
   					//text: ['高','低'],//图注的文字
   					textStyle: { //
   						color: '#000'
   					},
   					inRange: {
   						color: ['#F2F2F2', '#6D000E'] //图注的颜色,左边为最低值时的颜色，右边最高值时的颜色
   					},
   					show:true//图注
   				},
   				
   				geo: {
   					map: 'china',//使用什么地图
   					roam: false,//不开启缩放和平移
   					zoom:1.23,//视角缩放比例
   					label: {
   						normal: {
   							show: true,
   							fontSize:'10',
   							color: 'rgba(0,0,0,0.7)'
   						}
   					},
   					itemStyle: {
   						normal:{
   							borderColor: 'rgba(0, 0, 0, 0.2)'
   						},
   						emphasis:{
   							areaColor: '#F3B329',//鼠标选择区域颜色
   							shadowOffsetX: 0,
   							shadowOffsetY: 0,
   							shadowBlur: 20,
   							borderWidth: 0,
   							shadowColor: 'rgba(0, 0, 0, 0.5)'
   						}
   					}
   				},
   				
   				series : [
   					{
   						name: '现存感染人员',//
   						type: 'map',//
   						geoIndex: 0,
   						data:dataList//地图数据
   						//data:dataset
   						
   					}
   				],
   			},
   			options: [
   				{ // 这是'2002-01-01' 对应的 option
   					title: {
   						text: '全国疫情情况'
   					},
   					series: [
   						{data: dataList}, // 系列一的数据
   					]
   				},
   				{ // 这是'2003-01-01' 对应的 option
   					title: {
   						text: '2003年统计值'
   					},
   					series: [
   						{data: dataList},
   					]
   				},
   				{ // 这是'2004-01-01' 对应的 option
   					title: {
   						text: '2004年统计值'
   					},
   					series: [
   						{data: dataList},
   					]
   				}
   			]
        };
    		
   		var timeLineChart = echarts.init(document.getElementById(id));
   		timeLineChart.setOption(optionTimeLine);

}
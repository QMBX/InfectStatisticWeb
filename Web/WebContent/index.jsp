<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="js/echarts.js"></script>
    <script src="js/china.js"></script>
    <style>
        *{margin:0;padding:0}
        html,body{
            width:100%;
            height:100%;
        }
		#time{
			width:600px;
            height:650px;
            margin: 150px auto;
            border:1px solid #ddd;
		}
    </style>

</head>
<body>

    <div id="time">
    </div>

	<script type="text/javascript">
        var dataList = [
            {name:"南海诸岛",value:0},
            {name: '北京', value: randomValue()},
            {name: '天津', value: randomValue()},
            {name: '上海', value: randomValue()},
            {name: '重庆', value: randomValue()},
            {name: '河北', value: randomValue()},
            {name: '河南', value: randomValue()},
            {name: '云南', value: randomValue()},
            {name: '辽宁', value: randomValue()},
            {name: '黑龙江', value: randomValue()},
            {name: '湖南', value: randomValue()},
            {name: '安徽', value: randomValue()},
            {name: '山东', value: randomValue()},
            {name: '新疆', value: randomValue()},
            {name: '江苏', value: randomValue()},
            {name: '浙江', value: randomValue()},
            {name: '江西', value: randomValue()},
            {name: '湖北', value: randomValue()},
            {name: '广西', value: randomValue()},
            {name: '甘肃', value: randomValue()},
            {name: '山西', value: randomValue()},
            {name: '内蒙古', value: randomValue()},
            {name: '陕西', value: randomValue()},
            {name: '吉林', value: randomValue()},
            {name: '福建', value: randomValue()},
            {name: '贵州', value: randomValue()},
            {name: '广东', value: randomValue()},
            {name: '青海', value: randomValue()},
            {name: '西藏', value: randomValue()},
            {name: '四川', value: randomValue()},
            {name: '宁夏', value: randomValue()},
            {name: '海南', value: randomValue()},
            {name: '台湾', value: randomValue()},
            {name: '香港', value: randomValue()},
            {name: '澳门', value: randomValue()}
        ];
        
        function randomValue() {
            return Math.round(Math.random()*1000);
        }
        
        optionTimeLine = {
   			baseOption: {
   				timeline: {
   					data: ['01-01', '01-02', '01-03'],
   					axisType: 'category',
   					orient: 'vertical',
   					autoPlay:false,
   					
   					left: null,
   					right: 0,
   					top: 20,
   					bottom: 20,
   					width: 55,
   					height: null,
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
   					text: '全国主要城市空气质量',
   					subtext: 'data from PM25.in',
   					sublink: 'http://www.pm25.in',
   					left: 'center',
   					textStyle: {
   						color: '#fff'
   					}
   				},
   				tooltip: {
   						formatter:function(params,ticket, callback){
   							return params.seriesName+'<br />'+params.name+'：'+params.value+'<br />'+params.tmp
   						}//数据格式化
   					},
   				visualMap: {
   					
   					min: 0, //最小值
   					max: 1500, //最大值
   					left: 'left',
   					top: 'bottom',
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
   						text: '2002年统计值'
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
    		
   		var timeLineChart = echarts.init(document.getElementById('time'));
   		timeLineChart.setOption(optionTimeLine);
       
   		timeLineChart.on('click', function (params) 
   		{ //点击时触发的事件
           alert(params.name);
        });
   		
   	</script>

</body>
</html>
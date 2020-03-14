<%@page import="pojo.Province"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>中国疫情数据</title>
    <link href="css/style.css" rel="stylesheet">
    <script src="js/echarts.js"></script>
    <script src="js/china.js"></script>
    <script src="js/TimeMap.js"></script>
    <script src="js/LineChart.js"></script>
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
	<div id="wrap">
	    <div id="header">
	        截止 2020-02-XX XX:XX 全国数据统计
	    </div>
	    <div id="info1">
	        <p>
	            较昨日
	            <span id="com1">-2408</span>
	        </p>
	        <p id="iden1">47502</p>
	        <p class="type">现存确诊</p>
	    </div>
	    <div id="info2">
	        <p>
	            较昨日
	            <span id="com2">+530</span>
	        </p>
	        <p id="iden2">2824</p>
	        <p class="type">现存疑似</p>
	    </div>
	    <div id="info3">
	        <p>
	            较昨日
	            <span id="com3">+71</span>
	        </p>
	        <p id="iden3">2666</p>
	        <p class="type">死亡</p>
	    </div>
	    <div id="info4">
	        <p>
	            较昨日
	            <span id="com4">+2860</span>
	        </p>
	        <p id="iden4">27617</p>
	        <p class="type">治愈</p>
	    </div>
	</div>
	<div id="map">
	    <button type="button" class="changeBtn">现有确诊</button>
	    <button type="button" class="changeBtn">累计确诊</button>
	    <div id="main">
	    </div>
	</div>
	<div id="line-head">
	
	    <div id="line">
	    </div>
	</div>

	<script type="text/javascript">
	
	 
	    var dataList=[
	    	{name:"南海诸岛",value:0},
	    	<% 
		 	request.setCharacterEncoding("utf-8");
		 	List<Province> provinces = (List)request.getAttribute("provinces");
		 	if (provinces != null)
		 		for(Province province : provinces)
		 		{
		 	%>
		 		{name: "<%= province.getName() %>", value : <%= province.getTreatingNum() %>},
		 	<% 
		 		}
		 	%>
	    ];
	
	    var dataList2=[
	        {name:"南海诸岛",value:0},
	        {name: '北京', value: 0},
	        {name: '天津', value: 0},
	        {name: '上海', value: 0},
	        {name: '重庆', value: 0},
	        {name: '河北', value: 0},
	        {name: '河南', value: 0},
	        {name: '云南', value: 0},
	        {name: '辽宁', value: 0},
	        {name: '黑龙江', value: 0},
	        {name: '湖南', value: 0},
	        {name: '安徽', value: 0},
	        {name: '山东', value: 0},
	        {name: '新疆', value: 0},
	        {name: '江苏', value: 0},
	        {name: '浙江', value: 0},
	        {name: '江西', value: 0},
	        {name: '湖北', value: 0},
	        {name: '广西', value: 0},
	        {name: '甘肃', value: 0},
	        {name: '山西', value: 0},
	        {name: '内蒙古', value: 0},
	        {name: '陕西', value: 0},
	        {name: '吉林', value: 0},
	        {name: '福建', value: 0},
	        {name: '贵州', value: 0},
	        {name: '广东', value: 0},
	        {name: '青海', value: 0},
	        {name: '西藏', value: 0},
	        {name: '四川', value: 0},
	        {name: '宁夏', value: 0},
	        {name: '海南', value: 0},
	        {name: '台湾', value: 0},
	        {name: '香港', value: 0},
	        {name: '澳门', value: 0}
	    ];
	    
	    function randomValue() {
	        return Math.round(Math.random()*10000);
	    }
	    
	    var timeChart = createTimeMap('main',dataList);
	    timeChart.on('click', function (params) { //点击时触发的事件
	        window.location.href = "province.html?province="+params.name;
	    });
	
	    optionClear = {
	        dataset : {
	            source: dataList2,
	        },
	    };
	    optionReset = {
	        dataset : {
	            source: dataList,
	        },
	    };
	    
	    var dataLine = [
	        ['product', '2012', '2013', '2014', '2015', '2016', '2017'],
	        ['新增确诊', 41.1, 30.4, 65.1, 53.3, 83.8, 98.7],
	        ['累计确诊', 86.5, 92.1, 85.7, 83.1, 73.4, 55.1],
	        ['治愈', 24.1, 67.2, 79.5, 86.4, 65.2, 82.5],
	        ['死亡', 20, 30, 10, 20, 40, 50],
	    ];
	    
	    var lineChart = createLineChart('line', dataLine);
	</script>

</body>
</html>
<%@page import="pojo.Province"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="js/echarts.js"></script>
    <script src="js/china.js"></script>
    <script src="js/TimeMap.js"></script>
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
<<<<<<< HEAD
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

        createTimeMap('time',dataList);
   	</script>
=======
	
	 
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
>>>>>>> ccfee10585920e79589d06489289522a3519febd

</body>
</html>
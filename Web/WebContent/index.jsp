<%@page import="pojo.Province,pojo.China"%>
<%@page import="java.text.SimpleDateFormat,java.util.Date,java.util.Calendar"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>中国疫情地图</title>
    <link href="css/style.css" rel="stylesheet">
    <script src="js/echarts.js"></script>
    <script src="js/china.js"></script>
    <script src="js/TimeMap.js"></script>
    <script src="js/LineChart.js"></script>

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
	    
	    var timeChart = createTimeMap('main',dataList);
	    timeChart.on('click', function (params) { //点击时触发的事件
	        window.location.href = "province.html?province="+params.name;
	    });

	    
	    var dataLine = 
	    [
	    	['product'
	    	<%
	    		int days = 10;
	    		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM-dd");
	    		Date currentTime = new Date();
	    		Calendar calendar = Calendar.getInstance();
	    		List<China> chinas = (List)request.getAttribute("chinas");
	    		
	    		calendar.setTime(currentTime);
	    		calendar.add(calendar.DATE, -10);
	    		for(int i = 0; i < days; i++,calendar.add(calendar.DATE, +1))
	    		{
	    	%>
	    	, "<%= simpleDateFormat.format(calendar.getTime()) %>"
	    	<%
	    		}
	    	%>
	    	],
	    	['新增确诊' 
		        <% 
		        	for(int i = days-1; i >= 0; i--)
		        	{
		        %>
		        	,<%= chinas.get(i).getConfirmedNum() - chinas.get(i+1).getConfirmedNum() %>
		        <%
		        	}
		        %>
		        ],
		        
		        ['累计确诊' 
		        <% 
	        		for(int i = days-1; i >= 0; i--)
		        	{
		        %>
		        	,<%= chinas.get(i).getConfirmedNum() %>
		        <%
		        	}
		        %>
		        ],
		        
				['治愈' 
		        <% 
	        		for(int i = days-1; i >= 0; i--)
		        	{
		        %>
		        	,<%= chinas.get(i).getCuresNum() %>
		        <%
		        	}
		        %>
		        ],

				['死亡' 
		        <% 
	        		for(int i = days-1; i >= 0; i--)
		        	{
		        %>
		        	,<%= chinas.get(i).getDeathsNum() %>
		        <%
		        	}
		        %>
		        ],
		    ];
	    

	    
	    var lineChart = createLineChart('line', dataLine);

	</script>

</body>
</html>
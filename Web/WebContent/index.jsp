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
    
    <%
    	List<China> chinaData = (List)request.getAttribute("chinas");
    	China chinaToday = chinaData.get(0);
    	China chinaYesterday = chinaData.get(1);
    	int increaseTreating = chinaToday.getTreating() - chinaYesterday.getTreating();
    	int increaseSuspected = chinaToday.getSuspectedNum() - chinaYesterday.getSuspectedNum();
    	int increaseDeaths = chinaToday.getDeathsNum() - chinaYesterday.getDeathsNum();
    	int increaseCures = chinaToday.getCuresNum() - chinaYesterday.getCuresNum();
    %>
    
        截止 <%= chinaToday.getDate() %> 23:59 全国数据统计
    </div>
    <div id="info1">
        <p>
            较昨日
            <span id="com1"><%= (increaseTreating > 0 ? "+" : "") + increaseTreating %></span>
        </p>
        <p id="iden1"><%= chinaToday.getTreating() %></p>
        <p class="type">现存确诊</p>
    </div>
    <div id="info2">
        <p>
            较昨日
            <span id="com2"><%= (increaseSuspected > 0 ? "+" : "") + increaseSuspected %></span>
        </p>
        <p id="iden2"><%= chinaToday.getSuspectedNum() %></p>
        <p class="type">现存疑似</p>
    </div>
    <div id="info3">
        <p>
            较昨日
            <span id="com3"><%= (increaseDeaths > 0 ? "+" : "") + increaseDeaths %></span>
        </p>
        <p id="iden3"><%= chinaToday.getDeathsNum() %></p>
        <p class="type">死亡</p>
    </div>
    <div id="info4">
        <p>
            较昨日
            <span id="com4"><%= (increaseCures > 0 ? "+" : "") + increaseCures %></span>
        </p>
        <p id="iden4"><%= chinaToday.getCuresNum() %></p>
        <p class="type">治愈</p>
    </div>
</div>
<div id="map">
    <button id='btnCur' type="button" class="changeBtn">现有确诊</button>
    <button id='btnSum' type="button" class="changeBtn">累计确诊</button>
    <div id="main">
    </div>
</div>
<div id="line-head">

    <div id="line">
    </div>
</div>


	<script type="text/javascript">
		
		var data = {
			timeline : [
				<% 
				 	request.setCharacterEncoding("utf-8");
				 	List<List<Province>> provinces = (List)request.getAttribute("provinces");
				 	if (provinces != null)
				 	{
				 		for(List<Province> province : provinces)
				 		{
			 	%>
			 		'<%= (province.get(0).getDate().getMonth()+1)+"-"+ province.get(0).getDate().getDate()%>',
			 	<% 
			 			}
				 	}
			 	%>
			],
			series : [
				<%
					for(int i = 0; i < provinces.size(); i++)
					{
				%>
				[
					{name:"南海诸岛",value:0},
				<%
						List<Province> oneDay = provinces.get(i);
						for(Province province : oneDay)
						{
				%>
					{name: "<%= province.getName() %>", value : <%= province.getTreatingNum() %>},
				<%
						}
				%>
				],
				<%
					}
				%>
			],
		}
		
		var dataSum = {
				timeline : [
					<% 
					 	request.setCharacterEncoding("utf-8");
					 	if (provinces != null)
					 	{
					 		for(List<Province> province : provinces)
					 		{
				 	%>
				 		'<%= (province.get(0).getDate().getMonth()+1)+"-"+ province.get(0).getDate().getDate()%>',
				 	<% 
				 			}
					 	}
				 	%>
				],
				series : [
					<%
						for(int i = 0; i < provinces.size(); i++)
						{
					%>
					[
						{name:"南海诸岛",value:0},
					<%
							List<Province> oneDay = provinces.get(i);
							for(Province province : oneDay)
							{
					%>
						{name: "<%= province.getName() %>", value : <%= province.getConfirmedNum() %>},
					<%
							}
					%>
					],
					<%
						}
					%>
				],
			}
	 
	    var dataList = [
	    	{name:"南海诸岛",value:0},
	    	<% 
			 	request.setCharacterEncoding("utf-8");
			 	//List<Province> provinces = (List)request.getAttribute("provinces");
			 	if (provinces != null)
			 	{
			 		List<Province> todayProvinces = provinces.get(provinces.size() - 1);
			 		for(Province province : todayProvinces)
			 		{
		 	%>
		 			{name: "<%= province.getName() %>", value : <%= province.getTreatingNum() %>},
		 	<% 
		 			}
			 	}
		 	%>
	    ];
	    
	    var timeChart = createTimeMap('main',dataList);
	    timeChart.on('click', function (params) { //点击时触发的事件
	        window.location.href = "province.html?province="+params.name;
	    });
	    
	    var optionTime = {
	    	baseOption : {
	    		timeline : {
	    			data : [],
	    			currentIndex : data.timeline.length - 1,
	    		}
	    	},
	    	options : [],
	    };
	    var optionTimeSum = {
	    	baseOption : {
	    		timeline : {
	    			data : [],
	    			currentIndex : data.timeline.length - 1,
	    		}
	    	},
	    	options : [],
	    };

	    for (var n = 0; n < data.timeline.length; n++)
		{
	    	optionTime.baseOption.timeline.data.push(data.timeline[n]);
	    	optionTime.options.push({
	            title :
	            {
	                show: true,
	                'text': data.timeline[n] + '日全国各省现有确诊',
	            },
	            series :
	            {
	                name: '现有确诊',
	                data: data.series[n],
	                type : 'map',
					geoIndex : 0,
	            }
	        });
	    }
	    timeChart.setOption(optionTime);
	    
	    for (var n = 0; n < data.timeline.length; n++)
		{
	    	optionTimeSum.baseOption.timeline.data.push(dataSum.timeline[n]);
	    	optionTimeSum.options.push({
	            title :
	            {
	                show: true,
	                'text': dataSum.timeline[n] + '日全国各省累计确诊',
	            },
	            series :
	            {
	                name: '累计确诊',
	                data: dataSum.series[n],
	                type : 'map',
					geoIndex : 0,
	            }
	        });
	    }
	    timeChart.setOption(optionTime);
	    
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

	    
	    document.getElementById('btnCur').onclick = function()
	    {
	    	timeChart.setOption(optionTime);
	    }
	    document.getElementById('btnSum').onclick = function()
	    {
	    	timeChart.setOption(optionTimeSum);
	    }
	</script>

</body>
</html>
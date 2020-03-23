<%@page import="pojo.Province,pojo.Province"%>
<%@page import="java.text.SimpleDateFormat,java.util.Date,java.util.Calendar"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>map</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <link href="css/style.css" rel="stylesheet">
    <script src="js/echarts.js"></script>
    <script src="js/china.js"></script>
</head>
<body>

<div id="wrap">
    <div id="header">
    <%
    	request.setCharacterEncoding("utf-8");
    	List<Province> allDayData = (List)request.getAttribute("allDayDate");
    	Province lastData = allDayData.get(allDayData.size() - 1);
    	Province yesterdayData = allDayData.get(allDayData.size() - 2);
    	String provinceName = lastData.getName();
    	int increaseTreating = lastData.getTreatingNum() - yesterdayData.getTreatingNum();
    	int increaseConfirmedNum = lastData.getConfirmedNum() - yesterdayData.getConfirmedNum();
    	int increaseDeaths = lastData.getDeathsNum() - yesterdayData.getDeathsNum();
    	int increaseCures = lastData.getCuresNum() - yesterdayData.getCuresNum();
    %>
        截止 <%= lastData.getDate() %> 23:59 <%= provinceName %>数据统计
    </div>
    <div id="info1">
        <p>
            较昨日
            <span id="com1"><%= (increaseTreating > 0 ? "+" : "") + increaseTreating %></span>
        </p>
        <p id="iden1"><%= lastData.getTreatingNum() %></p>
        <p class="type">现存确诊</p>
    </div>
    <div id="info2">
        <p>
            较昨日
            <span id="com2"><%= (increaseConfirmedNum > 0 ? "+" : "") + increaseConfirmedNum %></span>
        </p>
        <p id="iden2"><%= lastData.getConfirmedNum() %></p>
        <p class="type">累计确诊</p>
    </div>
    <div id="info3">
        <p>
            较昨日
            <span id="com3"><%= (increaseDeaths > 0 ? "+" : "") + increaseDeaths %></span>
        </p>
        <p id="iden3"><%= lastData.getDeathsNum() %></p>
        <p class="type">死亡</p>
    </div>
    <div id="info4">
        <p>
            较昨日
            <span id="com4"><%= (increaseCures > 0 ? "+" : "") + increaseCures %></span>
        </p>
        <p id="iden4"><%= lastData.getCuresNum() %></p>
        <p class="type">治愈</p>
    </div>
</div>

<div id="line-head">

    <div id="line">
    </div>
</div>


<script type="text/javascript">
    //接受参数
    function GetRequest() {
        var url = location.search; //获取url中"?"符后的字串
        var theRequest = new Object();
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            strs = str.split("&");
            for (var i = 0; i < strs.length; i++) {
                theRequest[strs[i].split("=")[0]] = decodeURIComponent(strs[i].split("=")[1]);
            }
        }
        return theRequest;
    }
    function randomValue() {
        return Math.round(Math.random()*1000);
    }
    var a = GetRequest();
    optionLine = {
        title: {
            text: '省份:'+ a['province'],
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
            source: [
            	['product'
            	<%
        			for(int i = 1; i < allDayData.size(); i++)
            		{
        				Province province = allDayData.get(i);
            	%>
            		,'<%= (province.getDate().getMonth()+1) + "-" + province.getDate().getDate()%>'
            	<%
            		}
            	%>
            	],
                
                ['新增确诊'
               	<%
            		for(int i = 1; i < allDayData.size(); i++)
            		{
            	%>
            		,<%= allDayData.get(i).getConfirmedNum() - allDayData.get(i - 1).getConfirmedNum()%>
            	<%
            		}
            	%>
                ], 
                ['累计确诊'
               	<%
            		for(int i = 1; i < allDayData.size(); i++)
            		{
            	%>
            		,<%= allDayData.get(i).getConfirmedNum()%>
            	<%
            		}
            	%>
				],
                ['治愈'
               	<%
            		for(int i = 1; i < allDayData.size(); i++)
            		{
            	%>
            		,<%= allDayData.get(i).getCuresNum()%>
            	<%
            		}
            	%>
                ],
                ['死亡'
               	<%
            		for(int i = 1; i < allDayData.size(); i++)
            		{
            	%>
            		,<%= allDayData.get(i).getDeathsNum()%>
            	<%
            		}
            	%>
                ],
            ]
        },
        xAxis: {type: 'category'},
        yAxis: {gridIndex: 0},
        series: [
            {type: 'line', smooth: false, seriesLayoutBy: 'row'},
            {type: 'line', smooth: false, seriesLayoutBy: 'row'},
            {type: 'line', smooth: false, seriesLayoutBy: 'row'},
            {type: 'line', smooth: false, seriesLayoutBy: 'row'},
        ]
    };
    var lineChart = echarts.init(document.getElementById('line'));
    lineChart.setOption(optionLine);


</script>
</body>
</html>
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.jsoup.Jsoup;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException;



public class FirstCrawler
{
    public static String USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:49.0) Gecko/20100101 Firefox/49.0";
    public static String HOST = "i.snssdk.com";
    public static String REFERER = "https://i.snssdk.com/feoffline/hot_list/template/hot_list/forum_tab.html?activeWidget=1";
      
    public static void main(String[] args) throws IOException, SQLException
    {
         //URL
    	String url = "https://i.snssdk.com/forum/home/v1/info/?activeWidget=1&forum_id=1656784762444839";
    	String resultBody = Jsoup.connect(url).

        userAgent(USER_AGENT).header("Host", HOST).header("Referer", REFERER).execute().body();

        JSONObject jsonObject = JSON.parseObject(resultBody);
        String ncovStringList = jsonObject.getJSONObject("forum").getJSONObject("extra").getString("ncov_string_list");
        JSONObject ncovListObj = JSON.parseObject(ncovStringList);
        
        init(ncovListObj);
        
        System.out.println("finish");
    }
    
    public static void init(JSONObject ncovListObj)
    {
    	provinceInit(ncovListObj);
    	nationInit(ncovListObj);
    }
    
    public static void provinceInit(JSONObject ncovListObj)
    {
    	//province表的数据
    	JSONArray provincesdata = ncovListObj.getJSONArray("provinces");
    	String name, date, treatingNum, confirmedNum, curesNum, deathsNum;
    	String confirmedIncrNum, confirmedIncrStr, curesIncrStr, deathsIncrStr, treatingIncrStr; 
    	int insertNums = 0;
    	
    	String sql = "INSERT INTO province VALUES(?, ?, ?, ?, ?, ?)";
    	try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql))
    	{
	    	for (int i = 0; i < provincesdata.size(); i++)
	    	{
	        	JSONObject procinceData = provincesdata.getJSONObject(i);
	        	JSONObject provinceIncr = procinceData.getJSONObject("provinceIncr");
	        	//获取省份历史数据
	        	JSONArray seriesData = procinceData.getJSONArray("series");
	        	
	        	//获取省份名称
	        	name = procinceData.getString("name");
	        	for (int j = 0; j < seriesData.size(); j++)
	        	{
	        		try
		        	{
		        		JSONObject dateData = seriesData.getJSONObject(j);
		        		
		        		date = dateData.getString("date") + " 23:59:59";
		        		confirmedNum = dateData.getString("confirmedNum");
		        		curesNum = dateData.getString("curesNum");
		        		deathsNum = dateData.getString("deathsNum");
		        		treatingNum = dateData.getString("treatingNum");
		        		
		        		ps.setString(1, name);
		        		ps.setString(2, date);
		        		ps.setString(3, confirmedNum);
		        		ps.setString(4, curesNum);
		        		ps.setString(5, deathsNum);
		        		ps.setString(6, treatingNum);
		        		ps.execute();
		        		insertNums++;
		        	}
		        	catch (MySQLIntegrityConstraintViolationException e)
		        	{
		        		//e.printStackTrace();
		            }
	        	}
	    	}
    	}
    	catch (SQLException e)
    	{
            e.printStackTrace();
        }
    	System.out.print("省份数据收集完毕,新增" + insertNums + "条数据\n");
    }
    
    public static void nationInit(JSONObject ncovListObj)
    {
    	
    	//nation表的数据
    	JSONArray nationdata = ncovListObj.getJSONArray("nationwide");
    	String date, confirmedNum, suspectedNum, curesNum, deathsNum, treatingNum;
    	int insertNums = 0;
    	
    	String sql = "INSERT INTO nation VALUES(?, ?, ?, ?, ?, ?)";
    	try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql))
    	{
	        for ( int i = 0; i < nationdata.size(); i++)
	        {
	        	try
	        	{
		        	JSONObject dateData = nationdata.getJSONObject(i);
		        	
		        	date = dateData.getString("date");
		        	confirmedNum = dateData.getString("confirmedNum");
		        	suspectedNum = dateData.getString("suspectedNum");
		        	curesNum = dateData.getString("curesNum");
		        	deathsNum = dateData.getString("deathsNum");
		        	treatingNum = dateData.getString("treatingNum");
		        	
		        	ps.setString(1, date);
		        	ps.setString(2, confirmedNum);
		        	ps.setString(3, suspectedNum);
		        	ps.setString(4, curesNum);
		        	ps.setString(5, deathsNum);
		        	ps.setString(6, treatingNum);
		        	ps.execute();
		        	insertNums++;
	        	}
	        	catch (MySQLIntegrityConstraintViolationException e)
	        	{
	        		
	            }
	        }
        }
    	catch (SQLException e)
    	{
            e.printStackTrace();
        }
    	System.out.print("全国数据收集完毕,新增" + insertNums + "条数据\n");
    }
    
    
    
    
    public static String timeStamp2Date(String seconds,String format) {  
        if(seconds == null || seconds.isEmpty() || seconds.equals("null")){  
            return "";  
        }  
        if(format == null || format.isEmpty()){
            format = "yyyy-MM-dd HH:mm:ss";
        }   
        SimpleDateFormat sdf = new SimpleDateFormat(format);  
        return sdf.format(new Date(Long.valueOf(seconds+"000")));  
    }  
    
}

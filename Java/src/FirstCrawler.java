import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.jsoup.Jsoup;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;



public class FirstCrawler
{
    public static String USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:49.0) Gecko/20100101 Firefox/49.0";
    public static String HOST = "i.snssdk.com";

    public static String REFERER = "https://i.snssdk.com/feoffline/hot_list/template/hot_list/forum_tab.html?activeWidget=1";
      
    public static void main(String[] args) throws IOException, SQLException
    {
         //¸ùURL
    	String url = "https://i.snssdk.com/forum/home/v1/info/?activeWidget=1&forum_id=1656784762444839";

        String resultBody = Jsoup.connect(url).

        userAgent(USER_AGENT).header("Host", HOST).header("Referer", REFERER).execute().body();

        JSONObject jsonObject = JSON.parseObject(resultBody);

        String ncovStringList = jsonObject.getJSONObject("forum").getJSONObject("extra").getString("ncov_string_list");

        JSONObject ncovListObj = JSON.parseObject(ncovStringList);
        JSONArray todaydata = ncovListObj.getJSONArray("provinces");
        
        //QueryRunner queryRunner = new QueryRunner(DataSourceUtils.getDataSource());
        String sql = "insert into todaydata_copy1 values(?,?,?,?,?,?,?,?)";
        try (Connection c = DBUtil.getConnection();PreparedStatement ps = c.prepareStatement(sql))
        {
            String confirmedNum,deathsNum,cityname,cityid,treatingNum,provinceid;
            String reprovinceid=null;
            int confirmedNumSum=0,deathsNumSum=0,treatingNumSum=0;
            for(int i=0;i<todaydata.size();i++)
            {
                JSONObject todayData1 = todaydata.getJSONObject(i);
                String provinceName = todayData1.getString("name");
                String updateDate = todayData1.getString("updateDate");
                JSONArray city = todayData1.getJSONArray("cities");
                for(int j=0;j<city.size();j++) {
                    JSONObject cities = city.getJSONObject(j);
                    confirmedNum= cities.getString("confirmedNum");
                    deathsNum = cities.getString("deathsNum");
                    cityname = cities.getString("name");
                    cityid = cities.getString("id");
                    treatingNum = cities.getString("treatingNum");
                    provinceid = cityid.substring(0,2);
                    reprovinceid=provinceid;
                    confirmedNumSum+=Integer.parseInt(confirmedNum);
                    deathsNumSum+=Integer.parseInt(deathsNum);
                    treatingNumSum+=Integer.parseInt(treatingNum);
                    System.out.println(updateDate+" | "+provinceName+" | "+cityname+" | "+confirmedNum+" | "+deathsNum+" | "+treatingNum+" | "+cityid);
                    //queryRunner.update(sql, updateDate,provinceid,cityname,confirmedNum,deathsNum,treatingNum,cityid,null);
                }
                System.out.println(updateDate+" | "+provinceName+" | "+confirmedNumSum+" | "+deathsNumSum+" | "+treatingNumSum);
                //queryRunner.update(sql,updateDate,reprovinceid,null,confirmedNumSum,deathsNumSum,treatingNumSum,null,null); 
                confirmedNumSum=0;
                deathsNumSum=0;
                treatingNumSum=0;
            }
        }
    }
}

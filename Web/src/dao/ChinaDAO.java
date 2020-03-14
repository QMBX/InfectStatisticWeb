package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import pojo.China;
import util.DBUtil;

public class ChinaDAO
{
	public List<China> listSomeDay(int nums) {
		List<China> chinaDatas = null;
		String sql = " SELECT * FROM nation ORDER BY date DESC LIMIT " + nums;
			
        try (Connection c = DBUtil.getConnection();PreparedStatement ps = c.prepareStatement(sql)) {
        	China chinaData = null;
        	chinaDatas = new ArrayList<China>();
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
            	chinaData = new China();
            	
            	chinaData.setDate(rs.getDate("date"));
            	chinaData.setConfirmedNum(rs.getInt("confirmedNum"));
            	chinaData.setSuspectedNum(rs.getInt("suspectedNum"));
            	chinaData.setCuresNum(rs.getInt("curesNum"));
            	chinaData.setDeathsNum(rs.getInt("deathsNum"));
            	chinaData.setTreating(rs.getInt("treatingNum"));
            	
            	chinaDatas.add(chinaData);
            }
        } catch (SQLException e) {

            e.printStackTrace();
        }
		
		
       return chinaDatas;

    }
}

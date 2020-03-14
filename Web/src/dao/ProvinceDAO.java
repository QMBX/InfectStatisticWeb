package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import pojo.Province;
import servlet.DBUtil;

public class ProvinceDAO
{
	private final static int PROVINCES = 34;
	
	public List<Province> listLast() {
		List<Province> provinces = null;
		String sql = " SELECT * FROM province b1 "
			+ " WHERE (SELECT COUNT(1) FROM province b2 WHERE b1.name = b2.name AND b2.date > b1.date) < 1; ";
        try (Connection c = DBUtil.getConnection();PreparedStatement ps = c.prepareStatement(sql)) {
        	Province province = null;
        	provinces = new ArrayList<Province>();
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
            	province = new Province();
            	province.setName(rs.getString("name"));
            	province.setDate(rs.getDate("date"));
            	province.setConfirmedNum(rs.getInt("confirmedNum"));
            	province.setCuresNum(rs.getInt("curesNum"));
            	province.setDeathsNum(rs.getInt("deathsNum"));
            	province.setTreatingNum(rs.getInt("treatingNum"));
            	
            	provinces.add(province);
            }
        } catch (SQLException e) {

            e.printStackTrace();
        }
		
		
       return provinces;

    }
	
	public List<Province> listAllDate() {
		List<Province> provinces = null;
		String sql = " SELECT * FROM province b1 "
			+ " WHERE (SELECT COUNT(1) FROM province b2 WHERE b1.name = b2.name AND b2.date > b1.date) < 1; ";
        try (Connection c = DBUtil.getConnection();PreparedStatement ps = c.prepareStatement(sql)) {
        	Province province = null;
        	provinces = new ArrayList<Province>();
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
            	province = new Province();
            	province.setName(rs.getString("name"));
            	province.setDate(rs.getDate("date"));
            	province.setConfirmedNum(rs.getInt("confirmedNum"));
            	province.setCuresNum(rs.getInt("curesNum"));
            	province.setDeathsNum(rs.getInt("deathsNum"));
            	province.setTreatingNum(rs.getInt("treatingNum"));
            	
            	provinces.add(province);
            }
        } catch (SQLException e) {

            e.printStackTrace();
        }
		
		
       return provinces;

    }
}

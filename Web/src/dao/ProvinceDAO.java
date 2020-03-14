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
	public List<Province> listLast() {
		List<Province> provinces = null;
		String sql = "SELECT * FROM PROVINCE";
        try (Connection c = DBUtil.getConnection();PreparedStatement ps = c.prepareStatement(sql)) {
        	Province user = null;
        	provinces = new ArrayList<Province>();
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
            	user = new Province();
            	provinces.add(user);
            }
        } catch (SQLException e) {

            e.printStackTrace();
        }
		
		
       return users;

    }
}

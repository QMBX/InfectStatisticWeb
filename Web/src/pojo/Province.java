package pojo;

import java.sql.Date;

public class Province
{
	private String name;
	private Date date;
	private int confirmedNum;
	private int curesNum;
	private int deathsNum;
	private int treatingNum;
	
	public String getName()
	{
		return name;
	}
	
	public void setName(String name)
	{
		this.name = name;
	}
	
	public Date getDate()
	{
		return date;
	}
	
	public void setDate(Date date)
	{
		this.date = date;
	}
	
	public int getConfirmedNum()
	{
		return confirmedNum;
	}
	
	public void setConfirmedNum(int confirmedNum)
	{
		this.confirmedNum = confirmedNum;
	}
	
	public int getCuresNum()
	{
		return curesNum;
	}
	
	public void setCuresNum(int curesNum)
	{
		this.curesNum = curesNum;
	}
	
	public int getDeathsNum()
	{
		return deathsNum;
	}
	
	public void setDeathsNum(int deathsNum)
	{
		this.deathsNum = deathsNum;
	}
	
	public int getTreatingNum()
	{
		return treatingNum;
	}
	
	public void setTreatingNum(int treatingNum)
	{
		this.treatingNum = treatingNum;
	}
	
	
}

package pojo;

public class China
{
	private String date;
	private int confirmedNum;
	private int suspectedNum;
	private int curesNum;
	private int deathsNum;
	private int treating;
	public String getDate()
	{
		return date;
	}
	public void setDate(String date)
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
	public int getSuspectedNum()
	{
		return suspectedNum;
	}
	public void setSuspectedNum(int suspectedNum)
	{
		this.suspectedNum = suspectedNum;
	}
	public int getDeathsNum()
	{
		return deathsNum;
	}
	public void setDeathsNum(int deathsNum)
	{
		this.deathsNum = deathsNum;
	}
	public int getTreating()
	{
		return treating;
	}
	public void setTreating(int treating)
	{
		this.treating = treating;
	}
}

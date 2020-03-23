package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ChinaDAO;
import dao.ProvinceDAO;
import pojo.China;
import pojo.Province;

/**
 * Servlet implementation class China
 */
@WebServlet("/China")
public class ChinaServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChinaServlet()
    {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		ProvinceDAO provinceDAO = new ProvinceDAO();
		
		int showDay = 10;
		
		List<List<Province>> provinces = provinceDAO.listSomeDay(showDay);
		
		ChinaDAO chinaDAO = new ChinaDAO();
		//新增数量由两天数量计算得到，所以需要多一天的数据
		List<China> chinas = chinaDAO.listSomeDay(showDay + 1);
		request.setAttribute("provinces", provinces);
		request.setAttribute("chinas", chinas);
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

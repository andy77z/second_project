package soju.artist.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import soju.service.BoardServiceImpl;
import soju.service.IBoardService;
import soju.vo.BoardVO;


/**
 * Servlet implementation class ArtBoardDetail
 */
@WebServlet("/ArtBoardDetail.do")
public class ArtBoardDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ArtBoardDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int bdNum = Integer.parseInt(request.getParameter("bdNum"));
	    
		 
		//1. 
		IBoardService service = BoardServiceImpl.getInstance();
		
		//2.
		List<BoardVO> vo = service.getDetail(bdNum);
	     
		//3.
		request.setAttribute("artBoardDetail", vo);

		//4.
		request.getRequestDispatcher("boardframe/artBoardDetail.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

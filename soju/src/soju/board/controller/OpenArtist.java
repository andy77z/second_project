package soju.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import soju.service.BoardServiceImpl;
import soju.service.IBoardService;
import soju.vo.MemberVO;
import soju.vo.SubscribeVO;

@WebServlet("/openArtist.do")
public class OpenArtist extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int art_num = Integer.parseInt(request.getParameter("art_num"));
		
		HttpSession session = request.getSession();
		session.setAttribute("art_num", art_num);
		
		if(session.getAttribute("loginUser") instanceof MemberVO) {
			MemberVO vo = (MemberVO) session.getAttribute("loginUser");
			
			SubscribeVO svo = new SubscribeVO();
			svo.setArt_num(art_num);
			svo.setMem_num(vo.getMem_num());
			
			IBoardService service = BoardServiceImpl.getInstance();
			int result = service.checkSub(svo);
			
			
			
			if(result > 0) {
				request.setAttribute("art_num", art_num);
				request.getRequestDispatcher("jsp/feed/feed0.jsp").forward(request, response);
			}else {
				session.setAttribute("svo", svo);
				request.getRequestDispatcher("jsp/board/subscribe.jsp").forward(request, response);
			}
		}else {
			request.setAttribute("art_num", art_num);
			request.getRequestDispatcher("jsp/feed/feed0.jsp").forward(request, response);
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

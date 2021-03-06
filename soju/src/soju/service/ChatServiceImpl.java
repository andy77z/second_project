package soju.service;

import java.sql.SQLException;
import java.util.List;

import soju.dao.ChatDaoImpl;
import soju.dao.IChatDao;
import soju.vo.ChatVO;


public class ChatServiceImpl implements IChatService{

	private IChatDao dao;
	private static ChatServiceImpl service;
	
	private ChatServiceImpl() {
		dao = ChatDaoImpl.getInstance();
	}
	
	public static ChatServiceImpl getInstance() {
		if(service==null) service = new ChatServiceImpl();
		return service;
	}

	@Override
	public List<ChatVO> chatList(String art_name) {
		List<ChatVO> chatlist = null;
		try {
			chatlist = dao.chatList(art_name);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return chatlist;
	}

	@Override
	public int insertChat(ChatVO vo) {
		int res = 0;
		try {
			res = dao.insertChat(vo);
			System.out.println(res);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	//db지우기
	@Override
	public int deleteChat() {
		int res = 0;
		try {
			res= dao.deleteChat();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<ChatVO> chatListArt(String nowTime) {
		List<ChatVO> chatlist = null;
		try {
			chatlist = dao.chatList(nowTime);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return chatlist;
	}
	
}

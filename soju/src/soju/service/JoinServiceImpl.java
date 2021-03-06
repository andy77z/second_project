package soju.service;

import java.sql.SQLException;
import java.util.List;

import soju.dao.IJoinDao;
import soju.dao.JoinDaoImpl;
import soju.vo.Login_infoVO;
import soju.vo.MemberVO;

public class JoinServiceImpl implements IJoinService{

	private IJoinDao dao;
	private static IJoinService service;
	
	private JoinServiceImpl() {
		dao = JoinDaoImpl.getJoinDao();
	}
	
	public static IJoinService getJoinService(){
		if(service==null) service = new JoinServiceImpl();
		return service;
	}
	@Override
	public String checkId(String id) {
		String memId=null;
		try {
			 memId = dao.checkId(id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return memId;
	}

	@Override
	public String insertMember(MemberVO vo, Login_infoVO lvo) {
		String ins=null;
		try {
			 ins = dao.insertMember(vo);
			 if(ins!=null) dao.insertMember_info(lvo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ins;
	}

	@Override
	public String checkNick(String nick) {
		String memNick=null;
		try {
			 memNick = dao.checkNick(nick);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return memNick;
	}

	@Override
	public int UpdateMember(MemberVO vo, Login_infoVO lvo) {
		int result = 0;
		
		try {
			result = dao.UpdateMember(vo);
			if(result > 0) {
				result = dao.UpdateLogin_info(lvo);
			}
		} catch (SQLException e) {
			result = 0;
			e.printStackTrace();
		}
		return result;
	}

}

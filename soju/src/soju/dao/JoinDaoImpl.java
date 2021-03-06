package soju.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import soju.util.SqlMapClientFactory;
import soju.vo.Login_infoVO;
import soju.vo.MemberVO;

//SqlMapClient
//자신의 객체
public class JoinDaoImpl implements IJoinDao{

	private SqlMapClient smc;
	private static IJoinDao dao;
	
	private JoinDaoImpl(){
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static IJoinDao getJoinDao(){
		if(dao==null) dao = new JoinDaoImpl();
		return dao;
	}
	
	@Override
	public String checkId(String id) throws SQLException {
		return (String)smc.queryForObject("join.checkId", id);
	}

	@Override
	public String insertMember(MemberVO vo) throws SQLException {
		String memId = (String)smc.insert("join.insertMember", vo);
		return memId;
	}

	@Override
	public String checkNick(String nick) throws SQLException {
		return (String)smc.queryForObject("join.checkNick", nick);
	}

	@Override
	public int insertMember_info(Login_infoVO vo) throws SQLException {
		int result = 0;
		if(smc.insert("join.insertMember_info", vo)==null) {
			result = 1;
		}
		return result;
	}

	@Override
	public int UpdateMember(MemberVO vo) throws SQLException {
		return smc.update("join.updateMember",vo);
	}

	@Override
	public int UpdateLogin_info(Login_infoVO vo) throws SQLException {
		return smc.update("join.updateLogin_info",vo);
	}

}

package soju.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import soju.util.SqlMapClientFactory;
import soju.vo.Direct_QnaVO;

public class DiQnaDaoImpl implements IDiQnaDao {
	
	private SqlMapClient smc;
	private static IDiQnaDao dao;
	
	private DiQnaDaoImpl() {
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static IDiQnaDao getDiQnaDao() {
		if(dao==null) dao = new DiQnaDaoImpl();
		
		return dao;
	}

	//1:1 등록
	@Override
	public int insertDiQna(Direct_QnaVO vo) throws SQLException {
		return (int)smc.insert("manager.answerQ", vo);
	}

	//내가 쓴 문의 목록 
	@Override
	public List<Direct_QnaVO> myQnaList(String dqID) throws SQLException {
		return smc.queryForList("manager.getMyQna", dqID);
	}

	@Override
	public int myQnainsertReply(Direct_QnaVO vo) throws SQLException {
		return smc.update("manager.myQnaReplyInsert", vo);
	}

	@Override
	public List<Direct_QnaVO> myQnaReplyList(int bonum) throws SQLException {
		return smc.queryForList("manager.myQnaReplyList", bonum);
	}

	@Override
	public List<Direct_QnaVO> adminQnaList() throws SQLException {
		return smc.queryForList("manager.getNoAnswerList");
	}

	@Override
	public List<Direct_QnaVO> adminQnaList2() throws SQLException {
		return smc.queryForList("manager.getAnswerList");
	}


	
	
	
	
	


	

}

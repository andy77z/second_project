package soju.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.eclipse.jdt.internal.compiler.ast.ThrowStatement;

import com.ibatis.sqlmap.client.SqlMapClient;

import sun.security.jca.GetInstance;
import soju.util.SqlMapClientFactory;
import soju.vo.CalendarVO;


public class CalendarDaoImpl implements ICalendarDao{

	private SqlMapClient smc;
	private static CalendarDaoImpl dao;
	
	private CalendarDaoImpl() {
		smc = SqlMapClientFactory.getSqlMapClient();
	}
	
	public static CalendarDaoImpl getInstance() {
		if(dao==null) dao = new CalendarDaoImpl();
		return dao;
	}
	
	
	@Override
	public ArrayList<CalendarVO> calenList(int artNum) throws SQLException {
		return (ArrayList<CalendarVO>)smc.queryForList("calendar.calenList", artNum);
	}

	@Override
	public int insertSchedule(CalendarVO vo) throws SQLException {
		int cnt=0;
		String res = (String)smc.insert("calendar.insertSchedule",vo);
		if(res==null) {
			cnt=1;
		}
		return cnt;
	}

	@Override
	public ArrayList<HashMap<String, Object>> artistList(String agcId) throws SQLException {
		return (ArrayList<HashMap<String, Object>>) smc.queryForList("calendar.artistList",agcId);
	}

	@Override
	public ArrayList<HashMap<String, Object>> selectSchedule(HashMap<String, Object> map) throws SQLException {
		return (ArrayList<HashMap<String, Object>>)smc.queryForList("calendar.selectSchedule", map);
	}

	@Override
	public int deleteSchedule(int num) throws SQLException {
		
		return smc.delete("calendar.deleteSchedule", num);
	}
}

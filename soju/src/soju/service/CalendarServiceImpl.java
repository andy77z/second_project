package soju.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import sun.security.jca.GetInstance;
import soju.dao.CalendarDaoImpl;
import soju.dao.ICalendarDao;
import soju.vo.CalendarVO;


public class CalendarServiceImpl implements ICalendarService{

	private ICalendarDao dao;
	private static CalendarServiceImpl service;
	
	private CalendarServiceImpl() {
		dao = CalendarDaoImpl.getInstance();
	}
	
	public static CalendarServiceImpl getInstance() {
		if(service==null) service = new CalendarServiceImpl();
		return service;
	}
	
	@Override
	public ArrayList<CalendarVO> calenList(int artNum) {
		ArrayList<CalendarVO> list = null;
		try {
			list = dao.calenList(artNum);
		} catch (SQLException e) {
			list = null;
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int insertSchedule(CalendarVO vo) {
		int cnt=0;
		try {
			cnt = dao.insertSchedule(vo);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public ArrayList<HashMap<String, Object>> artistList(String agcId) {
		ArrayList<HashMap<String, Object>> list = null;
		try {
			list = dao.artistList(agcId);
		} catch (SQLException e) {
			list = null;
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public ArrayList<HashMap<String, Object>> selectSchedule(HashMap<String, Object> map) {
		ArrayList<HashMap<String, Object>> list = null;
		try {
			list = dao.selectSchedule(map);
		} catch (SQLException e) {
			list = null;
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int deleteSchedule(int num) {
		int result = 0;
		
		 try {
			result = dao.deleteSchedule(num);
		} catch (SQLException e) {
			result = 0;
			e.printStackTrace();
		} 
		
		return result;
	}

}

package soju.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import soju.vo.CalendarVO;

public interface ICalendarDao {
	public ArrayList<CalendarVO> calenList(int artNum) throws SQLException;
	public int insertSchedule(CalendarVO vo) throws SQLException;
	public ArrayList<HashMap<String, Object>> artistList(String agcId) throws SQLException;
	public ArrayList<HashMap<String, Object>> selectSchedule(HashMap<String, Object> map) throws SQLException;
	public int deleteSchedule(int num) throws SQLException;
}

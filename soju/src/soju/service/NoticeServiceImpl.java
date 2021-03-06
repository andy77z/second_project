package soju.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import soju.dao.INoticeDao;
import soju.dao.NoticeDaoImpl;
import soju.vo.NoticeVO;

public class NoticeServiceImpl implements INoticeService {

	private INoticeDao dao;
	private static INoticeService service;
	
	private  NoticeServiceImpl() {
		dao = NoticeDaoImpl.getNoticeDao();
	}
	
	public static INoticeService getNoticeService() {
		if(service == null) service = new NoticeServiceImpl();
		return service;
	}
	
	@Override
	public List<NoticeVO> selectByPage(Map<String, Integer> map) {
		List<NoticeVO> list = null;
		
		try {
			list = dao.selectByPage(map);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int totalCount() {
		int count = 0;
		
		try {
			count = dao.totalCount();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public Map<String, Integer> pageInfo(int page) {

		//전체 글 개수 가져오기
		int count = totalCount();
		
		//한페이지당 출력할 글 개수 구하기
		int perList = 8; 
		
		//한 화면에 출력할 페이지 수
		int perPage = 5;
		
		//전체 페이지 수 - 전체 글 개수 / perList
		int totalPage = (int)Math.ceil((double)count/perList);
		
		//list의 시작번호와 끝 번호
		int start = (page-1) * perList + 1;
		int end = start + perList -1;
		
		if(end > count) end = count;
		
		//시작페이지와 끝 페이지 
		int startPage = ((page-1) / perPage * perPage) + 1;
		int endPage = startPage + perPage - 1;
		
		if(endPage > totalPage) endPage = totalPage;
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		map.put("spage", startPage);
		map.put("epage", endPage);
		map.put("tpage", totalPage);
		
		return map;
	}

	@Override
	public int insertNotice(NoticeVO vo) {
		int num = 0;
		
		try {
			num = dao.insertNotice(vo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return num;
	}

	@Override
	public int updateNotice(NoticeVO vo) {
		int num = 0;
		
		try {
			num = dao.updateNotice(vo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return num;
		
	}

	@Override
	public int deleteNotice(int num) {
		int Nnum = 0;
		
		try {
			Nnum = dao.deleteNotice(num);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return Nnum;
				
	}

	

	

}

package soju.dao;

import java.sql.SQLException;

import soju.vo.AgencyVO;
import soju.vo.ArtistVO;
import soju.vo.Login_infoVO;
import soju.vo.ManagerVO;
import soju.vo.MemberVO;

public interface ILoginDao {
	public int checkMember(Login_infoVO vo) throws SQLException;
	public MemberVO findMember(MemberVO vo) throws SQLException;
	public int ResetPass(MemberVO vo) throws SQLException;
	public int ResetPass2(MemberVO vo) throws SQLException;
	
	public MemberVO getLoginInfo(MemberVO vo) throws SQLException;
	public ArtistVO getLoginInfo(ArtistVO vo) throws SQLException;
	public AgencyVO getLoginInfo(AgencyVO vo) throws SQLException;
	public ManagerVO getLoginInfo(ManagerVO vo) throws SQLException;
	
}

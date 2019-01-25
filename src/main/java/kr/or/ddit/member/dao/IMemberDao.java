package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.ZiptbVO;

public interface IMemberDao {
	MemberVO loginCheck(Map<String, String> params) throws Exception;
	int insertMemberInfo(MemberVO memberInfo) throws Exception;
	int idCheck(String mem_id) throws Exception;
	List<MemberVO> memberList(Map<String, String> params) throws Exception;
	MemberVO getMember(Map<String, String> param) throws Exception;
	int updateMember(MemberVO memberInfo) throws Exception;
	int deleteMember(String mem_id) throws Exception;
	List<ZiptbVO> zipList(Map<String, String> param) throws Exception;
	int totalCount(Map<String, String> params) throws Exception;
}

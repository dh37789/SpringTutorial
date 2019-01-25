package kr.or.ddit.member.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.ZiptbVO;

public interface IMemberService {
	public MemberVO loginCheck(Map<String, String> params) throws Exception;
	public int insertMemberInfo(MemberVO memberInfo) throws Exception;
	public int idCheck(String mem_id) throws Exception;
	public List<MemberVO> memberList(Map<String, String> params) throws Exception;
	public MemberVO getMember(Map<String, String> param) throws Exception;
	public int updateMember(MemberVO memberInfo) throws Exception;
	public int deleteMember(String mem_id) throws Exception;
	public List<ZiptbVO> zipList(Map<String, String> param) throws Exception;
	public int totalCount(Map<String, String> params) throws Exception;
}

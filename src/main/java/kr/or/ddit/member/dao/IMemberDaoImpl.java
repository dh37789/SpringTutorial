package kr.or.ddit.member.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.ZiptbVO;

import com.ibatis.sqlmap.client.SqlMapClient;
// <bean name="iMemberDaoImpl" 
// <bean name="memberDao" 
//		class="kr.or.ddit.member.dao.IMemberDaoImpl"/>
@Repository("memberDao")
public class IMemberDaoImpl implements IMemberDao{
	@Autowired
	private SqlMapClient client;
	
	@Override
	public MemberVO loginCheck(Map<String, String> params) throws Exception{
		return (MemberVO) client.queryForObject("member.getMember", params);
	}

	@Override
	public int insertMemberInfo(MemberVO memberInfo) throws Exception {
		int cnt = 0;
		Object obj = client.insert("member.insertMember", memberInfo);
		if (obj == null) {
			cnt = 1;
		}
		return cnt;
	}

	@Override
	public int idCheck(String mem_id) throws Exception {
		return (int) client.queryForObject("member.idCheck", mem_id);
	}

	@Override
	public List<MemberVO> memberList(Map<String, String> params) throws Exception {
		return client.queryForList("member.memberList", params);
	}

	@Override
	public MemberVO getMember(Map<String, String> param) throws Exception {
		return (MemberVO) client.queryForObject("member.getMember",param);
	}

	@Override
	public int updateMember(MemberVO memberInfo) throws Exception {
		return client.update("member.updateMember", memberInfo);
	}

	@Override
	public int deleteMember(String mem_id) throws Exception {
		return client.update("member.deleteMember", mem_id);
	}

	@Override
	public List<ZiptbVO> zipList(Map<String, String> param) throws Exception {
		return client.queryForList("ziptb.zipList", param);
	}

	@Override
	public int totalCount(Map<String, String> params) throws Exception {
		return (int) client.queryForObject("member.totalCount", params);
	}


}

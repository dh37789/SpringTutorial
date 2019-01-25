package kr.or.ddit.member.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.IMemberDaoImpl;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.ZiptbVO;
//<bean name="iMemberServiceImpl"
//()안에 값을 넣을 경우 <bean name="memberService"
//		class="kr.or.ddit.member.service.IMemberServiceImpl">

@Service("memberService")
public class IMemberServiceImpl implements IMemberService{
	@Autowired
	private IMemberDao dao;
	// readOnly=true 커밋과 롤백에서 자유로워진다 select는 오류가 안나기때문
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public MemberVO loginCheck(Map<String, String> params) throws Exception{
		return dao.loginCheck(params);
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@Override
	public int insertMemberInfo(MemberVO memberInfo) throws Exception{
		return dao.insertMemberInfo(memberInfo);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public int idCheck(String mem_id) throws Exception{
		return dao.idCheck(mem_id);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public List<MemberVO> memberList(Map<String, String> params) throws Exception{
		return dao.memberList(params);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public MemberVO getMember(Map<String, String> param) throws Exception{
		return dao.getMember(param);
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@Override
	public int updateMember(MemberVO memberInfo) throws Exception{
		return dao.updateMember(memberInfo);
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@Override
	public int deleteMember(String mem_id) throws Exception{
		return dao.deleteMember(mem_id);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public List<ZiptbVO> zipList(Map<String, String> param) throws Exception{
		return dao.zipList(param);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public int totalCount(Map<String, String> params) throws Exception{
		return dao.totalCount(params);
	}

}

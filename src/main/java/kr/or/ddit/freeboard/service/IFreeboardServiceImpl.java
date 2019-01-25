package kr.or.ddit.freeboard.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.freeboard.dao.IFreeboardDao;
import kr.or.ddit.utils.AttacheFileMapper;
import kr.or.ddit.utils.CLOBtoString;
import kr.or.ddit.vo.FileItemVO;
import kr.or.ddit.vo.FreeboardVO;
import oracle.sql.CLOB;

import org.apache.commons.fileupload.FileItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service("freeboardService")
public class IFreeboardServiceImpl implements IFreeboardService {
	@Autowired
	private IFreeboardDao dao;
	
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public List<FreeboardVO> boardList(Map<String, String> params) throws Exception {
		return dao.boardList(params);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public List<HashMap<String, Object>> getFreeboard(Map<String, String> params) throws Exception {
		List<HashMap<String, Object>> boardInfo = dao.getFreeboard(params);
			for (HashMap<String, Object> board : boardInfo) {
				String str = CLOBtoString.clobToString((CLOB) board.get("BO_CONTENT"));
				board.put("BO_CONTENT", str);
			}
		return boardInfo;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@Override
	public void addHit(String bo_no) throws Exception {
		dao.addHit(bo_no);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@Override
	public void insertBoard(FreeboardVO boardInfo) throws Exception {
		dao.insertBoard(boardInfo);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@Override
	public void deleteBoard(Map<String, String> params) throws Exception {
		dao.deleteBoard(params);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@Override
	public void updateBoard(FreeboardVO boardInfo) throws Exception {
		dao.updateBoard(boardInfo);
	}

	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public int totalCount(Map<String, String> params) throws Exception {
		return dao.totalCount(params);
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@Override
	public void insertBoardReply(FreeboardVO board) throws Exception {
		dao.insertBoardReply(board);
	}

}

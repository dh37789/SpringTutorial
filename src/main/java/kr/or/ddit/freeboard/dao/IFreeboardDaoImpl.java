package kr.or.ddit.freeboard.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.file.dao.IFileItemDao;
import kr.or.ddit.utils.AttacheFileMapper;
import kr.or.ddit.vo.FileItemVO;
import kr.or.ddit.vo.FreeboardVO;
// <bean id="freeboardDao"
// <bean id="IFreeboardDaoImpl"
@Repository("freeboardDao")
public class IFreeboardDaoImpl implements IFreeboardDao {
	@Autowired
	private SqlMapClient client;
	@Autowired
	private AttacheFileMapper mapper;
	@Autowired
	private IFileItemDao itemDao;
	
	@Override
	public List<FreeboardVO> boardList(Map<String, String> params)
			throws Exception {
		return client.queryForList("freeboard.boardList", params);
	}

	@Override
	public List<HashMap<String, Object>> getFreeboard(Map<String, String> params) throws Exception {
		return (List<HashMap<String, Object>>) client.queryForList("freeboard.getFreeboard", params);
	}

	@Override
	public void addHit(String bo_no) throws Exception {
		client.update("freeboard.addHit", bo_no);
	}

	@Override
	public void insertBoard(FreeboardVO boardInfo) throws Exception {
		try {
			client.startTransaction();
			String bo_no = (String) client.insert("freeboard.insertBoard", boardInfo);
			if (boardInfo.getFileitems() != null) {
				List<FileItemVO> items = mapper.mapping(boardInfo.getFileitems(), bo_no);
				itemDao.insertFileItem(items);
			}
			client.commitTransaction();
		}finally{
			client.endTransaction();
		}
	}

	@Override
	public void deleteBoard(Map<String, String> params) throws Exception {
		client.delete("freeboard.deleteBoard", params);
	}

	@Override
	public void updateBoard(FreeboardVO boardInfo) throws Exception {
		client.update("freeboard.updateBoard", boardInfo);
	}

	@Override
	public int totalCount(Map<String, String> params) throws Exception {
		return (int) client.queryForObject("freeboard.totalCount", params);
	}

	@Override
	public void insertBoardReply(FreeboardVO board) throws Exception {
		try {
			client.startTransaction();
			String bo_seq = board.getBo_seq();
			String bo_depth = board.getBo_depth();
			String bo_group = board.getBo_group();
			if ("0".equals(bo_seq)) {
				bo_seq = (String) client.queryForObject("freeboard.increaseSeq", board);
				board.setBo_seq(bo_seq);
			}else{
				client.update("freeboard.updateSeq",board);
				board.setBo_seq(String.valueOf((Integer.parseInt(bo_seq)+1)));
			}
			board.setBo_depth(String.valueOf((Integer.parseInt(bo_depth)+1)));
			client.insert("freeboard.insertFreeboardReply", board);
			client.commitTransaction();
		} finally {
			client.endTransaction();
		}

	}

}

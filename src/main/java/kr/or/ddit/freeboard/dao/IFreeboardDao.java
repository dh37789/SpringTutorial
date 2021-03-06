package kr.or.ddit.freeboard.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.FileItem;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.FreeboardVO;

public interface IFreeboardDao {
	/**
	 * BO_STATUS가 'y'인 전체 게시물을 가져온다. 
	 * @return 자유게시판의 게시물
	 * @throws SQLException
	 */
	List<FreeboardVO> boardList(Map<String, String> params) throws Exception;
	/**
	 * FreeboardVO를 가져온다.
	 * @param params FreeboardVO의 bo_no
	 * @return FreeboardVO
	 * @throws SQLException
	 */
	List<HashMap<String, Object>> getFreeboard(Map<String, String> params) throws Exception;
	/**
	 * 조회수를 증가한다.
	 * @param bo_no 증가할 게시글의 ID
	 * @throws SQLException
	 */
	void addHit(String bo_no) throws Exception;
	/**
	 * FreeboardVO insert
	 * @param board insert할 FreeboardVO
	 * @throws SQLException
	 */
	void insertBoard(FreeboardVO boardInfo) throws Exception;
	/**
	 * FreeboardVO의 status를 n으로 수정(삭제)
	 * @param params n으로 수정할 숫자
	 * @return 성공 1 실패 0
	 * @throws SQLException
	 */
	void deleteBoard(Map<String, String> params) throws Exception;
	/**
	 * FreeboardVO 게시글을 수정한다.
	 * @param boardInfo 수정할 Freeboard게시글
	 * @return 성공 1 실패 0
	 * @throws SQLException
	 */
	void updateBoard(FreeboardVO boardInfo) throws Exception;
	int totalCount(Map<String, String> params) throws Exception;
	public void insertBoardReply(FreeboardVO board) throws Exception;
}

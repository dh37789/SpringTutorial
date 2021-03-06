package kr.or.ddit.file.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.FileItemVO;

public interface IFileItemDao {
	public FileItemVO fileItemInfo(Map<String, String> params) throws Exception;
	public List<FileItemVO> fileItemList(Map<String, String> params) throws Exception;
	public void insertFileItem(List<FileItemVO> fileItemList) throws Exception;
}

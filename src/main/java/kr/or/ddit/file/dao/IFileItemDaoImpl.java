package kr.or.ddit.file.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.vo.FileItemVO;

@Repository("fileitemDao")
public class IFileItemDaoImpl implements IFileItemDao {
	@Autowired
	SqlMapClient client;
	
	@Override
	public FileItemVO fileItemInfo(Map<String, String> params)
			throws Exception {
		return (FileItemVO) client.queryForObject("fileitem.fileItemInfo", params);
	}

	@Override
	public List<FileItemVO> fileItemList(Map<String, String> params)
			throws Exception {
		return null;
	}

	@Override
	public void insertFileItem(List<FileItemVO> fileItemList)
			throws Exception {
		for (FileItemVO item : fileItemList) {
			client.insert("fileitem.insertFileitem", item);
		}

	}

}

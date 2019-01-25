package kr.or.ddit.file.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.file.dao.IFileItemDao;
import kr.or.ddit.vo.FileItemVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("fileItemService")
public class IFileItemServiceImpl implements IFileItemService{
	@Autowired
	IFileItemDao dao;
	
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public FileItemVO fileItemInfo(Map<String, String> params) throws Exception {
		return dao.fileItemInfo(params);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public List<FileItemVO> fileItemList(Map<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertFileItem(List<FileItemVO> fileItemList) throws Exception {
		// TODO Auto-generated method stub
		
	}

}

package kr.or.ddit.file.controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import kr.or.ddit.global.GlobalConstant;
import kr.or.ddit.utils.AttacheFileMapper;
import kr.or.ddit.vo.FileItemVO;
import kr.or.ddit.vo.MemberVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

// http://localhost/SpringToddler/file/fileUploadForm.do
// order 1 tilesViewResolver : file/fileUploadForm X
// order 2 beanNameViewResolver : file/fileUploadForm X
// order 3 internalViewResolver : /WEB-INF/views/file/fileUploadForm.jsp O 만약 없다면 404Error 
@Controller
@RequestMapping("/file/")
public class FileController {
	// 빈 선언되어있을경우 DI를 한다
	@Autowired
	private AttacheFileMapper fileMapper;
	
	@RequestMapping("fileUploadForm")
	public void fileUploadForm(){}
	
	@RequestMapping("fileUpload")
	public String fileUpload(MemberVO memberInfo,
			@RequestParam MultipartFile[] files){
		List<FileItemVO> item = this.fileMapper.mapping(files, "1");
		// redirect: 선언 할경우 viewresolver와 상관이 없어진다.
		String fileName = ((FileItemVO)item.get(0)).getFile_save_name();
		return "redirect:/file/fileUploadForm.do?fileName=" + fileName;
	}
	
	@RequestMapping("fileDownload")
	public ModelAndView fileDownload(String fileName, 
			ModelAndView andView){
		// order 1 tilesViewResolver : downloadView X
		// order 2 beanNameViewResolver : downloadView O
		
		andView.setViewName("downloadView");
		
		File downloadFile = new File(GlobalConstant.FILE_PATH, fileName);
		andView.addObject("downloadFile", downloadFile);
		return andView;
	}
}

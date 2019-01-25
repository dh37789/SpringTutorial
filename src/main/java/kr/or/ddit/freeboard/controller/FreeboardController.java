package kr.or.ddit.freeboard.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.or.ddit.file.service.IFileItemService;
import kr.or.ddit.freeboard.service.IFreeboardService;
import kr.or.ddit.global.GlobalConstant;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.utils.CryptoGenerator;
import kr.or.ddit.utils.RolePagingUtil;
import kr.or.ddit.vo.FileItemVO;
import kr.or.ddit.vo.FreeboardVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

// http://localhost/SpringToddler/freeboard/freeboardList.do
@Controller
@RequestMapping("/freeboard/")
public class FreeboardController {
	@Autowired
	IFreeboardService service;
	@Autowired
	private CryptoGenerator cryptoGen;
	@Autowired
	IFileItemService itemService;
	
	@RequestMapping("freeboardForm")
	public String freeboardForm(){
		return "user/freeboard/freeboardForm";
	}
	
	@RequestMapping("freeboardList")
	public ModelAndView freeboardList(String search_keycode, String search_keyword, String currentPage, 
			ModelAndView andView, Map<String, String> params,
			HttpServletRequest request, HttpSession session) throws Exception{
		if (currentPage == ""||currentPage == null) {
			currentPage = "1";
		}
		
		params.put("search_keycode", search_keycode);
		params.put("search_keyword", search_keyword);
		
		int totalCount = this.service.totalCount(params);
		RolePagingUtil paging = new RolePagingUtil(totalCount, Integer.parseInt(currentPage), request);
		
		int startCount = paging.getStartCount();
		int endCount = paging.getEndCount();
		String htmlPage = paging.getPageHtmls();
		
		params.put("startCount", String.valueOf(startCount));
		params.put("endCount", String.valueOf(endCount));
		List<FreeboardVO> boardList = this.service.boardList(params);
		
		andView.addObject("boardList", boardList);
		andView.addObject("htmlPage", htmlPage);
		session.setAttribute("paramKey", cryptoGen.getGeneratePairKey(session));
		andView.setViewName("user/freeboard/freeboardList");
		return andView;
		// return 할시에 tilesViewResolver가 먼저 리턴값을 받는다.
	}
	
	@RequestMapping("freeboardView")
	public ModelAndView freeboardView(String bo_no, String rnum, ModelAndView andView, Map<String, String> params) throws Exception{
		params.put("bo_no", bo_no);
		List<HashMap<String, Object>> boardInfo = this.service.getFreeboard(params);
		this.service.addHit(bo_no);
		andView.addObject("boardInfo", boardInfo);
		andView.addObject("rnum", rnum);
		andView.setViewName("user/freeboard/freeboardView");
		return andView;
	}
	@RequestMapping("freeboardFileDownload")
	public ModelAndView freeboardFileDownload(ModelAndView andView, String file_seq,
					Map<String, String> params) throws Exception{
		
		params.put("file_seq",file_seq);
		FileItemVO item = this.itemService.fileItemInfo(params);

		File downloadFile = new File(GlobalConstant.FILE_PATH, item.getFile_save_name());
		andView.setViewName("downloadView");
		andView.addObject("downloadFile", downloadFile);
		andView.addObject("fileName", item.getFile_name());
		return andView;
	}
	
	
	@RequestMapping("updateFreeboard")
	public String updateFreeboard(FreeboardVO boardInfo) throws Exception{
		this.service.updateBoard(boardInfo);
		
		return "forward:/freeboard/freeboardList.do";
	}
	
	@RequestMapping("deleteFreeboardInfo")
	public String deleteFreeboard(String bo_no, Map<String, String> params) throws Exception{
		params.put("bo_no", bo_no);
		this.service.deleteBoard(params);
		return "forward:/freeboard/freeboardList.do";
	}
	
	@RequestMapping("insertFreeboardInfo")
	public String insertFreeboard(FreeboardVO boardInfo) throws Exception{
		this.service.insertBoard(boardInfo);
		return "forward:/freeboard/freeboardList.do";
	}
	@RequestMapping("freeboardReplyForm")
	public ModelAndView freeboardReplyForm(ModelAndView andView, FreeboardVO boardInfo){
		andView.addObject("boardInfo", boardInfo);
		andView.setViewName("user/freeboard/freeboardReplyForm");
		return andView;
	}
	@RequestMapping("freeboardInsertReply")
	public String freeboardInsertReply(FreeboardVO boardInfo) throws Exception{
		this.service.insertBoardReply(boardInfo);
		return "forward:/freeboard/freeboardList.do";
	}
}

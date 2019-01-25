package kr.or.ddit.utils;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

public class RolePagingUtil {
	private int currentPage; 	 // 현재 페이지 번호
	private int totalCount;		 // 전체 게시글 갯수
	private int totalPage;		 // 전체 페이지 갯수
	private int blockCount = 10; // 페이지 별 출력될 게시글 갯수
	private int blockPage = 5;   // 페이지별 출력될 페이지네이션 메뉴 갯수
	private int startPage; 		 // 페이지별 출력될 페이지네이션 시작 페이지
	private int endPage; 		 // 페이지별 출력될 페이지네이션 끝 페이지
	private int startCount;	     // 페이지별 출력될 게시글 중 시작 게시글
	private int endCount; 		 // 페이지별 출력될 게시글 중 끝 게시글
	
	private String params="";		 // 리스트 출력 jsp에 현재 게시글 번호파라메터 외 파라메터들을 조합
	private StringBuffer pageHtmls = new StringBuffer(); // 페이지에 적용될 html 코드
	private HttpServletRequest request;

	public RolePagingUtil(int totalCount, int currentPage,
			HttpServletRequest request) {
		this.currentPage = currentPage;
		this.totalCount = totalCount;
		this.request = request;
		
		makePageHtml();
	}
	private void makePageHtml() {
//		 Math.ceil(10.5) 10보다 크면서 제일 작은 정수 반환
		this.totalPage = (int)Math.ceil(this.totalCount / (double) this.blockCount);
		if (this.totalPage == 0) {
			this.totalPage = 1;
		}
		
		// 페이지별 출력될 시작, 끝 게시글 번호(rnum)
		this.startCount = this.totalCount - (this.currentPage - 1) * this.blockCount;
		this.endCount = this.startCount - this.blockCount + 1;
		
		if (this.endCount < 0) {
			this.endCount = 1;
		}
		
		// 이전 |1|2|3|4|5| 다음
		this.startPage = ((this.currentPage -1) / this.blockPage * this.blockPage) + 1;
		endPage = this.startPage + this.blockPage - 1;
		
		if (this.endPage > this.totalPage) {
			this.endPage = this.totalPage;
		}
		
		String requestURI = request.getRequestURI();
		
		Enumeration<String> paramKeys = this.request.getParameterNames();
		while(paramKeys.hasMoreElements()){
			String key = paramKeys.nextElement();
			if ("currentPage".intern() != key.intern()) {
				String[] values = this.request.getParameterValues(key);
				for (String value : values) {
					// search_keycode=TOTAL&search_keyword=검색아
					if (key.equals("search_keycode")||key.equals("search_keyword")) {
						this.params += key + "=" + value + "&";
					}
				}
				
			}
		}
		
		// 이전|1|2|3|4|5|다음
		// 이전
		this.pageHtmls.append("<div class='text-center'>");
		this.pageHtmls.append("<ul class='pagination'>");
		
		// 이전|1|2|3|4|5|다음
		// 이전
		if ((this.currentPage -1) == 0) {
			this.pageHtmls.append("<li class='disabled'><a href='#'>&laquo;</a></li>");
		}else{
			this.pageHtmls.append("<li><a href='" + requestURI + "?" + params + "currentPage=" + (this.currentPage - 1) + "'>&laquo;</a></li>");
		}
		
		// |1|2|3|4|5|
		for (int i =this.startPage; i<=this.endPage; i++) {
			if (this.currentPage == i) {
				this.pageHtmls.append("<li class='active'><a href='#'>" + i + "</a></li>");
			}else{
				this.pageHtmls.append("<li><a href='" + requestURI + "?" + params + "currentPage=" + i + "'>" + i + "</a></li>");
			}
		}
		
		// 다음
		if (this.currentPage < this.totalPage) {
			this.pageHtmls.append("<li><a href='" + requestURI + "?" + params + "currentPage=" + (this.currentPage + 1) + "'>&raquo;</a></li>");
		}else{
			this.pageHtmls.append("<li class='disabled'><a href='#'>&raquo;</a></li>");
		}
		
		this.pageHtmls.append("</ul>");
		this.pageHtmls.append("</div>");
	}
	
	public int getStartCount() {
		return startCount;
	}
	public int getEndCount() {
		return endCount;
	}
	// toString을 하지 않기위해 String을 반환
	public String getPageHtmls() {
		return pageHtmls.toString();
	}
	
}

package kr.or.ddit.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

// @Component <bean name="fileDownloadViewClazz"
// @Component("downloadView") <bean name="downloadView"
//		 class="kr.or.ddit.utils.FileDownloadViewClazz" />
@Component("downloadView")
public class FileDownloadViewClazz extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		File downloadFile = (File) model.get("downloadFile");
		String fileName = (String) model.get("fileName");
		
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		response.setContentType("application/octet-stream");
		// 실제 다운로드파일의 사이즈를 줘야한다 (원래는)
		response.setContentLength((int)downloadFile.length());
		
		byte[] buffer = new byte[(int)downloadFile.length()];
		
		BufferedInputStream inputStream = 
				new BufferedInputStream(new FileInputStream(downloadFile));
		BufferedOutputStream outputStream = 
				new BufferedOutputStream(response.getOutputStream());
		
		int readCount = 0;
		while ((readCount = inputStream.read(buffer)) != -1) {
			outputStream.write(buffer);
		}
		
		outputStream.close();
		inputStream.close();
	}

}

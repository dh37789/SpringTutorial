package kr.or.ddit.utils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import kr.or.ddit.global.GlobalConstant;
import kr.or.ddit.vo.FileItemVO;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

// <bean name="attacheFileMapper"
//		 class="kr.or.ddit.utils.AttacheFileMapper" />
@Component
public class AttacheFileMapper {
	// static을 왜삭제하는지?
	public List<FileItemVO> mapping(MultipartFile[] items, String bo_no){
		List<FileItemVO> fileItemList = new ArrayList<FileItemVO>();
		if (items != null) {
			FileItemVO fileItemInfo;
			for (MultipartFile item : items){
				fileItemInfo = new FileItemVO();
				fileItemInfo.setFile_bo_no(bo_no);
				
				// item.getName() : d:\temp\a.png or a.png
				// a.png
				// 경로는 날리고 파일 이름만 반환한다.
				String fileName = FilenameUtils.getName(item.getOriginalFilename());
				fileItemInfo.setFile_name(fileName);
				
				String saveFileName = generateID(fileName);
				
				fileItemInfo.setFile_save_name(saveFileName);
				
				fileItemInfo.setFile_content_type(item.getContentType());
				fileItemInfo.setFile_size(String.valueOf(item.getSize()));
			
				fileItemList.add(fileItemInfo);
				saveFile(fileItemInfo.getFile_save_name(), item);
			}
		}
		return fileItemList;
	}
	private static void saveFile(String fileSaveName, MultipartFile item) {
		File saveFile = new File(GlobalConstant.FILE_PATH, fileSaveName);
		try {
			item.transferTo(saveFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static String generateID(String fileName){
		// 파일이 중복될경우 날라가므로 파일 이름을 수정한다. 이름과 확장자 사이에 임의의 글자를 추가
		// a and png
		// a를 반환한다.
		String baseName = FilenameUtils.getBaseName(fileName);
		// png를 반환한다.
		String extension = FilenameUtils.getExtension(fileName);
		
		// a4684684654846.png
		// UUID는 음수도 반환하기 때문에 -를 없앤다.
		String genID = UUID.randomUUID().toString().replace("-", "");
		
		return baseName + genID + "." + extension;
	}
}

package com.insta.comm.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.insta.comm.mapper.GalleryDto;
import com.insta.comm.mapper.GalleryPopupDto;
import com.insta.comm.mapper.IGalleryMapper;

@Service
public class GalleryService implements IGalleryService {
	@Value("${fileUploadPath}")
	String fileUploadPath;
	
	@Autowired
	private IGalleryMapper galleryMapper;
	
	// 갤러리 업로드
	
	@Transactional
 	@Override
	public int insertGallery(String board_num, String user_id, String post_title, MultipartFile fileList) {
 		// 값 설정
 		int result = 0;
 		int postResult = 0;
 		int fileResult = 0;
 		
 		/* 1. 글쓰기 */
		String post_num = galleryMapper.getMaxPostNo();
		postResult = galleryMapper.insertGallery(post_num, board_num, user_id, post_title);
			
 		/*2. 파일 업로드 시작*/
 		try { 			
 			System.out.println("fileUploadPath ::::::::::::::::" + fileUploadPath);
 			
 			// 파일 경로
 			String realPath = fileUploadPath + "upload\\image\\gallery\\";
 			
 			// 경로 상, 폴더가 없을 때 만듬
 			File dir = new File(realPath);
 			if(!dir.exists()) {
 				dir.mkdirs();
 			}
			// 파일의 실제 이름
			String originFileName = fileList.getOriginalFilename();
			
			// 파일이 있을때 실행
			if(!originFileName.equals("")) {
				//시간과 실제 파일 이름
				String newFileName = System.currentTimeMillis() + originFileName;
				//파일 저장 경로					  
				String savePath = realPath + newFileName;
				   
				// DB저장 경로
				String dbPath = "upload/image/gallery/";
				   
				// 파일 저장
				File o_file = new File(savePath);            	
				fileList.transferTo(o_file);		   
				//파일테이블에 경로 넣기
				fileResult = galleryMapper.insertFile(post_num, "F001", dbPath, newFileName, originFileName);
				//String file_num = postDao.getMaxFileNo(post_num).equals(null) ? "F0000001" : postDao.getMaxFileNo(post_num);
			}
 			/*파일 업로드 끝*/
 		}
 		// 파일 에러
 		catch (IOException io) {
			// TODO: handle exception
 			System.out.println(io.getMessage());
		}
 		catch (Exception e) {
 			System.out.println(e.getMessage());
 		}
 		
 		if(postResult==0||fileResult==0) {
 			result = 0;
 		}
 		else
 			result = 1;
 		
 		
 		return result;
 	}
 	
 	// 갤러리에서 보여질 파일
// 	public List<GalleryShowFile> galleryList(){
// 		List<GalleryShowFile> galleryList = galleryMapper.galleryList();
// 		return galleryList;
// 	}
 	public List<GalleryDto> galleryList(String user_id, String board_num){
 		List<GalleryDto> galleryList = galleryMapper.galleryList(user_id, board_num);
 		return galleryList;
 	}
 	
 	// 갤러리 팝업화면
 	public GalleryPopupDto detailViewPopup(String file_num) {
 		GalleryPopupDto detailView = galleryMapper.detailViewPopup(file_num);
 		return detailView;
 	}
 	
 	// 게시글번호 삭제
 	public int deletePost(String post_num) {
 		int result = 0;
 		
 		int deleteFiles = 0;
 		int updatelsuse = 0;
 		
 		try {
 			deleteFiles = galleryMapper.deleteFiles(post_num);
 			updatelsuse = galleryMapper.deletePost(post_num);
 		} catch(Exception e) {
 			System.out.println(e.getMessage());
 		}
 		
 		if(deleteFiles==0&&updatelsuse==0) {
 			result = 0;
 		}else
 			result = 1;
 		
 		return result;
 	}

}



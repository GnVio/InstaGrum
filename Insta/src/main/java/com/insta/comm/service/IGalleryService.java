package com.insta.comm.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.insta.comm.mapper.GalleryDto;
import com.insta.comm.mapper.GalleryPopupDto;

public interface IGalleryService {
	
// 갤러리(사진) 업로드
	public int insertGallery(String board_num, String user_id, String post_title, MultipartFile fileList);

// 갤러리(사진) 리스트
//	public List<GalleryShowFile> galleryList();
	public List<GalleryDto> galleryList(String user_id, String board_num);

// 팝업화면
	public GalleryPopupDto detailViewPopup(String post_num);
	
// 테이블 사용여부
	public int deletePost(String post_num);
}

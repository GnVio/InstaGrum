package com.insta.comm.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface IGalleryMapper {
	
// 갤러리 등록
	public int insertFile(String post_num, String file_num, String file_path, String save_file_name, String original_file_name);
		
// 갤러리(글) 작성
	public int insertGallery(String post_num, String board_num, String user_id, String post_title);

// 갤러리 리스트
//	public List<GalleryShowFile> galleryList();
	public List<GalleryDto> galleryList(String user_id, String board_num);

// 게시판 최대 글 번호 찾기
	public String getMaxPostNo();
	
// 파일 최대 번호 찾기
	public String getMaxFileNo();
	
// 갤러리 클릭시 팝업화면 
	public GalleryPopupDto detailViewPopup(String post_num);
	
// 갤러리(사진) 삭제
	public int deleteFiles(String post_num);
	public int deletePost(String post_num);
	
}



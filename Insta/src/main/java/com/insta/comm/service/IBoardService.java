package com.insta.comm.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.insta.comm.mapper.FileDto;
import com.insta.comm.mapper.PostDto;
import com.insta.comm.mapper.PostPopupDto;
import com.insta.comm.mapper.PostShowFile;

public interface IBoardService {
	/***
	 * 게시판 글 작성
	 * @param board_num 게시판 번호
	 * @param user_id 사용자 아이디
	 * @param post_title 글 제목
	 * @param post_content 글 내용
	 * @param fileList 파일
	 * @return 
	 */
	public int insertPost(String board_num, String user_id,String post_content, List<MultipartFile> fileList);
	
	/***
	 * 등록한 게시판 파일 리스트
	 * @return 
	 */
	public List<PostShowFile> boardList();
	
	/***
	 * 이미지 팝업 화면 서비스
	 * @param post_num 글 번호
	 * @return
	 */
	public PostPopupDto detailViewPopup(@Param("post_num") String post_num);
	
	/***
	 * 파일 리스트
	 * @return
	 */
	public List<PostDto> getFileList(@Param("post_num") String post_num);
	
	/***
	 * 파일 삭제,글 삭제
	 * @param post_num 글 번호
	 * @return
	 */
	public int deletePost(String post_num);	
	
	/***
	 * 글 수정
	 * @param post_num 글 번호
	 * @return
	 */
	public int updatePost(String post_num, String post_content, List<MultipartFile> fileList, List<FileDto> fileDtoList);
	
	/***
	 * 좋아요 동작
	 * @param isLikePost 좋아요 상태 확인
	 * @param post_num 글 번호
	 * @param user_id 사용자 아이디
	 * @return
	 */
	public int likeProc(int isLikePost, String post_num, String user_id);
	
	/***
	 * 좋아요 상태 확인
	 * @param post_num 글 번호
	 * @param user_id 사용자 아이디
	 * @return
	 */
	public int isLikePost(String post_num, String user_id);
	 
}

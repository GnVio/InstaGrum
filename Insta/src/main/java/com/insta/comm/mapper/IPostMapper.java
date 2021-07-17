package com.insta.comm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IPostMapper {
	
	/*** 
	 * 게시판 글 작성
	 * @param post_num 글 번호
	 * @param board_num 게시판 번호
	 * @param user_id 사용자 아이디
	 * @param post_title 글 제목
	 * @param post_content 글 내용
	 * @return
	 */	
	public int insertPost(@Param("post_num") String post_num, 
			@Param("board_num") String board_num, 
			@Param("user_id") String user_id, 
			@Param("post_content") String post_content);

	/***
	 * 게시판 파일 삽입
	 * @param file_num 파일 번호
	 * @param file_path 폴더 업로드 경로
	 * @param post_num 글 번호
	 * @param save_file_name 파일 경로
	 * @param original_file_name 이미지 원본 이름
	 * @return
	 */
	public int insertFile(@Param("file_num") String file_num, 
			@Param("file_path") String file_path, 
			@Param("post_num") String post_num,
			@Param("save_file_name") String save_file_name,
			@Param("original_file_name") String original_file_name);			
	
	/***
	 * 등록한 게시판 파일 리스트
	 * @return
	 */
	public List<PostShowFile> boardList();
	
	/***
	 * 게시판 최대 글 번호 찾기
	 * @return
	 */
	public String getMaxPostNo();
	
	/***
	 * 게시판 파일 최대 번호 찾기
	 * @param post_num 글 번호
	 * @return
	 */
	public String getMaxFileNo(@Param("post_num") String post_num);
	
	/***
	 * 게시판 글 클릭시 보여지는 팝업 화면
	 * @param post_num 글 번호
	 * @param file_path 파일 경로
	 * @param post_content 글 내용
	 * @return
	 */	
	public PostPopupDto detailViewPopup(@Param("post_num") String post_num);
	
	/***
	 * 파일 리스트
	 * @return
	 */
	public List<PostDto> getFileList(@Param("post_num") String post_num);
	
	/***
	 * 글 파일 삭제
	 * @param post_num
	 * @return
	 */
	public int deleteFiles(@Param("post_num") String post_num);
	
	/***
	 * 글 사용 여부
	 * @param post_num
	 * @return
	 */
	public int deletePost(@Param("post_num") String post_num);
	
	/***
	 * 글 수정
	 * @param post_num
	 * @return
	 */
	public int updatePost(@Param("post_num") String post_num,
									@Param("post_content") String post_content);	
	
	/***
	 * 좋아요 추가
	 * @param post_num
	 * @param user_id
	 * @return
	 */
	public int addLike(@Param("post_num") String post_num, @Param("user_id") String user_id);
	
	public int delLike(@Param("post_num") String post_num, @Param("user_id") String user_id);
	
	public int updatePostLikePlus(@Param("post_num") String post_num);
	
	public int updatePostLikeMinus(@Param("post_num") String post_num);
	
	public int isLikePost(@Param("post_num")String post_num, @Param("user_id")String user_id);
}

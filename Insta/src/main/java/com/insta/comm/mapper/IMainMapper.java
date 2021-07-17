package com.insta.comm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IMainMapper {
	/***
	 * 메인화면
	 * @param user_id 사용자 아이디
	 * @return
	 */
	public MainDto mainView(@Param("user_id") String user_id);
	/***
	 * 사용자 총 게시글 수
	 * @param user_id 사용자 아이디
	 * @return
	 */
	public int totlaBoardCnt(@Param("user_id") String user_id);
	
	 /***
	  * 사용자가 작성한 글 리스트
	  * @param user_id
	  * @return
	  */	
	 public List<PostShowFile> userBoardList(@Param("user_id") String user_id);
	 
	/***
	 * 작성된 댓글 리스트
	 * @return
	 */
	 public List<CommentDto> commentList(@Param("post_num") String post_num); 
	 /***
	  * 댓글 작성
	  * @param comment_num 댓글 번호
	  * @param post_num 게시글 번호
	  * @param user_id 사용자 아이디
	  * @param comment_content 냇글 내용
	  * @return
	  */
	 public int insertComment(@Param("comment_num") String comment_num,
			 							@Param("post_num") String post_num,
			 							@Param("user_id") String user_id,
			 							@Param("comment_content") String comment_content);
	 /***
	  * 글 한개에 있는 댓글 갯수 최대값
	  * @param post_num 게시글 번호
	  * @return
	  */
	 public String getMaxCommentNo(@Param("post_num") String post_num);
	 
	 public int deleteComment(@Param("post_num") String post_num,
			 							 @Param("comment_num")String comment_num);
	 
	 public int updateComment(@Param("post_num") String post_num,
			 							  @Param("comment_num")String comment_num,
			 							  @Param("comment_content") String comment_content);
	 
	 public CommentDto selectComment(@Param("post_num") String post_num, @Param("comment_num")String comment_num);
}
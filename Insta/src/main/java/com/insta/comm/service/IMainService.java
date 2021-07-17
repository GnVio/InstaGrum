package com.insta.comm.service;

import java.util.List;

import com.insta.comm.mapper.CommentDto;
import com.insta.comm.mapper.MainDto;
import com.insta.comm.mapper.PostShowFile;

public interface IMainService {
	/***
	 * 사용자 정보
	 * @param user_id 사용자 아이디
	 * @return
	 */
	public MainDto mainView(String user_id);
	
	/***
	 * 사용자 총 게시글 수
	 * @param user_id 사용자 아이디
	 * @return
	 */
	public int totlaBoardCnt(String user_id);
	
	/***
	 *사용자가 작성한 글 리스트 
	 * @return
	 */
	public List<PostShowFile> userBoardList(String user_id);
	
	/***
	 * 댓글 목록
	 * @param post_num 글 번호
	 * @return
	 */
	public List<CommentDto> CommentList(String post_num);
	
	/***
	 * 댓글 등록
	 * @param post_num 글 번호
	 * @param user_id 사용자 아이디
	 * @param comment_content 댓글 내용
	 * @return
	 */
	public int commentInsert(String post_num, String user_id, String comment_content);
	
	/***
	 * 최근에 등록한 댓글 번호
	 * @param post_num 글 번호
	 * @return
	 */
	public String getMaxCommentNo(String post_num);
	
	/***
	 * 댓글 삭제
	 * @param post_num 글 번호
	 * @param comment_num 댓글 번호
	 * @return
	 */
	public int deleteComment(String post_num, String comment_num);	
	
	/***
	 * 댓글 수정
	 * @param post_num 글 번호
	 * @param comment_num 댓글 번호
	 * @return
	 */
	public int updateComment(String post_num, String comment_num, String comment_content);
	
	public CommentDto selectComment(String post_num, String comment_num);
}
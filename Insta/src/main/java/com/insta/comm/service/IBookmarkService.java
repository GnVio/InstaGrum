package com.insta.comm.service;

import java.util.List;

import com.insta.comm.mapper.PostDto;

public interface IBookmarkService {
	
	/***
	 *사용자가 작성한 글 리스트 
	 * @return
	 */
	public List<PostDto> userBookList(String user_id);
	
	public int isBookMarkPost(String post_num, String user_id);
	
	public int bookMarkProc(int isBookMarkPost, String post_num, String user_id);
}

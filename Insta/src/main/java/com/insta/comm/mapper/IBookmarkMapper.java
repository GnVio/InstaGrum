package com.insta.comm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IBookmarkMapper {
	/***
	 *사용자가 작성한 글 리스트 
	 * @return
	 */
	public List<PostDto> userBookList(@Param("user_id") String user_id);
	
	public int addBookMark(@Param("bookmark_num")String bookmark_num,@Param("post_num") String post_num,@Param("user_id") String user_id);
	
	public String getBookmarkNum();
	
	public int isBookMarkPost(@Param("post_num")String post_num, @Param("user_id")String user_id);
	
	public int delBookMark(@Param("post_num") String post_num, @Param("user_id") String user_id);
}

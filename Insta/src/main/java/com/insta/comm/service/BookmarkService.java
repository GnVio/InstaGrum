package com.insta.comm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.insta.comm.mapper.IBookmarkMapper;
import com.insta.comm.mapper.PostDto;

@Service
public class BookmarkService implements IBookmarkService {
	
	
	@Autowired
	private IBookmarkMapper bookMapper;	
	
	public List<PostDto> userBookList(String user_id){
		
		List<PostDto> userBookList = bookMapper.userBookList(user_id);
		return userBookList;
	}
	
	public int isBookMarkPost(String post_num, String user_id) {
		return bookMapper.isBookMarkPost(post_num, user_id);
	}
	
	public int bookMarkProc(int isBookMarkPost, String post_num, String user_id) {
		int result = 0;
		int calResult = 0;
		
		if(isBookMarkPost > 0) {
			result = bookMapper.delBookMark(post_num, user_id);
		}
		else {
			String bookmark_num = bookMapper.getBookmarkNum();
			
			result = bookMapper.addBookMark(bookmark_num,post_num, user_id);
		}
		
		if(result==0&&calResult==0) {
			result = 0;
		}else
			result = 1;
		
		return result;
	}
}

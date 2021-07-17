package com.insta.comm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.insta.comm.mapper.CommentDto;
import com.insta.comm.mapper.IMainMapper;
import com.insta.comm.mapper.IPostMapper;
import com.insta.comm.mapper.MainDto;
import com.insta.comm.mapper.PostShowFile;

@Service
public class MainService implements IMainService {
	@Autowired
	private IMainMapper mainMapper;	
	
	public MainDto mainView(String usre_id) {
		
		return mainMapper.mainView(usre_id);
	}
	
	public int totlaBoardCnt(String user_id) {
		
		return mainMapper.totlaBoardCnt(user_id);
	}	  
	
	public List<PostShowFile> userBoardList(String user_id){
		List<PostShowFile> userBoardList = mainMapper.userBoardList(user_id);
		return userBoardList;
	}
	
	public List<CommentDto> CommentList(String post_num){
		
		List<CommentDto> commentList = mainMapper.commentList(post_num); 
		return commentList;		  
	}
	
	public String getMaxCommentNo(String post_num) {
		
		return mainMapper.getMaxCommentNo(post_num);
	}
	
	public int commentInsert(String post_num, String user_id, String comment_content) {

		  int commentResult = 0;
		  
		  try { 
			  String comment_num = mainMapper.getMaxCommentNo(post_num);
		  
			  commentResult = mainMapper.insertComment(comment_num, post_num, user_id, comment_content); 
		  } catch (Exception e) { 
			  System.out.println(e.getMessage());
		  } 
		  return commentResult;
		
	}
	
	public int deleteComment(String post_num,String comment_num) {
		int deleteComment = 0;
				
		try {
			deleteComment = mainMapper.deleteComment(post_num,comment_num) ;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return deleteComment;
	}
	
	public int updateComment(String post_num,String comment_num,String comment_content) {
		int updateComment = 0;
		
		try {
			updateComment = mainMapper.updateComment(post_num, comment_num, comment_content);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return updateComment;
	}
	
	public CommentDto selectComment(String post_num, String comment_num) {
		CommentDto dto = mainMapper.selectComment(post_num, comment_num);
		return dto;
	}
}

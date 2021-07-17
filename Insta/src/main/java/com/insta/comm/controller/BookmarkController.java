package com.insta.comm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.insta.comm.mapper.MainDto;
import com.insta.comm.mapper.MemberDto;
import com.insta.comm.mapper.PostDto;
import com.insta.comm.mapper.PostShowFile;
import com.insta.comm.service.IBookmarkService;
import com.insta.comm.service.IMainService;
import com.insta.comm.service.IMemberService;

@Controller
public class BookmarkController {

	@Autowired
	IMemberService memService;
	
	@Autowired
	IMainService mService;	
	
	@Autowired
	IBookmarkService bookService;
	
	/***
	 * 즐겨찾기
	 * @param session
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/bookmark")
	public String moveBookmark(HttpSession session, Model model,HttpServletRequest req) {
		
//		MemberDto sessionVo = (MemberDto)session.getAttribute("member");	
//		String user_id = sessionVo.getUser_id();
		
		
		//HttpSession session = req.getSession();
//mDto.getUserId();		
//		mService.mainView(user_id);
//		mService.cnt(user_id);
		
		MemberDto mDto =  (MemberDto)session.getAttribute("member");
		String user_id = mDto.getUser_id();	
		
		List<PostDto> booklist = bookService.userBookList(user_id);
		booklist.size();
		System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::"+booklist);
				
		model.addAttribute("userBookList", booklist);
		
		
		
//		model.addAttribute("commentList", mService.CommentList(post_num));
		
		return "/bookmark/bookmark";
	}
	
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/addBookMark") // Json타입 기본 ↓ 공식 public Map<String,
	 * Object> addBookMark(@RequestBody Map<String, Object> map) { //
	 * System.out.println("map.get(user_id).toString()" + //
	 * map.get("user_id").toString());
	 * 
	 * 
	 * String user_id = map.get("user_id").toString(); String friend_id =
	 * map.get("friend_id").toString();
	 * System.out.println("user_id::::::::::::::::::::::::::::::::::"+user_id);
	 * System.out.println("friend_id::::::::::::::::::::::::::::::::::"+friend_id);
	 * 
	 * int isResult = memService.addFriend(friend_id, user_id);
	 * System.out.println("isResult:::::::::::::::::::" + isResult);
	 * 
	 * Map<String, Object> resultMap = new HashMap<String, Object>();
	 * resultMap.put("isResult", isResult); return resultMap; }
	 */
	

	/***
	 * 즐겨찾기 상태 확인
	 * @param map
	 * @param req
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/bookMarkProc")
	public String bookMarkProc(@RequestBody Map<String, String> map,HttpServletRequest req) {
		/* 즐겨찾기한 상태가 0인지 1인지 확인 */
		String bookMarkTgle = map.get("bookMarkTgle");
		String post_num = map.get("post_num");
		HttpSession session = req.getSession();
		MemberDto mDto =  (MemberDto)session.getAttribute("member");
		String user_id = mDto.getUser_id();
		
		/* 즐겨찾기 상태 확인 서비스 */
		int re = bookService.bookMarkProc(Integer.parseInt(bookMarkTgle), post_num, user_id);
		String bookMarkReturn = "";
		
		if(re == 0) {
			bookMarkReturn = "{\"result\":\"fail\"}";
		} else {
			bookMarkReturn = "{\"result\":\"success\"}";
		}
		
		return bookMarkReturn;
	}
}

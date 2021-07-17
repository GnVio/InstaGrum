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

import com.insta.comm.service.IBoardService;
import com.insta.comm.mapper.CommentDto;
import com.insta.comm.mapper.MainDto;
import com.insta.comm.mapper.MemberDto;
import com.insta.comm.service.IMainService;
import com.insta.comm.service.IMemberService;

@Controller
public class MainController {
	
	@Autowired
	IMainService mService;
	@Autowired
	IBoardService bService;
	
	@Autowired
	IMemberService memService;
	
	   @RequestMapping("/")
	   public String root(HttpSession session) throws Exception {
		   
		   MemberDto sessionVo = (MemberDto)session.getAttribute("member");
		   
			if(sessionVo == null){
				
				return "/member/login";
				
			}else {
						
				return "redirect:/mypage";
			}
	   }
	
	
	   @RequestMapping("/mypage")
		public String mainView(HttpServletRequest req, HttpSession session, Model model){
			session = req.getSession();
			if(req.getParameter("user_id") != null) {
				String user_id = req.getParameter("user_id");
				
				MemberDto vo = new MemberDto();
				vo.setUser_id(user_id);
				
				// 로그인xml에서 아래 코드를 추가하고 사용하였으나 pw없이 로그인되는 현상 발생하여 mapper.get을 추가했음
				/*
				 * <if test='user_pw != null and !"".equals(user_pw)'> and user_pw = #{user_pw}
				 * </if> MemberDto memDto = memService.login(vo);
				 */
				
				// 친구정보 가져오기
				MemberDto memDto = memService.get(vo);
				
				//친구아이디리스트 들고오기
				//친구아이디리스트와 정보 비교해서 트루 폴스 반환
				//반환한 값으로 친구추가 또는 친구 보여짐
				MemberDto sessionVo = (MemberDto)session.getAttribute("member");
				List<MemberDto> friendIdList = memService.friendIdList(sessionVo.getUser_id());
				Boolean is_friend = false;
				for (MemberDto memberDto : friendIdList) {
					if(memberDto.getFriend_id().equals(memDto.getUser_id())) {
						is_friend = true;
						break;
					}
				}
				MainDto resultDto = mService.mainView(user_id);		
				int resultCnt = mService.totlaBoardCnt(user_id);	
				int resultFriendCnt = memService.countFriend(user_id);
				
				model.addAttribute("friend_totalCnt", resultFriendCnt);
				model.addAttribute("user_info",resultDto);
				model.addAttribute("totalCnt",resultCnt);		
				model.addAttribute("userBoardList", mService.userBoardList(user_id));
				
				model.addAttribute("is_friend",is_friend);
				
				model.addAttribute("user_id1", memDto.getUser_id());
				model.addAttribute("user_intro1", memDto.getUser_introduce());
				model.addAttribute("user_pho1", memDto.getUser_pho_path());	
			}
			else{
				MemberDto sessionVo = (MemberDto)session.getAttribute("member");
				
				String user_id = sessionVo.getUser_id();
				String user_name = sessionVo.getUser_name();
				String user_pho = sessionVo.getUser_pho_path();
				String user_intro = sessionVo.getUser_introduce();
				
				
				model.addAttribute("user_id1", user_id);
				model.addAttribute("user_intro1", user_intro);
				model.addAttribute("user_pho1", user_pho);
				model.addAttribute("user_name1", user_name);
				
				
				MainDto resultDto = mService.mainView(user_id);		
				int resultCnt = mService.totlaBoardCnt(user_id);	
				int resultFriendCnt = memService.countFriend(user_id);
				
				model.addAttribute("friend_totalCnt", resultFriendCnt);
				model.addAttribute("user_info",resultDto);
				model.addAttribute("totalCnt",resultCnt);		
				model.addAttribute("userBoardList", mService.userBoardList(user_id));
			}

			return "/mypage/mypage";
		}
	
	
	@ResponseBody
	@RequestMapping("/commentinsert")
	public  Map<String, Object> insertComment(@RequestBody Map<String, Object> reqMap,HttpServletRequest req) {
		String post_num = reqMap.get("post_num").toString();
		
		HttpSession session = req.getSession();
		MemberDto mDto =  (MemberDto)session.getAttribute("member");
		String user_id = mDto.getUser_id();
		
		String comment_content = reqMap.get("content").toString();
		
		mService.commentInsert(post_num, user_id, comment_content);		
		
		List<CommentDto> commentList =  mService.CommentList(post_num);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("comments", commentList);
		
		return resultMap;
	}
		  
	@ResponseBody		  
	@RequestMapping("/deleteComment") 
	public Map<String, Object> deleteComment(@RequestBody Map<String, Object> reqMap){ 
		String post_num = reqMap.get("post_num").toString();
		
		String comment_num = reqMap.get("hdn_commentNum").toString();
		mService.deleteComment(post_num,comment_num);
		
		List<CommentDto> commentList =  mService.CommentList(post_num);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("comments", commentList);
		
		return resultMap;
	}
	
	@ResponseBody		  
	@RequestMapping("/updateComment") 
	public String updateComment(@RequestBody Map<String, Object> reqMap){ 
		String strResult = "{\"result\" : \"fail\"}";
		String post_num = reqMap.get("post_num").toString();
		
		String comment_num = reqMap.get("comment_num").toString();
		String comment_content = reqMap.get("comment_content").toString();
		int rs = mService.updateComment(post_num,comment_num,comment_content);
		
		if(rs>0)
			strResult = "{\"result\" : \"success\"}";
		else
			strResult = "{\"result\" : \"fail\"}";
		
		return strResult;
	}
	
	@ResponseBody
	@RequestMapping("/detailComment")
	public CommentDto selectComment(@RequestBody Map<String, Object> map) {
		String post_num = map.get("post_num").toString();
		String comment_num = map.get("comment_num").toString();
		
		CommentDto comDto = mService.selectComment(post_num, comment_num);
		 
		return comDto;
	}
}
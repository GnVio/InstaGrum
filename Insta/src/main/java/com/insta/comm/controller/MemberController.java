package com.insta.comm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.insta.comm.mapper.MainDto;
import com.insta.comm.mapper.MemberDto;
import com.insta.comm.service.IMainService;
import com.insta.comm.service.IMemberService;

@Controller
public class MemberController {
	
	@Autowired
	IMemberService memService;
	@Autowired
	IMainService mService;
	
	
	// signup(회원가입) 화면으로 전환
	@RequestMapping("/signup")
	public String pageMoveWrite() {

		return "/member/signup";
	}

	// login(로그인) 화면으로 전환
	@RequestMapping("/login")
	public String pageMoveLogin(HttpServletRequest req, HttpSession session) {
		//MemberDto sessionVo = (MemberDto)session.getAttribute("member");
		
		//이미 생성된 세션이 있을때 그 세션을 반환하고 세션이 없을때 null를 반환한다
		MemberDto sessionVo = (MemberDto)session.getAttribute("member");
	
		
		System.out.println("session:::::::::::::::::::::::::::::::::::::::::" + sessionVo);

		
		if(sessionVo == null){
			
			return "/member/login";
			
		}else {
					
			return "redirect:/mypage";
		}
	}

	// login(로그인) login logic
	@RequestMapping(value = "/startlogin", method = RequestMethod.POST)
	public String login(MemberDto vo, HttpServletRequest req, RedirectAttributes rttr) throws Exception {

		HttpSession session = req.getSession();
		MemberDto login = memService.login(vo);
		
		if (login == null) {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
			return "redirect:/login";
		} 
		else {
			session.setAttribute("member", login);
		}	
		return "redirect:/mypage";
	}

	// 이름 또는 아이디로 검색
	@ResponseBody
	@RequestMapping(value = "/search") // Json타입 기본 ↓ 공식
	public Map<String, Object> search(@RequestBody Map<String, Object> map, Model model) {
		System.out.println("search_value :::::::::::::::::::: " + map.get("search_value").toString());

		String user_id = map.get("search_value").toString();
		List<MemberDto> isResult = memService.search(user_id);
		// System.out.println("isResult:::::::::::::::::::" + isResult);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("isResult", isResult);
		return resultMap;
	}

	// logout(로그아웃)
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {

		session.invalidate();

		return "redirect:/login";
	}

	// 정보수정 이동
	@RequestMapping(value = "/memberUpdateView", method = RequestMethod.GET)
	public String registerUpdateView(HttpServletRequest req,Model model) throws Exception {
		
		
		HttpSession session = req.getSession();
		MemberDto sessionVo = (MemberDto)session.getAttribute("member");
		
		String gender = sessionVo.getUser_gender();
		
		if(gender.equals("M")) {
			gender = "남자";
			model.addAttribute("gender", gender);
		}
		
		else if(gender.equals("F")) {
			gender = "여자";
			model.addAttribute("gender", gender);
		}
		return "/member/memberUpdateView";
	}
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.POST)
	public String registerUpdate(HttpServletRequest req, MultipartHttpServletRequest mtfRequest, HttpSession session,
			Model model) throws InterruptedException {
		
		MemberDto sessionVo = (MemberDto)session.getAttribute("member");
		
		/* 가져온 파일들을 배열로 저장 */
		List<MultipartFile> fileList = mtfRequest.getFiles("user_pho_path");
		String user_id = req.getParameter("user_id1");
		String password = req.getParameter("user_pw1");
		String name = req.getParameter("user_name");
		String email = req.getParameter("user_email1");
		String introduce = req.getParameter("user_introduce");
		String tell = req.getParameter("user_tel");
		String user_pho_path2 = req.getParameter("user_pho_path2");

		memService.memberUpdate(user_id, password, name, tell, introduce, fileList, email, user_pho_path2);
		
		MainDto resultDto = mService.mainView(user_id);	
		System.out.println("resultDto:::::::::::::::::::::::::::::::::::::::::::::"+resultDto);
		System.out.println("resultDto:::::::::::::::::::::::::::::::::::::::::::::"+resultDto);
		System.out.println("resultDto:::::::::::::::::::::::::::::::::::::::::::::"+resultDto);
		System.out.println("resultDto:::::::::::::::::::::::::::::::::::::::::::::"+resultDto);
		System.out.println("Thank you for Sungjun:::::::::::::::::::::::::::::::::::::::::::::"+resultDto);

		//기본이미지값 받아오기
		//sessionVo.setUser_pho_path(user_pho_path2);
		sessionVo.setUser_name(resultDto.getUser_name());
		sessionVo.setUser_tel(tell);
		sessionVo.setUser_introduce(introduce);
		sessionVo.setUser_pho_path(resultDto.getUser_pho_path());
		
  		TimeUnit.SECONDS.sleep(3);
		return "redirect:/";
	}

	// findid로 페이지 이동
	@RequestMapping(value = "/findid")
	public String movefindId() throws Exception {

		return "/member/findid";
	}

	// findid_confirm로 페이지 이동
	@RequestMapping(value = "/findid_confirm")
	public String movefindid_confirm(HttpServletRequest req, Model model) throws Exception {
		
		model.addAttribute("find_id", req.getParameter("user_id"));
		return "/member/findid_confirm";
	}

	// 아이디 찾기 로직
	@ResponseBody
	@RequestMapping("/finddoit")
	public Map<String, Object> findID(@RequestBody Map<String, Object> map) {
		String user_email = map.get("user_email").toString();
		String user_id = memService.findId(user_email) == null ? "notExist" : memService.findId(user_email);

		// System.out.println("user_id ::::::::::::::" + user_id);
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("user_id", user_id);

		return dataMap;
	}

	// findpw로 페이지 이동
	@RequestMapping(value = "/findpw")
	public String movefindpw() throws Exception {

		return "/member/findpw";
	}
	
	// 패스워드 찾기
	@RequestMapping(value = "/findpw_confirm")
	public String movefindpw_confirm(HttpServletRequest req, Model model) throws Exception {

		model.addAttribute("find_pw", req.getParameter("user_pw"));
		
		return "/member/findpw_confirm";
	}

	// 비밀번호 찾기 로직
	@ResponseBody
	@RequestMapping("/findpwdoit")
	public Map<String, Object> findPw(@RequestBody Map<String, Object> map) {
		String user_email = map.get("user_email").toString();
		String user_id = map.get("user_id").toString();

		Map<String, Object> result = memService.findPw(user_id, user_email);

		// System.out.println("user_id ::::::::::::::" + user_id);
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("result", result);

		return dataMap;
	}

	// 회원정보 입력
	@RequestMapping("/write")
	public String requestupload2(HttpServletRequest req, MultipartHttpServletRequest mtfRequest) {

		/* 가져온 파일들을 배열로 저장 */
		List<MultipartFile> fileList = mtfRequest.getFiles("user_pho_path");
		String user_id = req.getParameter("id");
		String password = req.getParameter("pass");
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String gender = req.getParameter("gender");
		String introduce = req.getParameter("intro");
		String tell = req.getParameter("tell");
		String user_pho2 = req.getParameter("user_pho2");
		

		memService.writeService(user_id, password, name, email, gender, introduce, tell, fileList,user_pho2);

		return "/member/login";
	}

	// 아이디 중복체크
	@ResponseBody
	@RequestMapping(value = "/checkId") // Json타입 기본 ↓ 공식
	public Map<String, Object> idCheck(@RequestBody Map<String, Object> map) {
		// System.out.println("map.get(user_id).toString()" +
		// map.get("user_id").toString());

		String user_id = map.get("user_id").toString();
		int isResult = memService.checkIdService(user_id);
		// System.out.println("isResult:::::::::::::::::::" + isResult);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("isResult", isResult);
		return resultMap;
	}

	// 이메일 중복체크
	@ResponseBody
	@RequestMapping(value = "/checkEmail") // Json타입 기본 ↓ 공식
	public Map<String, Object> emailCheck(@RequestBody Map<String, Object> map) {
		// System.out.println("map.get(user_id).toString()" +
		// map.get("user_id").toString());

		String user_email = map.get("user_email").toString();
		int isResult = memService.checkEmailService(user_email);
		// System.out.println("isResult:::::::::::::::::::" + isResult);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("isResult", isResult);
		return resultMap;
	}
	
	
	// 친구 리스트 
	@RequestMapping("/friend")
	public String moveFriendlist(HttpServletRequest req,HttpSession session,Model model){
		
		session = req.getSession();
		MemberDto sessionVo = (MemberDto)session.getAttribute("member");
		
		String user_id = sessionVo.getUser_id();
		
		System.out.println("FriendsList::::::::::::::::::::::::::::::::::::::::::" + memService.friendList(user_id));
		
		model.addAttribute("result", memService.friendList(user_id));

		return "/friend/friend";
	}
	
	// 친구추가
	@ResponseBody
	@RequestMapping(value = "/addFriend") // Json타입 기본 ↓ 공식
	public Map<String, Object> addFriend(@RequestBody Map<String, Object> map) {
		// System.out.println("map.get(user_id).toString()" +
		// map.get("user_id").toString());

		String user_id = map.get("user_id").toString();
		String friend_id = map.get("friend_id").toString();
		System.out.println("user_id::::::::::::::::::::::::::::::::::"+user_id);
		System.out.println("friend_id::::::::::::::::::::::::::::::::::"+friend_id);
		
		int isResult = memService.addFriend(friend_id, user_id);
		System.out.println("isResult:::::::::::::::::::" + isResult);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("isResult", isResult);
		return resultMap;
	}
	
	// 친구삭제
	@ResponseBody
	@RequestMapping(value = "/deleteFriend") // Json타입 기본 ↓ 공식
	public Map<String, Object> deleteFriend(@RequestBody Map<String, Object> map) {
		String friend_id = map.get("friend_id").toString();
		System.out.println("friend_id::::::::::::::::::::::::::::::::::"+friend_id);
		
		int isResult = memService.deleteFriend(friend_id);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("isResult", isResult);
		return resultMap;
	}
	
	

}

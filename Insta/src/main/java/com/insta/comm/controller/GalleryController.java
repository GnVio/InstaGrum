package com.insta.comm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.insta.comm.mapper.GalleryDto;
import com.insta.comm.mapper.GalleryPopupDto;
import com.insta.comm.mapper.MemberDto;
import com.insta.comm.service.IGalleryService;
import com.mysql.cj.log.Log;

@Controller
public class GalleryController {
	
	@Autowired
	IGalleryService galleryService;

	@RequestMapping("/gal_writeForm")
	public String gal_writeForm() throws Exception {
		return "gallery/gal_write";
	}

	@RequestMapping(value = "/gal_write")
	public Map<String, Object> gal_write(MultipartHttpServletRequest multi,HttpSession session) {
		
		MemberDto sessionVo = (MemberDto)session.getAttribute("member");
		String se_user_id = sessionVo.getUser_id(); 
		
		String board_num = "B0000002";//媛ㅻ윭由ъ뿉�꽌 湲��벐湲�		
		String user_id = se_user_id;//session�뿉�꽌 諛쏆븘�삤湲�
		
		MultipartFile fileList = multi.getFile("input_file");	
		
		return null;
	}	
	
	// 새로 수정해야하는 부분 ***********************************************
	
		@ResponseBody
		@RequestMapping("/gal_up")
		// 파일 삽입
		public String boardupload(MultipartHttpServletRequest multi, HttpServletRequest req,HttpSession session) {
			
			MemberDto sessionVo = (MemberDto)session.getAttribute("member");
			
			String board_num = "B0000002";//갤러리에서 글쓰기		
			String user_id = sessionVo.getUser_id();//session에서 받아오기
			String post_title = req.getParameter("input_file");//글 제목
			
			MultipartFile fileList = multi.getFile("input_file");	
			
			String result = "fail";
			int resultint = galleryService.insertGallery(board_num, user_id, post_title, fileList);
			
			if(resultint == 0) {
				result = "fail";
			} else {
				result = "success";
			}
			
			return result;
		}
		
	// **************************************************************	
	
	@RequestMapping("/list")
	public String GalleryList(Model model,HttpSession session) {
		MemberDto sessionVo = (MemberDto)session.getAttribute("member");
		String se_user_id = sessionVo.getUser_id(); 
		
		String user_id = se_user_id;
		String board_num = "B0000002";
		
		model.addAttribute("galleryList", galleryService.galleryList(user_id, board_num));
		model.addAttribute("galleryCnt", galleryService.galleryList(user_id, board_num).size());
		return "gallery/gallery_list";
	}
	
	@ResponseBody
	@RequestMapping("/detailViewPopup2")
	public GalleryPopupDto detailViewPopup(@RequestBody Map<String, Object> map) {
		String post_num = map.get("post_num").toString();
		GalleryPopupDto result = galleryService.detailViewPopup(post_num);
		System.out.println("result::::::::::::::::::::::::::::::::::::::::::::::::::::::::"+result);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/deletePostGallery")
	public Map<String, Object> deletePost(@RequestBody Map<String, Object> map) {
		String post_num = map.get("post_num").toString();
		
		int result = galleryService.deletePost(post_num);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String resultStr = result ==0 ? "fail" : "success";
		resultMap.put("succesed", resultStr);
		
		return resultMap;
	}
}
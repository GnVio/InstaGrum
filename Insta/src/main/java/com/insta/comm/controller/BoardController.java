package com.insta.comm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.insta.comm.mapper.PostPopupDto;
import com.insta.comm.service.IBoardService;
import com.insta.comm.service.IBookmarkService;
import com.insta.comm.mapper.CommentDto;
import com.insta.comm.mapper.FileDto;
import com.insta.comm.mapper.IBookmarkMapper;
import com.insta.comm.mapper.MemberDto;
import com.insta.comm.mapper.PostDto;
import com.insta.comm.service.IMainService;

@Controller
public class BoardController {

   @Autowired
   IBoardService bService;
   
   @Autowired
   IMainService mService;
   
   @Autowired
   IBookmarkService bookService;
   
   /***
    * 글 작성하는 페이지
    * @param req 
    * @param session
    * @return
    */
   @RequestMapping("/postwrite")
   public String boardadd(HttpServletRequest req, HttpSession session) {

      MemberDto sessionVo = (MemberDto)session.getAttribute("member");
      System.out.println("session:::::::::::::::::::::::::::::::::::::::::" + sessionVo);
   
      if(sessionVo == null){
         
         return "/member/login";
         
      }else {
               
         return "/mypage/postwrite";
      }
   }   
   
   /***
    * 게시판 글 작성
    * @param mtfRequest 파일
    * @param req 글 작성 정보
    * @return 메인화면 전환   
    */
   @ResponseBody
   @RequestMapping("/requestupload")
    public String requestupload2(@RequestParam("article_file") List<MultipartFile> fileList,HttpServletRequest req) {      
            
      HttpSession session = req.getSession();
      MemberDto mDto =  (MemberDto)session.getAttribute("member");
      String user_id = mDto.getUser_id();
      
      String board_num = req.getParameter("boardNum");
      String post_content = req.getParameter("text_content");

      String result = "";
      int resultint = bService.insertPost(board_num, user_id, post_content, fileList);
      
      if(resultint == 0) {
         result = "redirect:/postwrite";
      } else {
         result = "redirect:/mypage";   
      }      
      return result;
   }
   
   /***
    * 게시판 메인 화면
    * @param model 
    * @return
    */
   @RequestMapping("/board")
   public String boardList(Model model,HttpSession session) {
      
      MemberDto sessionVo = (MemberDto)session.getAttribute("member");
      System.out.println("session:::::::::::::::::::::::::::::::::::::::::" + sessionVo);
   
      if(sessionVo == null){
         
         return "/member/login";
         
      }else {
         model.addAttribute("boardList", bService.boardList());               
         return "/board/board";
      }
   }
   
   /***
    * 글 상세보기
    * @param req
    * @return
    */
   @ResponseBody
   @RequestMapping("/detailViewPopup")
   public Map<String, Object> detailViewPopup(@RequestBody Map<String, Object> reqMap, HttpServletRequest req) {
      HttpSession session = req.getSession();
      MemberDto mDto =  (MemberDto)session.getAttribute("member");
      String user_id = mDto.getUser_id();
      String post_num = reqMap.get("post_num").toString();
      
      /* 화면에 필요한 정보 가져오기 */
      PostPopupDto result = bService.detailViewPopup(post_num);
      
      /* 작성된 댓글 리스트 가져오기 */
      List<CommentDto> commentList =  mService.CommentList(post_num);
      List<PostDto> getFileList = bService.getFileList(post_num);
      
      /* 좋아요 상태 확인 */
      int isLikePost = bService.isLikePost(post_num, user_id);
      
      /* 즐겨찾기 상태 확인 */
      int isBookMarkPost = bookService.isBookMarkPost(post_num, user_id);
      
      Map<String, Object> resultMap = new HashMap<String, Object>();
      
      resultMap.put("viewPost", result);
      resultMap.put("getFileList", getFileList);
      resultMap.put("commentList", commentList);
      resultMap.put("session_id", user_id);
      resultMap.put("isLikePost", isLikePost);
      resultMap.put("isBookMarkPost", isBookMarkPost);
      return resultMap;
   }   
   
//   @RequestMapping("/deleteFiles")
//   public String deleteFiles(HttpServletRequest req) {
//      String post_num = req.getParameter("hdn_postNum");
//      
//      int postResult = bService.deleteFiles(post_num);
//   
//      return "redirect:main";
//   }
   
   /***
    * 작성한 글 삭제
    * @param reqMap
    * @return
    */
   @ResponseBody
   @RequestMapping("/deleteFiles")
   public  Map<String, Object> deleteFiles(@RequestBody Map<String, Object> reqMap) {
      String post_num = reqMap.get("post_num").toString();

      /* 글 삭제 서비스 */
      int result = bService.deletePost(post_num);   
      
      Map<String, Object> resultMap = new HashMap<String, Object>();
      String resultStr = result == 0 ? "fail" : "success";
      resultMap.put("succesed", resultStr);
      
      return resultMap;
   }
   
//   @ResponseBody
//   @RequestMapping("/modifyFiles")
//   public  Map<String, Object> modifyFiles(@RequestBody Map<String, Object> reqMap) {
//      String post_num = reqMap.get("post_num").toString();
//      
//       Map<String, Object> resultMap = new HashMap<String, Object>();
//      
//      return resultMap;
//   }
   
   /***
    * 글 수정
    * @param dto 글 정보
    * @param model
    * @return
    */
   @RequestMapping("/modify")
   public String updatePost(HttpServletRequest req, Model model, HttpSession session) {
      String post_num = req.getParameter("hdn_postNum");
      MemberDto mDto =  (MemberDto)session.getAttribute("member");
      String user_id = mDto.getUser_id();
      
      PostPopupDto result = bService.detailViewPopup(post_num);
      
      List<PostDto> getFileList = bService.getFileList(post_num);
      
      model.addAttribute("viewPost", result);
      model.addAttribute("getFileList", getFileList);
      model.addAttribute("session_id", user_id);
      
      //model.addAttribute("dto", dto);
      
      return "/mypage/modify";
   }   

   /***
    * 수정 시 파일 재 업로드
    * @param fileList
    * @param req
    * @return
    */
   @ResponseBody
   @RequestMapping("/reupload")
    public String requestupload(@RequestParam("article_file") @Nullable List<MultipartFile> fileList,HttpServletRequest req) {
      /* 글 내용 */ 
             
      String post_content = req.getParameter("text_content");         
      String post_num = req.getParameter("post_num");
      String[] originals = req.getParameterValues("original_file_name");
      String[] saves = req.getParameterValues("save_file_name");
      List<FileDto> fileDtoList = new  ArrayList<FileDto>();
      for (int i=0; i<originals.length;i++) {
         FileDto dto = new FileDto();
         dto.setOriginal_file_name(originals[i]);
         dto.setSave_file_name(saves[i]);
         fileDtoList.add(dto);
      }
      
      String result = "";

      /* 글 수정 서비스 */            
      int resultint = bService.updatePost(post_num, post_content, fileList, fileDtoList);
      
      if(resultint == 0) {
         result = "redirect:/modify";
      } else {
         result = "redirect:/mypage";   
      }      
      return result;
   }
   
   /***
    * 좋아요 상태 확인
    * @param map
    * @param req
    * @return
    */
   @ResponseBody
   @RequestMapping("/likeProc")
   public String likeProc(@RequestBody Map<String, String> map,HttpServletRequest req) {
      
      /* 0인지 1인지 확인 */
      String likeTgle = map.get("likeTgle");
      String post_num = map.get("post_num");
      HttpSession session = req.getSession();
      MemberDto mDto =  (MemberDto)session.getAttribute("member");
      String user_id = mDto.getUser_id();

      /* 좋아요 상태 확인 서비스 */
      int re = bService.likeProc(Integer.parseInt(likeTgle), post_num, user_id);
      String likeReturn = "";
      
      if(re == 0) {
         likeReturn = "{\"result\":\"fail\"}";
      } else {
         likeReturn = "{\"result\":\"success\"}";
      }
      
      return likeReturn;
   }
   
   
   
}
package com.insta.comm.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.insta.comm.mapper.FileDto;
import com.insta.comm.mapper.IPostMapper;
import com.insta.comm.mapper.PostDto;
import com.insta.comm.mapper.PostPopupDto;
import com.insta.comm.mapper.PostShowFile;

@Service
public class BoardService implements IBoardService {
   @Value("${fileUploadPath}")
   String fileUploadPath;
   
   @Autowired
   private IPostMapper postDao;
   
   /***
    * 게시판 글 작성
    */
   public int insertPost(String board_num, String user_id, String post_content, List<MultipartFile> fileList) {
      int result = 0;
      int postResult = 0;
      int fileResult = 0;
      
      try {
         if(fileList.size()>0 &&!"".equals(fileList.get(0).getOriginalFilename())) {
         String post_num = postDao.getMaxPostNo();
         
            postResult = postDao.insertPost(post_num, board_num, user_id, post_content);         
            
            System.out.println("fileUploadPath ::::::::::::::::" + fileUploadPath);
            
            //파일 실제 경로
            String realPath = fileUploadPath + "upload\\post\\";              
             
             
             //경로 상에 폴더가 없으면 만들기           
            File dir = new File(realPath);
             if(!dir.exists()) {
                  dir.mkdirs();
                  }           
               
                //파일 넣기
             for (MultipartFile mf : fileList) {
                //실제 파일 이름
                String original_file_name = mf.getOriginalFilename();
                
                   //시간 + 실제 파일 이름
                String save_file_name = System.currentTimeMillis() + original_file_name;
                  
                
                //파일 저장 경로                 
                String savePath = realPath + save_file_name;
                  
                // DB저장 경로
                String dbPath = "/upload/post/";
                  
                // 파일 저장
                File o_file = new File(savePath);               
                mf.transferTo(o_file);         
               
                String file_num = postDao.getMaxFileNo(post_num);
                //String file_num = postDao.getMaxFileNo(post_num).equals(null) ? "F0000001" : postDao.getMaxFileNo(post_num);
                           
                fileResult = postDao.insertFile(file_num, dbPath, post_num, save_file_name, original_file_name);
               }         
         }
      
      }
      //파일관련 에러 반환
      catch (IOException io) {
         System.out.println(io.getMessage());
      }
      catch (Exception e) {
         System.out.println(e.getMessage());
      }
      
      if(postResult==0||fileResult==0) {
         result = 0;
      }
      else
         result = 1;
      
      return result;
   }
   
   public List<PostShowFile> boardList(){
      
      List<PostShowFile> boardList = postDao.boardList();
      return boardList;
   }
   
   public PostPopupDto detailViewPopup(String post_num) {
      PostPopupDto detailView = postDao.detailViewPopup(post_num);
      return detailView;
   }
   
   public List<PostDto> getFileList(String post_num){
      
      List<PostDto> getFileList = postDao.getFileList(post_num);
      return getFileList;      
   }
   
   public int deletePost(String post_num) {
      int result = 0;
      
      int deleteFiles = 0;
      int updateIsuse = 0;
      try {
         deleteFiles = postDao.deleteFiles(post_num);
         updateIsuse = postDao.deletePost(post_num);
      } catch (Exception e) {
         System.out.println(e.getMessage());
      }      
      
      if(deleteFiles==0&&updateIsuse==0) {
         result = 0;
      }else
         result = 1;
      
      return result;
   }
   
   @Transactional
   @Override
   public int updatePost(String post_num, String post_content, List<MultipartFile> fileList, List<FileDto> fileDtoList) {
      int result = 0;      
      int fileResult = 0;      
      int deleteFiles = 0;
      int updatePost = 0;
      
      try {
         updatePost= postDao.updatePost(post_num, post_content);
         deleteFiles = postDao.deleteFiles(post_num);
         
         for (FileDto md : fileDtoList) {
            String file_num = postDao.getMaxFileNo(post_num);      
            String dbPath = "/upload/post/";
            String md_save_file_name = md.getSave_file_name();
            String md_original_file_name = md.getOriginal_file_name();

            if(!md_save_file_name.equals(md_original_file_name)){
               fileResult = postDao.insertFile(file_num, dbPath, post_num, md_save_file_name, md_original_file_name);         
            } else {}
         }
      } catch (Exception e) {
         System.out.println(e.getMessage());
      }   
      
      
      try {         
         if(fileList.size()>0 &&!"".equals(fileList.get(0).getOriginalFilename())) {
         
         String realPath = fileUploadPath + "upload\\post\\";           
         
          for (MultipartFile mf : fileList) {
             //실제 파일 이름
             String original_file_name = mf.getOriginalFilename();
             
                //시간 + 실제 파일 이름
             String save_file_name = System.currentTimeMillis() + original_file_name;
               
             
             //파일 저장 경로                 
             String savePath = realPath + save_file_name;
               
             // DB저장 경로
             String dbPath = "/upload/post/";
               
             // 파일 저장
             File o_file = new File(savePath);               
             mf.transferTo(o_file);         
            
             String file_num = postDao.getMaxFileNo(post_num);
             
             // String file_num = postDao.getMaxFileNo(post_num);
             //String file_num = postDao.getMaxFileNo(post_num).equals(null) ? "F0000001" : postDao.getMaxFileNo(post_num);
                        
              fileResult = postDao.insertFile(file_num, dbPath, post_num, save_file_name, original_file_name);
            }               
         }          
      } catch (IOException io) {
         System.out.println(io.getMessage());
      } catch (Exception e) {
         System.out.println(e.getMessage());
      }
      
         
      
      if(deleteFiles==0&&updatePost==0&&fileResult==0) {
         result = 0;
      }else
         result = 1;
      
      return result;
   }   
   
   public int likeProc(int isLikePost, String post_num, String user_id) {
      int result = 0;
      int calResult = 0;
      
      if(isLikePost > 0) {
         //postDao.updatePost(post_num);
         result = postDao.delLike(post_num, user_id);
         calResult = postDao.updatePostLikeMinus(post_num);
      }
      else {
         result = postDao.addLike(post_num, user_id);
         calResult = postDao.updatePostLikePlus(post_num);
      }
      
      if(result==0&&calResult==0) {
         result = 0;
      }else
         result = 1;
      
      return result;
   }
   
   public int isLikePost(String post_num, String user_id) {
      return postDao.isLikePost(post_num, user_id);
   }
    
   
}
package com.insta.comm.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.insta.comm.mapper.IMemberMapper;
import com.insta.comm.mapper.MemberDto;

@Service
public class MemberService implements IMemberService {
	@Value("${fileUploadPath}")
	   String fileUploadPath;
	
	
	@Autowired
	IMemberMapper memMapper;
	
	//아이디 찾기 후 넘어갈때 값들 반환
	public MemberDto get(MemberDto vo){
		
		return memMapper.get(vo);
	}
	
	public int countFriend(String user_id) {
		
		return memMapper.countFriend(user_id);
	}
	
	// 친구리스트 불러오기
	public List<MemberDto> friendList(String user_id){
		
		return memMapper.friendList(user_id);
	}
	
	// 친구아이디리스트 불러오기
	public List<MemberDto> friendIdList(String user_id){
		return memMapper.friendIdList(user_id);
	}
	
	
	// 친구추가
	public int addFriend(String friend_id,String user_id) {
		
		return memMapper.addFriend(friend_id, user_id);
	}
	
	//친구삭제
	public int deleteFriend(String friend_id) {
		
		return memMapper.deleteFriend(friend_id);
	}
	
	
	
	//유저 찾기
	public List<MemberDto> search(String user_id) {
		
		
//		Map<String, Object> dataMap = new HashMap<String, Object>();
//		dataMap.put("findPw", memMapper.findPw(user_id, user_email));
//		dataMap.put("countId", memMapper.countId(user_id));
//		dataMap.put("countEmail", memMapper.countEmail(user_email));
//		
//		
//		return dataMap;
		
		return memMapper.search(user_id);
	}
	
	public int writeService(String user_id, String password, String name,String email,String gender,String introduce,String tell,List<MultipartFile> filelist, String user_pho2) {
        	int result = 0;
		try {
			String realPath = fileUploadPath + "image\\member\\"; 
		
	       File dir = new File(realPath);
	       if(!dir.exists()) {
	          dir.mkdirs();
	       }    

	       for (MultipartFile mf : filelist) {           
	           String originFileName = mf.getOriginalFilename(); // 원본 파일명
	           
	           if(!originFileName.equals("")) {
	                //시간 + 실제 파일 이름
	                String newFileName = System.currentTimeMillis() + originFileName;
	                  
	                //파일 저장 경로                 
	                String savePath = realPath + newFileName;
	                  
	                // DB저장 경로
	                String dbPath = "/image/member/" + newFileName;
	           
	                //파일 저장
	              File o_file = new File(savePath);               
	              mf.transferTo(o_file);
	              result = memMapper.writeMapper(user_id, password, name, tell, gender, introduce, dbPath, email);
	           } 
	           else{
		           result = memMapper.writeMapper(user_id, password, name, tell, gender, introduce, user_pho2, email);
	           }
	       }
        }
        catch (IllegalStateException e) {
        	e.printStackTrace();
        } catch (IOException e) {
        	e.printStackTrace();
        }
	           
        return result;
	       
	}
        
	// 아이디 중복검사
	public int checkIdService(String user_id) {
		return memMapper.checkId(user_id);
	}
	
	// 이메일 중복검사
	public int checkEmailService(String user_email) {
		return memMapper.checkEmail(user_email);
	}
	
	// MemberDao에서 MemberVo안에 조회된 값들이 담깁니다.
	@Override
	public MemberDto login(MemberDto vo){
		return memMapper.login(vo);
	}
	
	
//	@Override
//	public void memberUpdate(MemberDto vo) throws Exception {
//		
////		memMapper.memberUpdate(vo);
//
//		try {
//			String realPath = fileUploadPath + "image\\"; 
//		
//	       File dir = new File(realPath);
//	       if(!dir.exists()) {
//	          dir.mkdirs();
//	       }    
//
//	       for (MultipartFile mf : vo.getFileList()) {           
//	           String originFileName = mf.getOriginalFilename(); // 원본 파일 명
//	           
//	           
//	           if(!originFileName.equals("")) {
//	                //시간 + 실제 파일 이름
//	                String newFileName = System.currentTimeMillis() + originFileName;
//	                  
//	                
//	                //파일 저장 경로                 
//	                String savePath = realPath + newFileName;
//	                  
//	                // DB저장 경로
//	                String dbPath = "/image/" + newFileName;
//	           
//	                //파일 저장
//	              File o_file = new File(savePath);               
//	              mf.transferTo(o_file);
//	              
//	              vo.setDbPath(dbPath);
//	              	
//	      			memMapper.memberUpdate(vo);
//	              //result = memMapper.memberUpdate(user_id, user_pw, user_name, user_tel,user_introduce, dbPath, user_email);
//	           } 
//	       }
//        }
//        catch (IllegalStateException e) {
//        	e.printStackTrace();
//        } catch (IOException e) {
//        	e.printStackTrace();
//        }
//	           
//
//		
//	}

	public int memberUpdate(String user_id, String user_pw, String user_name, String user_tel, String user_introduce, List<MultipartFile> filelist, String user_email, String user_pho_path2){
		int result = 0;
		  
		try {
//			MemberDto vo = new MemberDto();
//			  vo.setUser_id(user_id);
//			  vo.setUser_pw(user_pw);
//			  vo.setUser_name(user_name);
//			  vo.setUser_email(user_email);
//			  vo.setUser_introduce(user_introduce);
//			  vo.setUser_tel(user_tel);
//			  vo.setFileList(filelist);
			String realPath = fileUploadPath + "image\\member\\"; 
		
	       File dir = new File(realPath);
	       if(!dir.exists()) {
	          dir.mkdirs();
	       }    
	       
	       // filelist안에 mf를 넣음
	       for (MultipartFile mf : filelist) {           
	           String originFileName = mf.getOriginalFilename(); // 원본 파일명
	           
	           
	           if(!originFileName.equals("")) {
	                //시간 + 실제 파일 이름
	                String newFileName = System.currentTimeMillis() + originFileName;           
	                
	                //파일 저장 경로                 
	                String savePath = realPath + newFileName;
	                  
	                // DB저장 경로
	                String dbPath = "/image/member/" + newFileName;
	           
	                //파일 저장
	              File o_file = new File(savePath);               
	              mf.transferTo(o_file);
	              
	              //vo.setDbPath(dbPath);

	              result = memMapper.memberUpdate(user_id, user_pw, user_name, user_tel, user_email, dbPath, user_introduce);
	            
	           }
	           else{
		           result = memMapper.memberUpdate(user_id, user_pw, user_name, user_tel, user_email, user_pho_path2,user_introduce);
	           }
	       }
        }
        catch (IllegalStateException e) {
        	e.printStackTrace();
        } catch (IOException e) {
        	e.printStackTrace();
        }
		
        return result;
	}
	
	public String findId(String user_email) {
		return memMapper.findId(user_email);
	}
	
	public Map<String, Object> findPw(String user_id, String user_email) {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("findPw", memMapper.findPw(user_id, user_email));
		dataMap.put("countId", memMapper.countId(user_id));
		dataMap.put("countEmail", memMapper.countEmail(user_email));
		
		
		return dataMap;
	}
}

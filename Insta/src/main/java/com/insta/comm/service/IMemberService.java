package com.insta.comm.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.insta.comm.mapper.MemberDto;

public interface IMemberService {
	public int writeService(String user_id, String password, String name,String email,String gender,String introduce,String tell,List<MultipartFile> filelist,String user_pho2);
	
	public int checkIdService(String user_id);
	
	public int checkEmailService(String user_email);
	
	public List<MemberDto> search(String user_id);
	
	public String findId(String user_email);
	
	public Map<String, Object> findPw(String user_id, String user_email);
	
	//아이디 찾기 후 넘어갈때 값들 반환
	public MemberDto get(MemberDto vo);
	
	// 친구추가
	public int addFriend(String friend_id,String user_id);
	
	// 친구리스트 불러오기
	public List<MemberDto> friendList(String user_id);
	
	// 친구아이디리스트 불러오기
	public List<MemberDto> friendIdList(String user_id);
	
	//친구삭제
	public int deleteFriend(String friend_id);
	
	// 총 친구 Count
	public int countFriend(String user_id);
	
	// 로그인
	public MemberDto login(MemberDto vo);
	
	
	//public void memberUpdate(MemberDto vo) throws Exception;
	public int memberUpdate(String user_id, String user_pw, String user_name, String user_tel, String user_introduce, List<MultipartFile> filelist, String user_email, String user_pho_path2);
}

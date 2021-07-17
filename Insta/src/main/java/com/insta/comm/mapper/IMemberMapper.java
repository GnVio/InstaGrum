package com.insta.comm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;



@Mapper
public interface IMemberMapper {
	// login(MemberDto vo)에 파라미터 값이 전달되며
	// xml에서 조회한 데이터들은 MemberDto에 담깁니다.
	public MemberDto login(MemberDto vo);
	
	//유저 검색
	public List<MemberDto> search(@Param("user_id") String user_id);
	
	// 아이디 찾기
	public String findId(String user_email);
	
	// 비밀번호 찾기
	public String findPw(String user_id, String user_email);
	
	//아이디 찾기 후 넘어갈때 값들 반환
	public MemberDto get(MemberDto vo);
	
	// id카운트
	public int countId(String user_id);
	
	// email 카운트
	public int countEmail(String user_email);
	
	// 회원가입
	public int writeMapper(String user_id,
			String user_pw,
			String user_name,
			String user_tel,
			String user_gender,
			String user_introduce,
			String user_pho_path,
			String user_email
			);
	
	// 회원정보 수정
	//public int memberUpdate(MemberDto vo) throws Exception;
	
	public int memberUpdate(@Param("user_id") String user_id,
			@Param("user_pw") String user_pw,
			@Param("user_name") String user_name,
			@Param("user_tel") String user_tel,
			@Param("user_email") String user_email,
			@Param("user_pho_path")String user_pho_path,
			@Param("user_introduce") String user_introduce
			);
	
	// 친구리스트 불러오기
	public List<MemberDto> friendList(@Param("user_id") String user_id);
	
	// 친구아이디리스트 불러오기
	public List<MemberDto> friendIdList(@Param("user_id") String user_id);
	
	public int countFriend(@Param("user_id") String user_id);
	
	// 친구추가
	public int addFriend(@Param("friend_id") String friend_id,@Param("user_id") String user_id);
	
	//친구삭제
	public int deleteFriend(@Param("friend_id") String friend_id);
	
	// ID 중복확인
	public int checkId(@Param("user_id") String user_id);
	
	// email 중복확인
	public int checkEmail(@Param("user_email") String user_email);		
}

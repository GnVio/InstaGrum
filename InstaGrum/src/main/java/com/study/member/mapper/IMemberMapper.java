package com.study.member.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IMemberMapper {
	List<MemberDto> listMapper();
	
	
//	List<BbsDTO> listDao();
//	public BbsDTO viewDao(String user_id);
//	public String writerDao(String Post_No, String BOARD_NO, String USER_ID, String TITLE, String CONTENTS);
//	public String writerParamDao(
//			@Param("post_no") String Post_No,
//			@Param("BOARD_NO") String BOARD_NO,
//			@Param("USER_ID") String USER_ID,
//			@Param("TITLE") String TITLE,
//			@Param("CONTENTS") String CONTENTS);
//	   public int writeMapDao(Map<String, String> map);
//	public int deleteDao(String post_no);
//	public String getNick(@Param("user_id") String user_id);
//	public String getMaxBoardNo();
}

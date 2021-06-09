package com.study.member.mapper;

import lombok.Data;

@Data
public class MemberDto {
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_tel;
	private String user_gender;
	private String user_introduce;
	private String user_pho_path;
	private String user_email;
}

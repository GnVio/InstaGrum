package com.insta.comm.mapper;

import lombok.Data;

@Data
public class MainDto {	
	private String user_id;
	private String user_name;
	private String user_introduce;
	private String user_pho_path;
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_introduce() {
		return user_introduce;
	}
	public void setUser_introduce(String user_introduce) {
		this.user_introduce = user_introduce;
	}
	public String getUser_pho_path() {
		return user_pho_path;
	}
	public void setUser_pho_path(String user_pho_path) {
		this.user_pho_path = user_pho_path;
	}
}

package com.study.comm.common.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CommonController {
	@RequestMapping("/")
	public @ResponseBody String root() throws Exception {
		return "Transaction Propagation (4)";
	}
   
   @RequestMapping("/test")
   public String test() {
      return "test";
   }

   @RequestMapping("/signup")
   public String singup() {
      return "signup";
   }
   
//	   @RequestMapping("/json")
//		@ResponseBody
//		public Map<String, Object> jsonTest(@RequestBody Map<String, Object> param, Model mv) {
//			System.out.println(param);
//			String searchVal = param.get("searchValue").toString();
//			
//			param.get("consumerId");
//			
//			Map<String, Object> resultMap = dao.alalal();
//			mv.addAttribute("result", param);
//			return resultMap;
//		}
}

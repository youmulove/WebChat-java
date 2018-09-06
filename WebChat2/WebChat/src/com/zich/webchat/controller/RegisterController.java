package com.zich.webchat.controller;



import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zich.webchat.pojo.User;
import com.zich.webchat.service.UserService;

@Controller
@RequestMapping(value = "/user")
public class RegisterController {
	@Autowired
	private UserService us;
	@RequestMapping(value = "/register",method = RequestMethod.GET)
	public String register() {
		return "register";
	}
	@RequestMapping(value = "/saveRegister")
	@ResponseBody
	public String save(User u) {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:SS");
		u.setFirsttime(sdf.format(new Date()));
		u.setStatus(1);
		if(us.insert(u)){
		return "success";
		}
		return "error";
	}
}

package com.xx.webchat.controller;

import com.xx.webchat.pojo.User;
import com.xx.webchat.service.ILogService;
import com.xx.webchat.service.IUserService;
import com.xx.webchat.utils.CommonDate;
import com.xx.webchat.utils.LogUtil;
import com.xx.webchat.utils.NetUtil;
import com.xx.webchat.utils.WordDefined;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

import javax.annotation.Resource;
import javax.enterprise.inject.Model;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Author :  Amayadream
 * Date   :  2016.01.08 14:57
 * TODO   :  用户登录与注销
 */
@Controller
@RequestMapping(value = "/reg")
public class RegisterController {
	
	@Autowired
	private IUserService userService;
	
	@RequestMapping("/registerhtml")
	public String RegisterHtml() {
		return "register";
	}
	
	@RequestMapping(value="/register", method = RequestMethod.POST)
	public String Register(String userid, String password,CommonDate date,ModelMap model) {
		User user = userService.selectUserByUsername(userid);
		System.out.println(user);
		if (user != null) {
			model.addAttribute("message","用户已存在,请登录");
			return "register";
		}else {
			User ur = new User();
			ur.setNickname(userid);
			ur.setPassword(password);
			ur.setUserid(userid);
			ur.setSex(0);
			ur.setAge(18);
			ur.setProfile("新用户");
			ur.setFirsttime("2017-01-11 19:22:21");
			ur.setLasttime(date.getTime24());
			ur.setStatus(1);
			ur.setProfilehead("upload/Amayadream/Amayadream.jpg");
			userService.insert(ur);
			return "login";
		}
		
	}
}

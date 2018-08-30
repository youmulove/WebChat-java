package com.xx.webchat.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.xx.webchat.websocket.AudioChat;
import com.xx.webchat.websocket.VideoChat;

@Controller
@RequestMapping(value = "/audio")
public class AudioMsgController {
	private static final long serialVersionUID = 1L;

	@RequestMapping(value = "/msg", method = RequestMethod.GET)
	public String videomsg(HttpServletRequest request,RedirectAttributes redirectAttributes)
			throws ServletException, IOException {
		//获取被邀请人的id
		String oid = request.getParameter("oid");
		System.out.println("------oid------" + oid);
		//邀请人的id
		String uid = request.getParameter("uid");
		System.out.println("------uid------" + uid);
		redirectAttributes.addFlashAttribute("initiator", "false");
		//判断有无被邀请对话人
		if (AudioChat.addUser(uid, oid)) {
			//无
			redirectAttributes.addFlashAttribute("uid", uid);
		} else {
			//有
			redirectAttributes.addFlashAttribute("initiator", "true");
			redirectAttributes.addFlashAttribute("uid", uid);
			redirectAttributes.addFlashAttribute("oid", oid);
		}
		return "redirect:/audio";
//		return "video";
	}
}

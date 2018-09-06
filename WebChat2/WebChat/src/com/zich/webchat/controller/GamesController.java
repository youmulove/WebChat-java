package com.zich.webchat.controller;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author ccq
 * @Description
 * @date 2017/12/16 22:59
 */
@Controller
public class GamesController {

    /**
     * 跳转到聊天页面
     * @return
     */
    @RequestMapping("/fiveChess")
    public ModelAndView getFiveChess(){
        ModelAndView mv = new ModelAndView("game/five-chess");
        return mv;
    }
    
    @RequestMapping("/chinesechess")
    public ModelAndView getChineseChess(){
        ModelAndView mv = new ModelAndView("game/chinesechess");
        return mv;
    }
    @RequestMapping("/emigrated")
    public ModelAndView getEmigrated(){
        ModelAndView mv = new ModelAndView("game/emigrated");
        return mv;
    }
    @RequestMapping("/snake")
    public ModelAndView getSnake(){
        ModelAndView mv = new ModelAndView("game/snake");
        return mv;
    }
    @RequestMapping("/pokemole")
    public ModelAndView getPokemole(){
        ModelAndView mv = new ModelAndView("game/pokemole");
        return mv;
    }
    @RequestMapping("/fishgame")
    public ModelAndView getFishGame(){
        ModelAndView mv = new ModelAndView("game/fishgame");
        return mv;
    }
    @RequestMapping("/jfczcoreball")
    public ModelAndView getJfczcoreball(){
        ModelAndView mv = new ModelAndView("game/jfcz-coreball");
        return mv;
    }
}

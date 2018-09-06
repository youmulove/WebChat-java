package com.zich.webchat.utils;

import com.zich.webchat.pojo.Log;

/**
 * NAME   :  WebChat/com.zich.webchat.utils
 * Author :  zich
 * TODO   :
 */
public class LogUtil {

    public Log setLog(String userid, String time, String type, String detail, String ip){
         Log log = new Log();
        log.setUserid(userid);
        log.setTime(time);
        log.setType(type);
        log.setDetail(detail);
        log.setId(ip);
        return log;
    }

}

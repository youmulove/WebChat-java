package com.zich.webchat.service;

import com.zich.webchat.pojo.Log;

import java.util.List;

/**
 * NAME   :  WebChat/com.zich.webchat.service
 * Author :  zich
 * TODO   :
 */
public interface LogService {
    List<Log> selectAll(int page, int pageSize);
    List<Log> selectLogByUserid(String userid, int page, int pageSize);
    int selectCount(int pageSize);
    int selectCountByUserid(String userid, int pageSize);
    boolean insert(Log log);
    boolean delete(String id);
    boolean deleteThisUser(String userid);
    boolean deleteAll();
}

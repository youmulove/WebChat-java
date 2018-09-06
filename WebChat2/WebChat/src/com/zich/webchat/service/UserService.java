package com.zich.webchat.service;

import com.zich.webchat.pojo.User;

import java.util.List;

/**
 * NAME   :  WebChat/com.zich.webchat.service
 * Author :  zich
 * TODO   :
 */
public interface UserService {
    List<User> selectAll();
    User selectUserByUserid(String userid);
    int selectCount(int pageSize);
    boolean insert(User user);
    boolean update(User user);
    boolean delete(String userid);
}

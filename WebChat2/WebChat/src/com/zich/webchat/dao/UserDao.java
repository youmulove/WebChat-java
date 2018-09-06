package com.zich.webchat.dao;

import com.zich.webchat.pojo.User;

import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * NAME   :  WebChat/com.zich.webchat.dao
 * Author :  zich
 * TODO   :
 */
@Service(value = "userDao")
public interface UserDao {
    List<User> selectAll();

    User selectUserByUserid(String userid);

    User selectCount();

    boolean insert(User user);

    boolean update(User user);

    boolean delete(String userid);
}

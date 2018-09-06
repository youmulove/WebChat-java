package com.zich.webchat.serviceImpl;

import com.zich.webchat.dao.UserDao;
import com.zich.webchat.pojo.User;
import com.zich.webchat.service.UserService;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * NAME   :  WebChat/com.zich.webchat.serviceImpl
 * Author :  zich
 * TODO   :
 */
@Service(value = "userService")
public class UserServiceImpl implements UserService {

    @Resource private UserDao userDao;

    @Override
    public List<User> selectAll() {
        return userDao.selectAll();
    }

    @Override
    public User selectUserByUserid(String userid) {
        return userDao.selectUserByUserid(userid);
    }

    @Override
    public int selectCount(int pageSize) {
        int pageCount = Integer.parseInt(userDao.selectCount().getUserid());
        return pageCount % pageSize == 0 ? pageCount/pageSize : pageCount/pageSize + 1;
    }

    @Override
    public boolean insert(User user) {
    	for(User u:userDao.selectAll()){
    		if(u.getUserid().equals(user.getUserid())){
    			return false;
    		}
    	}
        return userDao.insert(user);
    }

    @Override
    public boolean update(User user) {
        return userDao.update(user);
    }

    @Override
    public boolean delete(String userid) {
        return userDao.delete(userid);
    }
}

package com.fastcampus.ch4.service;

import com.fastcampus.ch4.dao.UserDao;
import com.fastcampus.ch4.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RegistServiceImpl implements RegistService {

    @Autowired
    UserDao userDao;

    @Override
    public int regist(User user) throws Exception{
        System.out.println("regist - user = " + user);
        return userDao.insert(user);
    }

    @Override
    public User selectUser(String id) throws Exception{
        return userDao.selectUser(id);
    }
}

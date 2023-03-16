package com.fastcampus.ch4.dao;

import com.fastcampus.ch4.domain.User;

public interface UserDao {
    int insert(User user) throws Exception;

   User selectUser(String id) throws Exception;
}

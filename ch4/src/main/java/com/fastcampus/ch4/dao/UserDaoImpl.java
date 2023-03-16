package com.fastcampus.ch4.dao;

import com.fastcampus.ch4.domain.User;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDaoImpl implements UserDao {

    @Autowired
    SqlSession session;
    String namespace = "com.fastcampus.ch4.dao.RegistMapper.";

    @Override
    public int insert(User user) throws Exception{
        return session.insert(namespace+"insert", user);
    }

    @Override
    public User selectUser(String id) throws Exception{
        return session.selectOne(namespace+"select", id);
    }

}

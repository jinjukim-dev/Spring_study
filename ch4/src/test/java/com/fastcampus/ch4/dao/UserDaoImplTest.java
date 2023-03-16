package com.fastcampus.ch4.dao;

import com.fastcampus.ch4.domain.User;
import com.fastcampus.ch4.service.RegistService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class UserDaoImplTest {

    @Autowired
    UserDao userDao;

    @Autowired
    RegistService registService;

    @Test
    public void insert() throws Exception{
        User user = new User("yyyy", "1234", "kimjinju", "aaa@aaa.com", new Date(), "kakao", new Date());
        int rowCnt = registService.regist(user);
        assertTrue(rowCnt==1);
    }
}
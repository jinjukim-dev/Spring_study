package com.fastcampus.ch4.service;

import com.fastcampus.ch4.domain.User;

public interface RegistService {
    int regist(User user) throws Exception;

    User selectUser(String id) throws Exception;
}

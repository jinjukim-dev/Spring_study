package com.fastcampus.ch4.controller;

import com.fastcampus.ch4.dao.UserDao;
import com.fastcampus.ch4.domain.User;
import com.fastcampus.ch4.service.RegistService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;

@Controller
@RequestMapping("/register")
public class RegistController {

    @Autowired
    RegistService registService;

    @GetMapping("/add")
    public String regist(){
        return "registForm";
    }

    @PostMapping("/save")
    public String regist(User user){
        System.out.println("user = " + user);
        try {
            if(registService.regist(user) != 1)
                throw new Exception("regist error");

            return "redirect:/";

        } catch (Exception e) {
            e.printStackTrace();
            return "registForm";
        }

    }
}

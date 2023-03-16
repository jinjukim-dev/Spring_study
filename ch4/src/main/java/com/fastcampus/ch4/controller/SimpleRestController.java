package com.fastcampus.ch4.controller;

import com.fastcampus.ch4.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class SimpleRestController {
    @Autowired
    CommentService commentService;
//    @GetMapping("/ajax")
//    public String ajax() {
//        return "ajax";
//    }

    @GetMapping("/test")
    public String test() {
        return "test";
    }

    @GetMapping("/comment_test")
    public String comment_test() {
        return "comment_test";
    }

//    @GetMapping("/comment_test")
//    public String comment_test(SearchCondition sc, Model m, Integer bno) {
//
//        int totalCnt = 0;
//        try {
//            totalCnt = commentService.getCount(bno);
//            if( totalCnt != 1)
//                throw new Exception("comment getCount Exception");
//            PageHandler pageHandler = new PageHandler(totalCnt, sc);
//            m.addAttribute("ph", pageHandler);
//
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
//
//        return "comment_test";
//    }

//    @PostMapping("/send")
//    @ResponseBody
//    public Person test(@RequestBody Person p) {
//        System.out.println("p = " + p);
//        p.setName("ABC");
//        p.setAge(p.getAge() + 10);
//
//        return p;
//    }
}
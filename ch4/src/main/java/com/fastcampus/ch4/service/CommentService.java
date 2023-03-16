package com.fastcampus.ch4.service;

import com.fastcampus.ch4.domain.CommentDto;
import com.fastcampus.ch4.domain.SearchCondition;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface CommentService {
    //getCount
    int getCount(Integer bno) throws Exception;

    //remove +
    @Transactional(rollbackFor = Exception.class)
    int remove(Integer cno, Integer bno, String commenter) throws Exception;

    //write +
    @Transactional(rollbackFor = Exception.class)
    int write(CommentDto commentDto) throws Exception;

    //getList
    List<CommentDto> getList(Integer bno) throws Exception;

    //read
    CommentDto read(Integer cno) throws Exception;

    //modify
    int modify(CommentDto commentDto) throws Exception;

    List<CommentDto> getSearchReplyPage(SearchCondition sc, Integer bno) throws Exception;
}

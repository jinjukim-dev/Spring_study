package com.fastcampus.ch4.service;

import com.fastcampus.ch4.dao.BoardDao;
import com.fastcampus.ch4.dao.CommentDao;
import com.fastcampus.ch4.domain.CommentDto;
import com.fastcampus.ch4.domain.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {


    BoardDao boardDao;
    CommentDao commentDao;

    //생성자 주입으로 변경 -> 객체 주입이 안된 걸 확인 할 수 있다.
    public CommentServiceImpl(CommentDao commentDao, BoardDao boardDao){
        this.commentDao = commentDao;
        this.boardDao = boardDao;
    }

    //getCount
    @Override
    public int getCount(Integer bno) throws Exception{
        return commentDao.count(bno);
    }

    //remove +
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int remove(Integer cno, Integer bno, String commenter) throws Exception{
        int rowCnt = boardDao.updateCommentCnt(bno, -1);
        System.out.println("updateCommentCnt - rowCnt = " + rowCnt);

        rowCnt = commentDao.delete(cno, commenter);
        System.out.println("rowCnt = " + rowCnt);
        return rowCnt;
    }

    //write +
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int write(CommentDto commentDto) throws Exception{
        boardDao.updateCommentCnt(commentDto.getBno(), 1);
        return commentDao.insert(commentDto);
    }

    //getList
    @Override
    public List<CommentDto> getList(Integer bno) throws Exception{
        return commentDao.selectAll(bno);
    }

    //read
    @Override
    public CommentDto read(Integer cno) throws Exception{
        return commentDao.select(cno);
    }

    //modify
    @Override
    public int modify(CommentDto commentDto) throws Exception{
        return commentDao.update(commentDto);
    }

    @Override
    public List<CommentDto> getSearchReplyPage(SearchCondition sc, Integer bno) throws Exception{
        return commentDao.selectReply(sc, bno);
    }


}

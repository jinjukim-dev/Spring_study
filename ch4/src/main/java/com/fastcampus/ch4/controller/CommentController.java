package com.fastcampus.ch4.controller;

import com.fastcampus.ch4.domain.CommentDto;
import com.fastcampus.ch4.domain.PageHandler;
import com.fastcampus.ch4.domain.SearchCondition;
import com.fastcampus.ch4.service.CommentService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.xml.stream.events.Comment;
import java.util.List;

//@Controller
//@ResponseBody
@RestController
public class CommentController {
    @Autowired
    CommentService commentService;

    /*{
        "pcno":0,
            "comment" : "old hi 2023-01-12 ",
            "commenter" : "asdf"
    }*/

    // 댓글을 수정하는 메서드
    @PatchMapping("/comments/{cno}")  // /ch4/comments/1
    public ResponseEntity<String> modify(@RequestBody CommentDto commentDto, @PathVariable Integer cno, HttpSession session){
        String commenter = (String) session.getAttribute("id");
        commentDto.setCno(cno);
        commentDto.setCommenter(commenter);
        System.out.println("commentDto = " + commentDto);

        try {
            if(commentService.modify(commentDto) != 1)
                throw new Exception("Modify Failed");

            return new ResponseEntity<String>("MDF_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("MDF_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    // 댓글을 등록하는 메서드
    @PostMapping("/comments")  // /ch4/comments?bno=1080
    public ResponseEntity<String> write(@RequestBody CommentDto commentDto, Integer bno, HttpSession session){
        String commenter = (String) session.getAttribute("id");
        commentDto.setBno(bno);
        commentDto.setCommenter(commenter);
        System.out.println("commentDto = " + commentDto);

        try {

            if(commentService.write(commentDto) != 1)
                throw new Exception("Write Failed");

            return new ResponseEntity<String>("WRT_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("WRT_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    // 지정된 댓글을 삭제하는 메서드
    @DeleteMapping("/comments/{cno}")  // /comments/1?bno=1080 <-- 삭제할 댓글 번호
    public ResponseEntity<String> remove(@PathVariable Integer cno, Integer bno, HttpSession session){
        String commenter = (String) session.getAttribute("id");
        try {
            int rowCnt = commentService.remove(cno, bno, commenter);

            if(rowCnt != 1)
                throw  new Exception("Delete Failed");

            return new ResponseEntity<String>("DEL_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("DEL_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    // 지정된 게시물의 모든 댓글을 가져오는 메서드
    @GetMapping("/comments")      // /comments?bno=1080
    public ResponseEntity<List<CommentDto>> list(SearchCondition sc, Integer bno){
        List<CommentDto> list = null;

        System.out.println("sc - CommentController = " + sc);

        try {
            list = commentService.getList(bno);
            //list = commentService.getSearchReplyPage(sc, bno);

            return new ResponseEntity<List<CommentDto>>(list, HttpStatus.OK);  // 200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<CommentDto>>(HttpStatus.BAD_REQUEST);  // 400
        }
    }


}

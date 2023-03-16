package com.fastcampus.ch4.controller;

import com.fastcampus.ch4.domain.*;
import com.fastcampus.ch4.service.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.*;

import javax.servlet.http.*;
import java.time.*;
import java.util.*;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    BoardService boardService;

    @Autowired
    CommentService commentService;

    @PostMapping("/modify")
    public String modify(BoardDto boardDto, SearchCondition sc, Model m, HttpSession session, RedirectAttributes rattr){
        String writer = (String) session.getAttribute("id");
        boardDto.setWriter(writer);

        try {
            int rowCnt = boardService.modify(boardDto);

            if(rowCnt != 1)
                throw new Exception("Modify failed");

            rattr.addFlashAttribute("msg", "MOD_OK");
            return "redirect:/board/list"+sc.getQueryString();
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute(boardDto);
            rattr.addFlashAttribute("msg", "MOD_ERR");
            return "board";
        }

    }

    @PostMapping("/write")
    public String write(BoardDto boardDto, Model m, HttpSession session, RedirectAttributes rattr){
        String writer = (String) session.getAttribute("id");
        boardDto.setWriter(writer);

        try {
            int rowCnt = boardService.write(boardDto); // insert

            if(rowCnt != 1)
                throw new Exception("Write failed");

            rattr.addFlashAttribute("msg", "WRT_OK");
            return "redirect:/board/list";
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute(boardDto);
            rattr.addFlashAttribute("msg", "WRT_ERR");
            return "board";
        }

    }


    @GetMapping("/write")
    public String write(Model m){
        m.addAttribute("mode", "new");
        return "board"; // 읽기와 쓰기에 사용, 쓰기에 사용할때는 mode=new
    }

    @PostMapping("/remove")
    public String remove(Integer bno, SearchCondition sc, HttpSession session, RedirectAttributes rattr){
        String writer = (String) session.getAttribute("id");
        String msg = "DELETE_OK";

        try {
            int rowCnt = boardService.remove(bno, writer);

            if(rowCnt!= 1)
                throw new Exception("board remove error");

        } catch (Exception e) {
            e.printStackTrace();
            msg = "DELETE_ERR";
        }
        System.out.println("sc.getQueryString() = " + sc.getQueryString());
        rattr.addFlashAttribute("msg",msg);
        return "redirect:/board/list"+sc.getQueryString();
    }

    @GetMapping("/read")
    public String read(SearchCondition sc, Integer bno, Model m, RedirectAttributes rattr, HttpSession session) {
        try {
            // 게시글 읽어오기
            BoardDto boardDto = boardService.read(bno);
            m.addAttribute(boardDto);
            m.addAttribute("searchCondition", sc);

            return "board";
        } catch (Exception e) {
            e.printStackTrace();
            rattr.addFlashAttribute("msg", "READ_ERR");


            return "redirect:/board/list";
        }

    }

    @GetMapping("/list")
    public String list(SearchCondition sc, Model m, HttpServletRequest request) {
        if(!loginCheck(request))
            return "redirect:/login/login?toURL="+request.getRequestURL();  // 로그인을 안했으면 로그인 화면으로 이동

        try {

            int totalCnt = boardService.getSearchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);

            PageHandler pageHandler = new PageHandler(totalCnt, sc);

            List<BoardDto> list = boardService.getSearchResultPage(sc);
            m.addAttribute("list", list);
            m.addAttribute("ph", pageHandler);

            Instant startOfToday = LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant();
            m.addAttribute("startOfToday", startOfToday.toEpochMilli());


        } catch (Exception e) {
            e.printStackTrace();
        }

        return "boardList"; // 로그인을 한 상태이면, 게시판 화면으로 이동
    }

    private boolean loginCheck(HttpServletRequest request) {
        // 1. 세션을 얻어서
        HttpSession session = request.getSession();
        // 2. 세션에 id가 있는지 확인, 있으면 true를 반환
        return session.getAttribute("id")!=null;
    }
}
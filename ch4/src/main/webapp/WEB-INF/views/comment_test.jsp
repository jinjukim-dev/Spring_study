<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
  <title>Document</title>
  <style>
    /** {*/
    /*  border : 0;*/
    /*  padding : 0;*/
    /*}*/

    .comment-ul {
      border:  1px solid rgb(235,236,239);
      border-bottom : 0;
    }

    .comment-li {
      background-color: #f9f9fa;
      list-style-type: none;
      border-bottom : 1px solid rgb(235,236,239);
      padding : 18px 18px 0 18px;
    }

    #commentList {
      width : 50%;
      margin : auto;
    }

    .comment-content {
      overflow-wrap: break-word;
    }

    .comment-bottom {
      font-size:9pt;
      color : rgb(97,97,97);
      padding: 8px 0 8px 0;
    }

    .comment-bottom > a {
      color : rgb(97,97,97);
      text-decoration: none;
      margin : 0 6px 0 0;
    }

    .comment-area {
      padding : 0 0 0 46px;
    }

    .commenter {
      font-size:12pt;
      font-weight:bold;
    }

    .commenter-writebox {
      padding : 15px 20px 20px 20px;
    }

    .comment-img {
      font-size:36px;
      position: absolute;
    }

    .comment-item {
      position:relative;
      background-color: #f9f9fa;
      list-style-type: none;
      border-bottom : 1px solid rgb(235,236,239);
      padding : 18px 18px 0 18px;
    }

    .up_date {
      margin : 0 8px 0 0;
    }

    #comment-writebox {
      background-color: white;
      border : 1px solid #e5e5e5;
      border-radius: 5px;
    }

    .comment-textarea {
      display: block;
      width: 100%;
      min-height: 17px;
      padding: 0 20px;
      border: 0;
      outline: 0;
      font-size: 13px;
      resize: none;
      box-sizing: border-box;
      background: transparent;
      overflow-wrap: break-word;
      overflow-x: hidden;
      overflow-y: auto;
    }

    #comment-writebox-bottom {
      padding : 3px 10px 10px 10px;
      min-height : 35px;
    }

    .comment-btn {
      font-size:10pt;
      color : black;
      background-color: #eff0f2;
      text-decoration: none;
      padding : 9px 10px 9px 10px;
      border-radius: 5px;
      float : right;
    }

    #btn-write-comment, #btn-write-reply {
      color : #009f47;
      background-color: #e0f8eb;
    }

    #btn-cancel-reply {
      background-color: #eff0f2;
      margin-right : 10px;
    }

    #btn-write-modify {
      color : #009f47;
      background-color: #e0f8eb;
    }

    #btn-cancel-modify {
      margin-right : 10px;
    }

    #reply-writebox {
      display : none;
      background-color: white;
      border : 1px solid #e5e5e5;
      border-radius: 5px;
      margin : 10px;
    }

    #reply-writebox-bottom {
      padding : 3px 10px 10px 10px;
      min-height : 35px;
    }

    #modify-writebox {
      background-color: white;
      border : 1px solid #e5e5e5;
      border-radius: 5px;
      margin : 10px;
    }

    #modify-writebox-bottom {
      padding : 3px 10px 10px 10px;
      min-height : 35px;
    }

    /* The Modal (background) */
    .modal {
      display: none; /* Hidden by default */
      position: fixed; /* Stay in place */
      z-index: 1; /* Sit on top */
      padding-top: 100px; /* Location of the box */
      left: 0;
      top: 0;
      width: 100%; /* Full width */
      height: 100%; /* Full height */
      overflow: auto; /* Enable scroll if needed */
      background-color: rgb(0,0,0); /* Fallback color */
      background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }

    /* Modal Content */
    .modal-content {
      background-color: #fefefe;
      margin: auto;
      padding: 20px;
      border: 1px solid #888;
      width: 50%;
    }

    /* The Close Button */
    .close {
      color: #aaaaaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
    }

    .close:hover,
    .close:focus {
      color: #000;
      text-decoration: none;
      cursor: pointer;
    }



    .paging {
      color: black;
      width: 100%;
      text-align: center;
    }

    .page {
      color: black;
      text-decoration: none;
      padding: 6px;
      margin-right: 10px;
    }

    .paging-active {
      background-color: rgb(216, 216, 216);
      border-radius: 5px;
      color: rgb(24, 24, 24);
    }

    .paging-container {
      width:100%;
      height: 70px;
      margin-top: 50px;
      margin : auto;
    }
  </style>
</head>
<body>
<div id="commentList">
  <!-- 댓글 리스트 보여주는 부분 -->
  <div id="commentList_List">
    <!-- 댓글 리스트 보여주는 부분 -->
  </div>
  </br>
  <!-- 페이징 처리 : 수정 필요 -->
  <%--<div class="paging-container">
    <div class="paging">
      <c:if test="${totalCnt==null || totalCnt==0}">
        <div> 댓글이 없습니다. </div>
      </c:if>
      <c:if test="${totalCnt!=null && totalCnt!=0}">
        <c:if test="${ph.showPrev}">
          <a class="page" href="<c:url value="/board/list${ph.sc.getQueryString(ph.beginPage-1)}"/>">&lt;</a>
        </c:if>
        <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
          <a class="page ${i==ph.sc.page? "paging-active" : ""}" href="<c:url value="/board/list${ph.sc.getQueryString(i)}"/>">${i}</a>
        </c:forEach>
        <c:if test="${ph.showNext}">
          <a class="page" href="<c:url value="/board/list${ph.sc.getQueryString(ph.endPage+1)}"/>">&gt;</a>
        </c:if>
      </c:if>
    </div>
  </div>--%>

  <!-- 댓글 입력창 -->
  <div id="comment-writebox">
    <div class="commenter commenter-writebox">${id}</div>
    <div class="comment-writebox-content">
      <textarea class = "comment-textarea" id="comment_comment" cols="30" rows="3" placeholder="댓글을 남겨보세요"></textarea>
    </div>
    <div id="comment-writebox-bottom">
      <div class="register-box">
        <a href="#" class="comment-btn" id="btn-write-comment">등록</a>
      </div>
    </div>
  </div>
</div>

<!-- 답글 입력 창 -->
<div id="reply-writebox">
  <div class="commenter commenter-writebox">${id}</div>
  <div class="reply-writebox-content">
    <textarea class = "comment-textarea" id="comment_reply" cols="30" rows="3" placeholder="댓글을 남겨보세요"></textarea>
  </div>
  <div id="reply-writebox-bottom">
    <div class="register-box">
      <a href="#" class="comment-btn" id="btn-write-reply">등록</a>
      <a href="#" class="comment-btn" id="btn-cancel-reply">취소</a>
    </div>
  </div>
</div>

<!-- 댓글 수정 창 -->
<div id="modalWin" class="modal">
  <!-- Modal content -->
  <div class="modal-content">
    <span class="close">&times;</span>
    <p>
    <h2> | 댓글 수정</h2>
    <div id="modify-writebox">
      <div class="commenter commenter-writebox"></div>
      <div class="modify-writebox-content">
        <textarea class = "comment-textarea" id="comment_update" cols="30" rows="5" placeholder="댓글을 남겨보세요"></textarea>
      </div>
      <div id="modify-writebox-bottom">
        <div class="register-box">
          <a href="#" class="comment-btn" id="btn-write-modify">등록</a>
        </div>
      </div>
    </div>
    </p>
  </div>
</div>

<script>
  let bno = ${boardDto.bno};
  // example bno = 1181;
  // let bno = 1181;
  let id = "<%=(String)session.getAttribute("id")%>";

  let addZero = function(value=1){
    return value > 9 ? value : "0"+value;
  }

  let dateToString = function(ms=0) {
    let date = new Date(ms);

    let yyyy = date.getFullYear();
    let mm = addZero(date.getMonth() + 1);
    let dd = addZero(date.getDate());

    let HH = addZero(date.getHours());
    let MM = addZero(date.getMinutes());
    let ss = addZero(date.getSeconds());

    return yyyy+"."+mm+"."+dd+ " " + HH + ":" + MM + ":" + ss;
  }

  <!-- 댓글 리스트 보여주기 -->
  let showList = function (bno){
    $.ajax({
      type:'GET',
      url: '/ch4/comments?bno='+bno,
      success : function(result){
        $("#commentList_List").html(toHtml(result));
      },
      error : function (){alert("error")}
    });
  }

  let toHtml = function(comments){
    let tmp = '<ul class="comment-ul">';

    comments.forEach(function (comment){
      tmp += '<li class="comment-item" '
      // 답글일 경우
      if(comment.cno != comment.pcno)
        tmp += ' style="padding-left: 40px;"'
      tmp += ' data-cno='+comment.cno+' data-pcno='+comment.pcno+' data-bno='+comment.bno+'>'
      tmp += '<span class="comment-img">'
      tmp += ' <i class="fa fa-user-circle" aria-hidden="true"></i>'
      tmp += '</span>'
      tmp += '<div class="comment-area">'
      tmp += '<div class="commenter">'+comment.commenter+'</div>'
      tmp += '<div class="comment-content">'+comment.comment+'</div>'
      tmp += '</div>'
      tmp += '<div class="comment-bottom">'
      tmp += '<span class="up_date">'+dateToString(comment.up_date)+'</span>'
      // 댓글 일 경우 만
      if(comment.cno == comment.pcno)
        tmp += '<a href="#" class="btn-write"  data-cno='+comment.cno+' data-bno='+comment.bno+' data-pcno="">답글쓰기</a>'
      // 세션 아이디와 작성자가 같은 경우에만 수정, 삭제 버튼 보여주기
      if(comment.commenter == id){
        tmp += '<a href="#" class="btn-modify"  data-cno='+comment.cno+' data-bno='+comment.bno+' data-pcno="">수정</a>'
        tmp += '<a href="#" class="btn-delete"  data-cno='+comment.cno+' data-bno='+comment.bno+' data-pcno="">삭제</a>'
      }
      tmp += '</div>'
      tmp += '</div>'
      tmp += '</li>'
    })

    return tmp += '</ul>';
  }

  $(document).ready(function(){
    showList(bno);
    <!-- 답글 관련 -->
    <!-- 답글쓰기 -->
    $("#commentList").on("click", ".btn-write", function(e){
      let target = e.target;
      let cno = target.getAttribute("data-cno")
      let bno = target.getAttribute("data-bno")
      let pcno = $(this).parent().attr("data-pcno");

      let repForm = $("#reply-writebox");
      repForm.appendTo($("li[data-cno="+cno+"]"));
      repForm.css("display", "block");
      repForm.attr("data-pcno", pcno);
      repForm.attr("data-bno",  bno);
    });

    <!-- 답글 등록 -->
    $("#btn-write-reply").click(function(){
      let comment = $("#comment_reply").val();
      let pcno = $('#reply-writebox').parent().attr("data-pcno");

      if(comment.trim()==''){
        alert("댓글을 입력해주세요.");
        $("textarea[id=comment_reply]").focus();
        return;
      }

      // 서버 전송
      $.ajax({
        type:'POST',  // 요청 메서드
        url: '/ch4/comments?bno='+bno, // 요청 URL
        headers : {"content-type" : "application/json"}, // 요청 헤더
        dataType : 'text', // 전송받을 데이터의 타입
        data : JSON.stringify({pcno: pcno, bno:bno, comment:comment}), // 서버로 전송할 데이터. stringify로 직렬화
        success : function(result){
          alert(result);
          showList(bno);
        },
        error : function(){alert("error")}
      }); // $.ajax()

    });

    $("#btn-cancel-reply").click(function(e){
      $("#reply-writebox").css("display", "none");
    });

    <!-- 댓글 관련 -->
    <!-- 댓글 등록 -->
    $("#btn-write-comment").click(function(){
      let comment = $("#comment_comment").val();
      let cno = $(this).attr("data-cno");

      if(comment.trim()==''){
        alert("댓글을 입력해주세요.");
        $("textarea[id=comment_comment]").focus();
        return;
      }

      $.ajax({
        type:'POST',  // 요청 메서드
        url: '/ch4/comments?bno='+bno, // 요청 URL
        headers : {"content-type" : "application/json"}, // 요청 헤더
        dataType : 'text', // 전송받을 데이터의 타입
        data : JSON.stringify({bno:bno, comment:comment}), // 서버로 전송할 데이터. stringify로 직렬화
        success : function(result){
          alert(result);
          showList(bno);
        },
        error : function(){alert("error")}
      }); // $.ajax()

      //초기화 작업
      $("textarea[id=comment_comment]").val('');
      $("textarea[id=comment_comment]").placeholder("댓글을 남겨보세요");

    });

    <!-- 댓글 삭제 -->
    $("#commentList").on("click", ".btn-delete", function(){
      let cno = $(this).attr("data-cno");
      let bno = $(this).attr("data-bno");
      $.ajax({
        type:'DELETE',  // 요청 메서드
        url: '/ch4/comments/'+cno+'?bno='+bno, // 요청 URL
        success : function(result){
          alert(result)
          showList(bno);
        },
        error : function(){alert("error")}
      }); // $.ajax()
    });

    <!-- 댓글 수정 -->
    $("#commentList").on("click", ".btn-modify", function(e){
    let target = e.target;
    let cno = target.getAttribute("data-cno");
    let bno = target.getAttribute("data-bno");
    let pcno = target.getAttribute("data-pcno");
    let li = $("li[data-cno="+cno+"]");
    let commenter = $(".commenter", li).first().text();
    let comment = $(".comment-content", li).first().text();

    $("#modalWin .commenter").text(commenter);
    $("#modalWin textarea").text(comment);
    $("#btn-write-modify").attr("data-cno", cno);
    $("#btn-write-modify").attr("data-pcno", pcno);
    $("#btn-write-modify").attr("data-bno", bno);

    // 팝업창을 열고 내용을 보여준다.
    $("#modalWin").css("display","block");
  });

  $("#btn-write-modify").click(function(){

    let comment = $("#comment_update").val();
    let cno = $(this).attr("data-cno");

    if(comment.trim()==''){
      alert("댓글을 입력해주세요.");
      $("textarea[id=comment_update]").focus();
      return;
    }

    // 1. 변경된 내용을 서버로 전송
    $.ajax({
      type:'PATCH',  // 요청 메서드
      url: '/ch4/comments/'+cno, // 요청 URL
      headers : {"content-type" : "application/json"}, // 요청 헤더
      dataType : 'text', // 전송받을 데이터의 타입
      data : JSON.stringify({cno:cno, comment:comment}), // 서버로 전송할 데이터. stringify로 직렬화
      success : function(result){
        alert(result);
        showList(bno);
      },
      error : function(){alert("error")}
    }); // $.ajax()

    // 2. 모달 창을 닫는다.
    $(".close").trigger("click");
  });

    $(".close").click(function(){
      $("#modalWin").css("display","none");
    });
  });
</script>
</body>
</html>
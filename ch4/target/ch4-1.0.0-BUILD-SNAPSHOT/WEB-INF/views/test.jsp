<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<br>
<h2>commentTest</h2>
comment : <input type="text" name="comment"><br>
<button id="sendBtn" type="button">SEND</button>
<button id="modBtn" type="button">수정</button>
<div id="commentList"></div>
<div id="replyForm" style="display:none">
    <input type="text" name="replyComment">
    <button id="wrtRepBtn" type="button">등록</button>
</div>
<script>
    let bno = 739;

    <!-- 댓글 리스트 보여주기 -->
    let showList = function(bno){
        $.ajax({
            type:'GET',  // 요청 메서드
            url: '/ch4/comments?bno='+bno, // 요청 URL
            success : function(result){
                $("#commentList").html(toHtml(result)); //  서버로 부터 응답이 도착하면 호출될 데이터, 역직렬화
            },
            error : function(){alert("error")}
        }); // $.ajax()
    }

    $(document).ready(function (){
        showList(bno);
        <!-- 댓글 작성 -->
        $("#sendBtn").click(function (){
            let comment = $("input[name=comment]").val();

            if(comment.trim()==''){
                alert("댓글을 입력해주세요.");
                $("input[name=comment]").focus();
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

        });

        // $(".delBtn").click(function (){
        //     alert("delBtn clicked")
        // });
        // 동적으로 생성된 곳에 이벤트 거는 방법
        <!-- 댓글 삭제 -->
        $("#commentList").on("click", ".delBtn", function (){
            let cno = $(this).parent().attr("data-cno");
            let bno = $(this).parent().attr("data-bno");
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
        $("#commentList").on("click", ".modBtn", function (){
            let cno = $(this).parent().attr("data-cno");
            // 클릭된 버튼$(this).parent()의 span.comment값만 가져오게된다.
            let comment = $('span.comment', $(this).parent()).text();

            // 1. comment의 내용을 input에 뿌려주기
            $("input[name=comment]").val(comment);
            // 2. cno 전달하기
            $("#modBtn").attr("data-cno", cno);

        });

        $("#modBtn").click(function (){
            $("input[name=comment]").focus();

            let comment = $("input[name=comment]").val();
            // 버튼에 저장해놓아서 가져올 수 있음.
            let cno = $(this).attr("data-cno");

            if(comment.trim()==''){
                alert("댓글을 입력해주세요.");
                $("input[name=comment]").focus();
                return;
            }

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

        });

        <!-- 답글 -->
        $("#commentList").on("click", ".replyBtn", function (){
            // 1. replyForm을 옮기고
            $('#replyForm').appendTo($(this).parent());
            // 2. 답글을 입력할 폼을 보여주고,
            $('#replyForm').css("display", "block");
        });

        <!-- 답글 등록 -->
        $("#wrtRepBtn").click(function (){
            let comment = $("input[name=replyComment]").val();
            let pcno = $('#replyForm').parent().attr("data-pcno");

            if(comment.trim()==''){
                alert("답글을 입력해주세요.");
                $("input[name=replyComment]").focus();
                return;
            }

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

            // 초기화 작업
            $('#replyForm').css("display", "none");
            $("input[name=replyComment]").val('');
            $('#replyForm').appendTo("body");

        });

    });


    let toHtml = function(comments){
        let tmp = "<ul>";

        comments.forEach(function (comment){
            tmp += '<li data-cno='+ comment.cno
            tmp += ' data-pcno=' + comment.pcno
            tmp += ' data-bno=' + comment.bno + '>'
            if(comment.cno != comment.pcno)
                tmp += 'ㄴ'
            tmp += ' commenter=<span class="commenter">' + comment.commenter + '</span>'
            tmp += ' comment=<span class="comment">' + comment.comment + '</span>'
            tmp += ' up_date=' + comment.up_date
            tmp += '<button class="delBtn">삭제</button>'
            tmp += '<button class="modBtn">수정</button>'
            tmp += '<button class="replyBtn">답글</button>'
            tmp += '</li>'
        })

        return tmp + '</ul>'
    }
</script>
</body>
</html>
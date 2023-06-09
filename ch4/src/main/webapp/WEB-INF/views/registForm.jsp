<%--
  Created by IntelliJ IDEA.
  User: dntdm
  Date: 2023-01-12
  Time: 오후 9:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
  <style>
    * { box-sizing:border-box; }
    form {
      width:400px;
      height:600px;
      display : flex;
      flex-direction: column;
      align-items:center;
      position : absolute;
      top:50%;
      left:50%;
      transform: translate(-50%, -50%) ;
      border: 1px solid rgb(48,66,110);
      border-radius: 10px;
    }
    .input-field {
      width: 300px;
      height: 40px;
      border : 1px solid rgb(48,66,110);
      border-radius:5px;
      padding: 0 10px;
      margin-bottom: 10px;
    }

    label {
      width:300px;
      height:30px;
      margin-top :4px;
    }
    button {
      background-color: rgb(48,66,110);
      color : white;
      width:300px;
      height:50px;
      font-size: 17px;
      border : none;
      border-radius: 5px;
      margin : 20px 0 30px 0;
    }
    .title {
      font-size : 50px;
      margin: 40px 0 30px 0;
    }
    .msg {
      height: 30px;
      text-align:center;
      font-size:16px;
      color:red;
      margin-bottom: 20px;
    }

    .sns-chk {
      margin-top : 5px;
    }
  </style>
  <title>Register</title>
</head>
<body>
<form action="<c:url value="/register/save"/>" method="post" onsubmit="return formCheck(this)">
  <div class="title">Register</div>
  <div id="msg" class="msg"><form:errors path="id"/></div>
  <label for="">아이디</label>
  <input class="input-field" type="text" name="id" placeholder="8~12자리이상 영문,숫자 조합">
  <label for="">비밀번호</label>
  <input class="input-field" type="password" name="pwd" placeholder="8~12자리이상 영문,숫자 조합">
  <label for="">이름</label>
  <input class="input-field" type="text" name="name" placeholder="홍길동">
  <label for="">이메일</label>
  <input class="input-field" type="text" name="email" placeholder="example@fastcampus.co.kr">
  <label for="">생일</label>
  <input class="input-field" type="date" name="birth" placeholder="2020-12-31">
  <div class="sns-chk">
    <label><input type="checkbox" name="sns" value="facebook"/>페이스북</label>
    <label><input type="checkbox" name="sns" value="kakaotalk"/>카카오톡</label>
    <label><input type="checkbox" name="sns" value="instagram"/>인스타그램</label>
  </div>
  <button>회원 가입</button>
</form>
<script>
  function formCheck(frm) {
    let msg ='';

    var id_chk = /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{8,12}$/g.test(frm.id.value);
    if(!id_chk) {
      setMessage('id는 8~12자리이상 영문,숫자 조합이여야 합니다.', frm.id);
      return false;
    }

    var pwd_chk = /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{8,12}$/g.test(frm.pwd.value);
    if(!pwd){
      setMessage('패스워드는 8~12자리이상 영문,숫자 조합이여야 합니다.', frm.pwd);
      return false;
    }

    if(frm.name.value == null || frm.name.value == ''){
        setMessage('이름을 입력해주세요.', frm.name);
        return false;
    }

    if(frm.email.value == null || frm.email.value == ''){
      setMessage('이메일을 입력해주세요.', frm.email);
      return false;
    }

    if(frm.birth.value == null || frm.birth.value == ''){
      setMessage('생일을 입력해주세요.', frm.birth);
      return false;
    }

    return true;
  }
  function setMessage(msg, element){
    document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
    if(element) {
      element.select();
    }
  }
</script>
</body>
</html>

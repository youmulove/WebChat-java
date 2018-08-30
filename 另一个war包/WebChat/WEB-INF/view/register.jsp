<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
  <title>WebChat | 注册</title>
  <script src="<%=path%>/static/plugins/jquery/jquery-2.1.4.min.js"></script>
  <script src="<%=path%>/static/plugins/layer/layer.js"></script>
<style type="text/css">
.divForm{
position: absolute;/*绝对定位*/
width: 200px;
height: 280px;
color: #666;
text-align: center;/*(让div中的内容居中)*/
top: 50%;
left: 50%;
margin-top: -200px;
margin-left: -150px;
}
#submit{
  font-size: 18px;
  color: #fff;
  outline: none;
  border: none;
  background: #4ea751;
  width: 100%;
  padding: 5px 0;
}
</style>
</head>
<body background="<%=path%>/static/source/img/bg5.jpg">


<div class="divForm">
	<div><img src="<%=path%>/static/source/img/avtar.png" /></div>
  <form id="register_form" action="" method="post" onsubmit="return checkLoginForm()">
			<table >
				<tr>
					<td>账号:</td>
					<td><input type="text" id="username" name="userid"  placeholder="设置账号"></td>
				</tr>
				<tr>
					<td>密码:</td>
					<td><input type="password" id="password" name="password"  placeholder="设置密码"></td>
				</tr>
				<tr>
					<td>昵称:</td>
					<td><input type="text" id="nickname" name="nickname" placeholder="设置昵称"></td>
				</tr>
				<tr>
					<td>性别:</td>
					<td><input type="radio" name="sex" value="1" checked>男<input type="radio" name="sex" value="0">女</td>
				</tr>
				<tr>
					<td>年龄:</td>
					<td><input type="text" id="age" name="age" placeholder="输入年龄"></td>
				</tr>
				<tr>
					<td>简介:</td>
					<td><input type="text" id="profile" name="profile"  placeholder="输入你想说的信息..."></td>
				</tr>
			</table>
			<div>
		      <input type="button" id="submit" onclick="saveRegister()" value="注册" >
		    </div>
    
  </form>
</div>

<script>
function saveRegister() {
if(checkLoginForm()){
			$.post("<%=basePath%>user/saveRegister",$("#register_form").serialize(),function(data){
				if(data=="success"){
				alert("成功注册")
				window.location.href="<%=basePath%>user/login";
				}else{
				alert("用户已注册")
				window.location.reload();
				}
			});
			}
		}
  /**
   * check the login form before user login.
   * @returns {boolean}
   */
  function checkLoginForm(){
    var username = $('#username').val();
    var password = $('#password').val();
    if(isNull(username) && isNull(password)){
      $('#submit').attr('value','请输入账号和密码!!!').css('background','red');
      return false;
    }
    if(isNull(username)){
      $('#submit').attr('value','请输入账号!!!').css('background','red');
      return false;
    }
    if(isNull(password)){
      $('#submit').attr('value','请输入密码!!!').css('background','red');
      return false;
    }
    else{
      $('#submit').attr('value','Logining~');
      return true;
    }
  }

  /**
   * check the param if it's null or '' or undefined
   * @param input
   * @returns {boolean}
   */
  function isNull(input){
    if(input == null || input == '' || input == undefined){
      return true;
    }
    else{
      return false;
    }
  }
</script>
</body>
</html>
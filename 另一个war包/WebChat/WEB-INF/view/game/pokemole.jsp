<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>打地鼠</title>

<style type="text/css">
img{cursor:url('${ctx}/static/images/mouse.ani');}
</style>

<script language="JavaScript">
var no1,no2,no3,no4;
var gameTime,spaceTime,stayTime;
var button1,button2;
var time;
var sum=0;
var mouse=0;
function onGame(){
	init();
	no1=window.setInterval("showTime()",1000);	
	no2=setInterval("showImage()",1000);
}
function init(){
	gameTime=document.getElementById("gameTime");
	spaceTime=document.getElementById("spaceTime");
	stayTime=document.getElementById("stayTime");
	gameTime.disabled=true;
	spaceTime.disabled=true;
	stayTime.disabled=true;
	button1=document.getElementById("button1"); 
	button2=document.getElementById("button2");
	button1.disabled=true;
	button2.disabled=false;
	time=parseInt(gameTime.value)*60;
	sum=0;
	mouse=0;
}   
	
	
function showTime(){  
	document.getElementById("time").innerHTML=time;
	time-=1;
	if(time<=0){
		esc();
	}
	var str="打中："+mouse+"只  漏掉："+(sum-mouse)+"只"+"<br>"+" 总分："+sum*100+"  得分："+(mouse*100-(sum-mouse)*100);
	document.getElementById("score").innerHTML=str;
}
function showImage(){  
     var images=document.getElementsByName("image");
     var index=Math.floor(Math.random()*25);
     images[index].src="${ctx}/static/images/01.jpg";
	 sum+=1;
	 no3=setTimeout("stopImage("+index+")",parseInt(stayTime.value)*1000);
}    
function stopImage(index){
     
	 document.images[index].src="${ctx}/static/images/00.jpg";
	
}     
function leaveImage(o){
     
	 o.src="${ctx}/static/images/00.jpg";
	
}
function clickMouse(o){
      var str=o.src.substr(o.src.length-6,6);
	  if(str=="01.jpg"){
	   o.src="${ctx}/static/images/02.jpg";
	   mouse+=1;
	   no4=setInterval("leaveImage(o)",100);
	  }
}
function esc(){
	window.clearInterval(no1);
	window.clearInterval(no2);
	window.clearTimeout(no3);
	window.clearInterval(no4);
	gameTime.disabled=false;
	spaceTime.disabled=false;
	stayTime.disabled=false;
	button1.disabled=false;
	var images=document.getElementsByName("image");
	for(var i=0;i<images.length;i++){
		images[i].src="${ctx}/static/images/00.jpg";
	}
}
</script>
</head>

<body background="${ctx}/static/images/bg.jpg" >
<bgsound  src="${ctx}/static/images/bgsound.mp3" loop="-1">

<table align="center">
	<tr>
		<td><font color="#0066FF">游戏说明:</font></td>
	</tr>
	<tr>
		<td>
			<font color="#0066FF">点击“开始游戏”按钮，在下图中随机产生老鼠，老鼠消失前单击老鼠进行击打，<br>打中一次即可获得100的积分，没有打中老鼠，扣取100积分。快快行动吧，考验您的<br>反应和眼力！</font>
		</td>
	</tr>
</table>
<br />
<br />

<table align="center" cellspacing="5">
	<tr>
		<td>
			<table cellspacing="3">
				<tr>
					<td>--游戏时间:--</td>
					<td><input type="text" width="6" id="gameTime" value="1"/> 分钟</td>
				</tr>
				<tr>
					<td>--倒计时间:--</td>
					<td><div id="time"></div></td>
				</tr>
				<tr>
					<td>--地鼠出现间隔:--</td>
					<td><input type="text" width="6" id="spaceTime" value="1"/> 秒钟</td>
				</tr>
				<tr>
					<td>--停留时间:--</td>
					<td><input type="text" width="6" id="stayTime" value="1"/> 秒钟</td>
				</tr>
				<tr>
					<td>--得分情况:--</td>
					<td><div id="score"></div></td>
				</tr>
				<tr align="center">
					<td ><input type="button" value="开始游戏" id="button1" onclick="onGame()"/></td>
					<td><input type="button" value="退出游戏" id="button2" disabled onclick="esc()"/></td>
					<td><button class="button"  onclick="javascript:history.go(-1)">退出</button></td>
				</tr>
			</table>
		</td>
		<td>
			<table border="1"  cellspacing="3" bgcolor="white">
				<tr>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
				</tr>
				<tr>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
				</tr>
				<tr>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
				</tr>
				<tr>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
				</tr>
				<tr>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
					<td><img src="${ctx}/static/images/00.jpg" name="image" onclick="clickMouse(this)"/></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<div style="text-align:center;">
</div>
</body>
</html>

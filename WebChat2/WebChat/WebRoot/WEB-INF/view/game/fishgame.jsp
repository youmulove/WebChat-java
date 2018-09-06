﻿<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta charset="UTF-8">
<title>大鱼吃小鱼</title>
<link rel="shortcut icon" href="${ctx}/static/images/fish/fish.ico" type="image/x-icon">
<script src="${ctx}/static/source/js/jquery.min.js"></script>
<style type="text/css">
*{font-family:"Scerh",sans-serif}
.jdtstt{border:1px solid #000;}
.rightsty{transform:rotateY(180deg);-webkit-transform:rotateY(180deg);-moz-transform:rotateY(180deg);}
.trans{background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQImWNgYGBgAAAABQABh6FO1AAAAABJRU5ErkJggg==)}
html,body{overflow:hidden;}
input[type="button"]{background-color:#fff;border:1px solid #808080;cursor:pointer}
</style>
</head>
<body>
<div style="width:100%;height:50px;background-color:#888;position:absolute;left:0;top:-50px;z-index:10000" class="title-head">
<div style="width:10%;height:50px;display:inline-block">
分数<br><span class="Score">0</span>
</div><div style="width:10%;height:50px;display:inline-block">
生命<br><span class="Life">20</span>
</div><div style="width:10%;height:50px;display:inline-block">
等级<br><span class="Level">1</span>
</div><div style="width:10%;height:50px;display:inline-block;text-align:right">
生命进度<br>等级进度
</div>
<div style="width:59%;height:50px;display:inline-block">
<div style="width:100%;height:15px;display:inline-block;" class="jdtstt">
 <div style="width:0%;height:15px;display:inline-block;background-color:#f21255" class="jdtsww1"></div>
</div>
<div style="width:100%;height:15px;display:inline-block;" class="jdtstt">
 <div style="width:0%;height:15px;display:inline-block;background-color:#72f3fe" class="jdtsww2"></div>
</div>
</div>
</div>
<div style="position:absolute;left:0;top:0;width:100%;height:100%;z-index:10" class="gamestt">
<img src="${ctx}/static/images/fish/fish.png" width="50px" style="position:absolute;left:0;top:0;transition:transform 0.5s;margin:-25px 0 0 -25px;visibility:hidden" class="fish">
</div>


<div style="width:100%;height:100%;position:absolute;left:0;top:0;z-index:12000;" class="mainmenu">
<br><br><br><br><br><center style="font-size:80px;">大鱼吃小鱼</center><br><br>
<center><input type="button" value="开始游戏" onclick="startgame()" style="font-size:25px"></center><br>
<center><input type="button" value="游戏说明" onclick="$('.mainmenu').hide();$('.explain').show()" style="font-size:25px"></center>
</div>

<div style="width:100%;height:100%;position:absolute;left:0;top:0;z-index:12000;display:none" class="explain">
<br><br><br><br><br>
<center style="font-size:80px;">游戏说明</center>
<center>哇哦，大鱼吃小鱼jQuery版。美丽的大海，灿烂的珊瑚。吃小鱼了！！<br>放飞梦想，全部鱼群。好玩的游戏，小鱼来吃呀！<br>小心，这个等级过小，这个大的鱼扣除生命<br>作者：放飞的你们<br><br>站长素材<input type="button" value="关闭" onclick="$('.mainmenu').show();$('.explain').hide()"></center>

</div>

<div style="width:100%;height:100%;position:absolute;left:0;top:0;z-index:12000;display:none" class="gameover">
<br><br><br><br><br>
<center style="font-size:80px;">游戏结束</center>
<center><input type="button" value="重新开始" onclick="startgame()" style="font-size:25px"></center><br>
<center><input type="button" value="返回主菜单" onclick="$('.mainmenu').show();$('.gameover').hide();$('.title-head').animate({top:'-50px'});" style="font-size:25px"></center>

</div>


<img src="${ctx}/static/images/fish/bg.jpg" style="position:absolute;left:0;top:0;left:0;top:0;width:100%;height:100%">
<script type="text/javascript">
var fish_a_1=0,fish_a_2=0,score=0,life=20,level=1,lifest=0,lvst=0,lvmax=5,lvaccd=1,gamestyle
$(".gamestt").bind("mousemove",function(event){
var event=event||window.event
$(".fish").css({left:event.clientX+"px",top:event.clientY+"px"}).show()
fish_a_1=event.clientX
if(fish_a_1>fish_a_2){$(".fish").addClass("rightsty")}else{$(".fish").removeClass("rightsty")}
fish_a_2=event.clientX
})
$(".title-head").bind("mouseover",function(){
$(".fish").hide()
})
var dedeabc=1
function fishaa(){
dedeabc++
var acbb=(Math.floor(Math.random()*lvaccd)+1)
if(Math.random()>0.5){
 $(".gamestt").append("<img src='${ctx}/static/images/fish/fish"+acbb+".png' class='abccaae"+dedeabc+"' style='position:absolute;left:100%;top:"+(10+(Math.random()*70))+"%' onmouseover='abcyu(this,"+acbb+")'>")
 $(".abccaae"+dedeabc).animate({left:"-126px"},(Math.random()*8000)+2000,"linear",function(){$(this).remove()})
}else{
 $(".gamestt").append("<img src='${ctx}/static/images/fish/fish"+acbb+".png' class='abccaae"+dedeabc+" rightsty' style='position:absolute;right:100%;top:"+(10+(Math.random()*70))+"%' onmouseover='abcyu(this,"+acbb+")'>")
 $(".abccaae"+dedeabc).animate({right:"-126px"},(Math.random()*8000)+2000,"linear",function(){$(this).remove()})
}
}
function smjds(i){
lifest+=i;if(lifest>=500){lifest=0;life+=10;$(".Life").html(life)}
$(".jdtsww1").css("width",((lifest/500)*100)+"%")

lvst++;if(lvst>=lvmax){lvst=0;level+=1;lvmax+=5;$(".Level").html(level)}
$(".jdtsww2").css("width",((lvst/lvmax)*100)+"%")
}
function abcyu(i,j){
if(!(j==lvaccd&&Math.random()>0.9)){
 $(i).remove()
 score+=(10*j)*level;$(".Score").html(score)
 smjds(10)
}else{
 life--;$(".Life").html(life)
 if(life==0){$(".gameover").show();$(".fish").css("visibility","hidden");clearTimeout(gamestyle)}
}
if(level==3){lvaccd=2}
if(level==10){lvaccd=3}
if(level==20){lvaccd=4}
if(level==30){lvaccd=5}
if(level==40){lvaccd=6}
if(level==50){lvaccd=7}
if(level==60){lvaccd=8}
}
function awwae(){fishaa();gamestyle=setTimeout(awwae,Math.random()*1000)}
setInterval(function(){lifest--;if(lifest<=0){lifest=0;};$(".jdtsww1").css("width",((lifest/500)*100)+"%")},100)
function startgame(){
score=0;life=20;level=1;lifest=0;lvst=0;lvmax=5;lvaccd=1
gamestyle=setTimeout(awwae,Math.random()*1000)
$(".mainmenu,.gameover").hide();$(".fish").css("visibility","");$(".title-head").animate({top:"0px"});
$(".Score").html(score);$(".Life").html(life);$(".Level").html(level);$(".jdtsww1").css("width","0%");$(".jdtsww2").css("width","0%")
}
</script>
</body>
</html>


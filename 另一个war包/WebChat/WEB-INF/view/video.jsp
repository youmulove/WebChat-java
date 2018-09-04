<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<title>视频通话</title>
<meta charset="utf-8" />
<script src="${ctx}/static/plugins/jquery/jquery-2.1.4.min.js"></script>
<script src="${ctx}/static/plugins/layer/layer.js"></script>
<style type="text/css">
* {
    margin: 0;
    padding: 0;
    overflow-y:hidden; 
}

body {
}

#main {
    display: none;
/*     -webkit-transition-property: rotation;
    -webkit-transition-duration: 2s; */
    text-align: center;
/*     -webkit-transform-style: preserve-3d; */
    width: 1200px;
    margin: 0 auto;
    padding: 60px 0;
}

#localVideo {
    box-shadow: 0 0 20px #000;
    width: 600px;
    display: inline-block;
}

#remoteVideo {
    box-shadow: 0 0 20px #000;
    width: 500px;
    height: 400px;
    display: none;
}

#miniVideo {
    box-shadow: 0 0 20px #000;
    width: 250px;
    height: 200px;
    display: none;
}

#footer {
    position: absolute;
    bottom: 0;
    width: 100%;
    height: 28px;
    background-color: #404040;
    color: #fff;
    font-size: 13px;
    font-weight: bold;
    line-height: 28px;
    text-align: center;
}

.browser {
    box-shadow: 0 0 20px #000 inset;
    width: 400px;
    margin: 200px auto;
    padding: 20px;
    text-align: center;
    color: #fff;
    font-weight: bold;
}
@media screen /* and (-webkit-min-device-pixel-ratio:0) */ {
    #main {
        display: block;
    }
    .browser {
        display: none;
    }
}
</style>
</head>
<body background="${ctx}/static/source/img/2.png">

     <div class="browser">欢迎使用！</div>
    <div id="main">
        <div ><video id="localVideo" autoplay="autoplay"></video></div>
        <div id="test"></div>
    </div>
    <input type="hidden" id="uid" value="${uid}" >
     <input type="hidden" id="oid" value="${oid}" >
    <div id="footer"></div>
    <script type="text/javascript">
    var uid=$("#uid").val();
    var oid=$("#oid").val();
        var pc;
        var main; // 视频的DIV
        var socket; // websocket
        var localVideo; // 本地视频
        var miniVideo; // 本地小窗口
        var remoteVideo; // 远程视频
        var localStream; // 本地视频流
        var remoteStream; // 远程视频流
        var localVideoUrl; // 本地视频地址
        var initiator = ${requestScope.initiator}; // 是否已经有人在等待

        var started = false; // 是否开始
        var channelReady = false; // 是否打开websocket通道
 
        var channelOpenTime;
        var channelCloseTime;
        //连接类
        var PeerConnection = window.PeerConnection || window.webkitPeerConnection00
                || window.webkitRTCPeerConnection || window.mozRTCPeerConnection;

        //RTC对话类
        var RTCSessionDescription = window.mozRTCSessionDescription
                || window.RTCSessionDescription;

        //RTC候选对象
        var RTCIceCandidate = window.mozRTCIceCandidate || window.RTCIceCandidate;

        //获取本地媒体流对象
        navigator.getMedia = (navigator.getUserMedia
                || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia);

        //获取远程媒体流URL
        var URL = window.URL || window.webkitURL || window.mozURL || window.msURL || window.oURL;

        var mediaConstraints = {
            "has_audio" : true,
            "has_video" : true
        }; // 音频和视频
        // 初始化
        function initialize() {
            console.log("初始化");
        	main = document.getElementById("main");
            localVideo = document.getElementById("localVideo");
            $("#test").append("<div><video id='remoteVideo' autoplay='autoplay'></video><video id='miniVideo' autoplay='autoplay'></video></div>");
            miniVideo = document.getElementById("miniVideo");
            remoteVideo = document.getElementById("remoteVideo");

            noticeMsg();
            openChannel();
            getUserMedia();
        }

        // 获取用户的媒体
        function getUserMedia() {
            console.log("获取用户媒体");

            navigator.getMedia({
                "audio" : true,
                "video" : true
            }, onUserMediaSuccess, onUserMediaError);
        }

        // 获取用户媒体成功
        function onUserMediaSuccess(stream) {
            var url = URL.createObjectURL(stream);
            localVideo.style.display = "inline-block";
            remoteVideo.style.display = "none";

            localVideo.src = url;
            localVideoUrl = url;
            localStream = stream;

            if (initiator)
                maybeStart();
        }

        // 开始连接
        function maybeStart() {
   /*      alert(started+""+localStream+""+channelReady); */
            if (!started && localStream!=null && channelReady) {
                setNotice("连接中...");
                createPeerConnection();
                pc.addStream(localStream);
                started = true;
                if (initiator)
                    doCall();
            }
        }

        //接受显示选择
        var mediaConstraints = {
            optional: [],
            mandatory: {
                OfferToReceiveAudio: true,
                OfferToReceiveVideo: true
            }
        };

        // 开始通话
        function doCall() {
            console.log("开始呼叫");

            pc.createOffer(setLocalAndSendMessage, function() {}, mediaConstraints);
        }

        function setLocalAndSendMessage(sessionDescription) {
            pc.setLocalDescription(sessionDescription);
            sendMessage(sessionDescription);
        }

        // 发送信息
        function sendMessage(message) {
            var msgJson = JSON.stringify(message);

            socket.send(msgJson);

            console.log("发送信息 : " + msgJson);
        }

        // 打开websocket
        function openChannel() {
            console.log("打开websocket");
            socket = new WebSocket(
                    "wss://" + window.location.host + "/WebChat/video/"+uid);
//WSS是https
            socket.onopen = onChannelOpened;
            socket.onmessage = onChannelMessage;
            socket.onclose = onChannelClosed;
            socket.onerror = onChannelError;
        }

        // 设置状态
        function noticeMsg() {
            if (!initiator) {
                setNotice("呼叫中...");
            } else {
                setNotice("初始化...");
            }
        }

        // 打开连接
        function createPeerConnection() {
           /*  var server = {
                "iceServers" : [ {
                    "url" : "stun:192.168.1.111"
                } ]
            }; */
            pc = new PeerConnection(null);

            pc.onicecandidate = onIceCandidate;
            pc.onconnecting = onSessionConnecting;
            pc.onopen = onSessionOpened;
            pc.onaddstream = onRemoteStreamAdded;
            pc.onremovestream = onRemoteStreamRemoved;
        }

        // 谁知状态
        function setNotice(msg) {
            document.getElementById("footer").innerHTML = msg;
        }

        // 响应
        function doAnswer() {
            pc.createAnswer(setLocalAndSendMessage, function(error) {
                console.log('Failure callback: ' + error);
            });
        }

        // websocket打开
        function onChannelOpened() {
            console.log("websocket打开");

            channelOpenTime = new Date();
            channelReady = true;
            if (initiator)
                maybeStart();
        }

        // websocket收到消息
        function onChannelMessage(message) {
            console.log("收到信息 : " + message.data);
            processSignalingMessage(message.data);//建立视频连接
        }

        // 处理消息
        function processSignalingMessage(message) {
            var msg = JSON.parse(message);

            if (msg.type === "offer") {
                if (!initiator && !started)
                    maybeStart();
                pc.setRemoteDescription(new RTCSessionDescription(msg));
                doAnswer();
            } else if (msg.type === "answer" && started) {
                pc.setRemoteDescription(new RTCSessionDescription(msg));
            } else if (msg.type === "candidate" && started) {
                var candidate = new RTCIceCandidate({
                    sdpMLineIndex : msg.label,
                    candidate : msg.candidate
                }); 
                pc.addIceCandidate(candidate);
            } else if (msg.type === "bye" && started) {
                onRemoteClose();
            } else if (msg.type === "nowaiting") {
                onRemoteClose();
                setNotice("对方已离开！");
            }
        }

        // websocket异常
        function onChannelError(event) {
            console.log("websocket异常 ： " + event);

            //alert("websocket异常");
        }

        // websocket关闭
        function onChannelClosed() {
            console.log("websocket关闭");

            if (!channelOpenTime) {
                channelOpenTime = new Date();
            }
            channelCloseTime = new Date();
            openChannel();
        }

        // 获取用户流失败
        function onUserMediaError(error) {
            console.log("获取用户流失败！");

            alert("获取用户流失败！");
        }

        // 邀请聊天：这个不是很清楚，应该是对方进入聊天室响应函数
        function onIceCandidate(event) {
            if (event.candidate) {
                sendMessage({
                    type : "candidate",
                    label : event.candidate.sdpMLineIndex,
                    id : event.candidate.sdpMid,
                    candidate : event.candidate.candidate
                });
            } else {
                console.log("End of candidates.");
            }
        }

        // 开始连接
        function onSessionConnecting(message) {
            console.log("开始连接");
        }

        // 连接打开
        function onSessionOpened(message) {
            console.log("连接打开");
        }

        // 远程视频添加
        function onRemoteStreamAdded(event) {
            console.log("远程视频添加");
            var url = URL.createObjectURL(event.stream);
			/* alert(url); */
            miniVideo.src = localVideo.src;
            remoteVideo.src = url;
            remoteStream = event.stream;
            waitForRemoteVideo();
        }

        // 远程视频移除
        function onRemoteStreamRemoved(event) {
            console.log("远程视频移除");
        }

        // 远程视频关闭
        function onRemoteClose() {
            started = false;
            initiator = false;

            miniVideo.style.display = "none";
            remoteVideo.style.display = "none";
            localVideo.style.display = "inline-block";

            main.style.Transform = "rotateX(360deg)";

            miniVideo.src = "";
            remoteVideo.src = "";
            localVideo.src = localVideoUrl;

            setNotice("对方已断开！");

            pc.close();
            
			window.parent.location.reload();
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
        }

        // 等待远程视频
        function waitForRemoteVideo() {
            if (remoteVideo.currentTime > 0) { // 判断远程视频长度
                transitionToActive();
            } else {
                setTimeout(waitForRemoteVideo, 100);
            }
        }

        // 接通远程视频
        function transitionToActive() {
            remoteVideo.style.display = "inline-block";
            localVideo.style.display = "none";
            main.style.Transform = "rotateX(360deg)";
            setTimeout(function() {
                localVideo.src = "";
            }, 500);
            setTimeout(function() {
                miniVideo.style.display = "inline-block";
                //miniVideo.style.display = "none";
            }, 1000);

            setNotice("连接成功！");
        }

     /*    // 全屏
        function fullScreen() {
   
        }  */

        // 关闭窗口退出
        window.onbeforeunload = function() {
            sendMessage({
                type : "bye"
            });
            pc.close();
            socket.close();
        }
        setTimeout(initialize, 1); // 加载完成调用初始化方法
    </script>
</body>
</html>
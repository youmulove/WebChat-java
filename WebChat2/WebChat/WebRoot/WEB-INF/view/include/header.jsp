<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<header class="am-topbar admin-header">
    <div class="am-topbar-brand">
        <i class="am-icon-weixin"></i> <strong>WebChat</strong>
        <button id="change" class="am-btn am-btn-default">
        <i class="am-icon-book"></i>翻译
        </button> 
        <script type="text/javascript">
        $("#change").click(function(){
            translate();
        })
    </script>
        
    </div>
    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}"><span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span></button>
    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
            <li class="am-dropdown" data-am-dropdown>
                <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
                    ${user.nickname} <span class="am-icon-caret-down"></span>
                </a>
                <ul class="am-dropdown-content">
                    <li><a href="${ctx}/${user.userid}"><span class="am-icon-user"></span>个人资料</a></li>
                    <li><a href="${ctx}/${user.userid}/config"><span class="am-icon-cog am-icon-spin"></span>个人设置</a></li>
                    <li><a href="${ctx}/system"><span class="am-icon-cog am-icon-spin"></span>系统设置</a></li>
                    <li><a href="${ctx}/${user.userid}/log"><span class="am-icon-inbox"></span> 系统日志</a></li>
                    <li><a href="${ctx}/user/logout"><span class="am-icon-power-off"></span> 注销</a></li>
                </ul>
            </li>
        </ul>
    </div>
</header>
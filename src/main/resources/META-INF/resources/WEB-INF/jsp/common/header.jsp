<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="rapid" 	uri="http://www.rapid-framework.org.cn/rapid" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!-- main header -->
<div class="page-header">
    <div class="page-header-top">
        <div class="container">
            <div class="page-logo">
                <a href="${ctx}">
                    <img src="${ctx}/images/logo.png" height="40" width="130" alt="logo" class="logo-default">
                </a>
            </div>
            <a href="javascript:;" class="menu-toggler"></a>
            <div class="top-menu">
                <ul class="nav navbar-nav pull-right">
                    <li class="dropdown dropdown-user dropdown-dark">
                        <c:if test="${not empty pageContext.request.remoteUser}">
                        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                            <img alt="" class="img-circle" src="${ctx}/msun/layouts/layout3/img/avatar.png">
                            <span class="username username-hide-mobile">${pageContext.request.remoteUser}</span>
                        </a>
						<ul class="dropdown-menu dropdown-menu-default">
                            <li>
                                <a href="${ctx}/profile">
                                    <i class="icon-user"></i> 个人设置 </a>
                            </li>
                            <li class="divider"> </li>
                            <li>
                                <a href="${ctx}/logout">
                                    <i class="icon-key"></i> 退出 </a>
                            </li>
                        </ul>
						</c:if>
						
						<c:if test="${empty pageContext.request.remoteUser}">
						<a href="#" onclick="window.location.href='${ctx}/login'" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                            <span class="username username-hide-mobile">登录</span>
                        </a>
						</c:if>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div class="page-header-menu">
        <div class="container">
            <form class="search-form" action="page_general_search.html" method="GET">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search" name="query">
                    <span class="input-group-btn">
                        <a href="javascript:;" class="btn submit">
                            <i class="icon-magnifier"></i>
                        </a>
                    </span>
                </div>
            </form>
            <div class="hor-menu  ">
                <ul class="nav navbar-nav">
                    <li class="menu-dropdown classic-menu-dropdown ">
                        <a href="${ctx}/"> 首页
                            <span class="arrow"></span>
                        </a>
                    </li>
                    <li class="menu-dropdown mega-menu-dropdown  ">
                        <a href="${ctx}/"> 产品
                            <span class="arrow"></span>
                        </a>
                    </li>
                    <li class="menu-dropdown classic-menu-dropdown ">
                        <a href="${ctx}/"> 订单
                            <span class="arrow"></span>
                        </a>
                    </li>
                    <li class="menu-dropdown mega-menu-dropdown  mega-menu-full">
                        <a href="${ctx}/"> 帮助
                            <span class="arrow"></span>
                        </a>
                    </li>
                    <li class="menu-dropdown classic-menu-dropdown ">
                        <a href="${ctx}/"> 关于
                            <span class="arrow"></span>
                        </a>
                    </li>
                    <li class="menu-dropdown classic-menu-dropdown active">
                        <a href="${ctx}/profile">
                            <i class="icon-briefcase"></i> 会员
                            <span class="arrow"></span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

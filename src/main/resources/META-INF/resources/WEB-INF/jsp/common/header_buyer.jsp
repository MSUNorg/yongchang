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
                <a href="${ctx}/">
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
                                <a href="${ctx}/profile"><i class="icon-user"></i> 个人设置 </a>
                            </li>
                            <li class="divider"> </li>
                            <li>
                                <a href="${ctx}/logout"><i class="icon-key"></i> 退出 </a>
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
            <div class="hor-menu  ">
                <ul class="nav navbar-nav">
                    <li class="menu-dropdown classic-menu-dropdown ">
                        <a href="${ctx}/"> 首页
                            <span class="arrow"></span>
                        </a>
                    </li>
                    <li class="menu-dropdown mega-menu-dropdown  ">
                        <a href="${ctx}/buyer"> 供货
                            <span class="arrow"></span>
                        </a>
                    </li>
                    <li class="menu-dropdown classic-menu-dropdown ">
                        <a href="${ctx}/buyer/cart"> 购物车
                            <span class="arrow"></span>
                        </a>
                    </li>
                    <li class="menu-dropdown classic-menu-dropdown ">
                        <a href="#"> 订单
                            <span class="arrow"></span>
                        </a>
                        <ul class="dropdown-menu pull-left">
                        	<li class=" ">
                                <a href="${ctx}/buyer/order" class="nav-link  ">  今日订单 </a>
                            </li>
                        	<li class=" ">
                                <a href="${ctx}/buyer/order/history" class="nav-link  "> 历史订单 </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

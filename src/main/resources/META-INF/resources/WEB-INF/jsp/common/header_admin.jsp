<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec"     uri="http://www.springframework.org/security/tags" %>
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
                        <a href="javascript:;"> 商家
                            <span class="arrow"></span>
                        </a>
                        <ul class="dropdown-menu pull-left">
                        	<li class=" ">
                                <a href="${ctx}/admin/code" class="nav-link  "> 认证码管理 </a>
                            </li>
                            <li class=" ">
                                <a href="${ctx}/admin/supplierStore" class="nav-link  "> 供货商店铺 </a>
                            </li>
                            <li class=" ">
                                <a href="${ctx}/admin/supplier" class="nav-link  "> 供应商列表 </a>
                            </li>
                            <li class=" ">
                                <a href="${ctx}/admin/buyer" class="nav-link  "> 采购商列表 </a>
                            </li>
                        </ul>
                    </li>
                    <li class="menu-dropdown classic-menu-dropdown ">
                        <a href="javascript:;"> 产品
                            <span class="arrow"></span>
                        </a>
                        <ul class="dropdown-menu pull-left">
                            <li class=" ">
                                <a href="${ctx}/admin/model" class="nav-link  "> 规格管理 </a>
                            </li>
                            <li class=" ">
                                <a href="${ctx}/admin/category" class="nav-link  "> 类别管理 </a>
                            </li>
                            <li class=" ">
                                <a href="${ctx}/admin/product" class="nav-link  "> 产品管理 </a>
                            </li>
                        </ul>
                    </li>
                    <li class="menu-dropdown mega-menu-dropdown ">
                        <a href="javascript:;"> 订单
                            <span class="arrow"></span>
                        </a>
                        <ul class="dropdown-menu pull-left">
                        	<li class=" ">
	                            <a href="${ctx}/admin/order/summery" class="nav-link  "> 采购商品汇总 </a>
	                        </li>
	                        <li class=" ">
	                            <a href="${ctx}/admin/order/summery/history" class="nav-link  "> 采购商品汇总历史 </a>
	                        </li>
	                        <li class=" ">
	                            <a href="${ctx}/admin/order/buyer" class="nav-link  "> 采购订单 </a>
	                        </li>
	                        <li class=" ">
	                            <a href="${ctx}/admin/order/supplier" class="nav-link  "> 供货订单 </a>
	                        </li>
                        	<li class=" ">
	                            <a href="${ctx}/admin/order/supplier/history" class="nav-link  "> 历史订单 </a>
	                        </li>
                        </ul>
                    </li>
                    <li class="menu-dropdown classic-menu-dropdown ">
                        <a href="javascript:;"> 审核
                            <span class="arrow"></span>
                        </a>
                        <ul class="dropdown-menu pull-left">
	                        <li class=" ">
	                            <a href="${ctx}/admin/verify/supplierItem" class="nav-link  "> 供货商品审核 </a>
	                        </li>
                        </ul>
                    </li>
                    <li class="menu-dropdown classic-menu-dropdown ">
                        <a href="javascript:;"> 需求
                            <span class="arrow"></span>
                        </a>
                        <ul class="dropdown-menu pull-left">
	                        <li class=" ">
	                            <a href="${ctx}/admin/require" class="nav-link  "> 平台需求 </a>
	                        </li>
                        </ul>
                    </li>
                    <li class="menu-dropdown classic-menu-dropdown ">
                        <a href="javascript:;"> 报表
                            <span class="arrow"></span>
                        </a>
                        <ul class="dropdown-menu pull-left">
	                        <li class=" ">
	                            <a href="${ctx}/admin/rpt/itemSum" class="nav-link  "> 今日采购汇总报表 </a>
	                        </li>
	                        <li class=" ">
	                            <a href="${ctx}/admin/rpt/item" class="nav-link  "> 商品项汇总报表 </a>
	                        </li>
	                        <li class=" ">
	                            <a href="${ctx}/admin/rpt/order/supplier" class="nav-link  "> 供应商订单汇总报表 </a>
	                        </li>
	                        <li class=" ">
	                            <a href="${ctx}/admin/rpt/order/buyer" class="nav-link  "> 采购商订单汇总报表 </a>
	                        </li>
                        </ul>
                    </li>
                    <li class="menu-dropdown classic-menu-dropdown ">
                        <a href="javascript:;"> 系统
                            <span class="arrow"></span>
                        </a>
                        <ul class="dropdown-menu pull-left">
	                        <li class=" ">
	                            <a href="${ctx}/admin/user" class="nav-link  "> 员工管理 </a>
	                        </li>
	                        <li class=" ">
	                            <a href="${ctx}/admin/role" class="nav-link  "> 角色管理 </a>
	                        </li>
                        </ul>
                    </li>
                    <li class="menu-dropdown classic-menu-dropdown ">
                        <a href="javascript:;"> 内容管理
                            <span class="arrow"></span>
                        </a>
                        <ul class="dropdown-menu pull-left">
	                        <li class=" ">
	                            <a href="${ctx}/admin/cms/slideshow" class="nav-link  "> 首页轮播图 </a>
	                        </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

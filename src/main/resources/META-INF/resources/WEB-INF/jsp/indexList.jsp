<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>永昌e篮子-全国最大的蔬菜电商网站</title>
<link type="text/css" rel="stylesheet" href="${ctx}/js/mall/css/common.css" />
<script src="${ctx}/js/mall/js/jquery.js"></script>
<script src="${ctx}/js/mall/js/jquery.idTabs.min.js"></script>
<script src="${ctx}/js/mall/js/jquery.SuperSlide.2.1.1.js"></script>
<script src="${ctx}/js/mall/js/common.js"></script>

<script>
$(function () {
	$(".btn-search").click(function() {
		var keyword=$('#keyword').val();
		window.location.href = "${ctx}/index/search?keyword="+keyword;
	});
})
</script>
</head>

<body>
	<!-- 顶部导航 -->
	<div class="ui-top main-pic">
		<div class="wp clearfix">
			<c:if test="${empty pageContext.request.remoteUser}">
				<div class="fl">
					<span>您好，欢迎来到 永昌e篮子！</span> <a href="${ctx}/login" class="login">请登录</a>&#12288;
					<ul class="fr top-tools">
						<li class="n">
						<a href="#" class="reg">注册</a>
		                <div class="sub">
		                    <a href="${ctx}/register/supplier">供应商</a>
		                    <a href="${ctx}/register/buyer">采购商</a>
		                </div>
		                </li>
	                </ul>
				</div>
			</c:if>

			<c:if test="${not empty pageContext.request.remoteUser}">
				<div class="fl">
					<span>${pageContext.request.remoteUser} 您好，欢迎来到 永昌e篮子！</span> 
					<a href="${ctx}/logout" class="login">退出登录</a>&#12288;
				</div>
			</c:if>

			<ul class="fr top-tools">
				<li><a href="${ctx}/profile">个人中心</a></li>
			</ul>
		</div>
	</div>
	<!-- 头部 -->
	<div class="header clearfix">
		<div class="wp">
			<div class="logo fl">
				<a href="/" title="永昌e篮子"><i>永昌e篮子</i></a>
			</div>
			<div class="serach fl">
				<div class="serach_div">
					<input type="button" value="搜索" class="btn fr main-pic btn-search"> 
					<input type="text" name="keywords" id="keyword" value="" class="box">
				</div>
			</div>
		</div>
	</div>
	<!-- 导航 -->
	<div class="ui-nav">
		<div class="wp">
			<ul class="menu-main">
				<li><a href="${ctx}/">首页</a></li>
				<c:forEach items="${categoryList}" var="data" varStatus="loopCounter">
				<c:if test="${loopCounter.count < 5}">
				<li <c:if test="${data.id == categoryId}">class="on"</c:if>>
					<a href="${ctx}/index/${data.id}">${data.name}</a>
				</li>
				</c:if>
				</c:forEach>
				<li class="amore">
	                <a href="#">更多</a>
	                <div class="more-list">
	                    <c:forEach items="${categoryList}" var="data" varStatus="loopCounter">
						<c:if test="${loopCounter.count > 4}">
						<a href="${ctx}/index/${data.id}">${data.name}</a>
						</c:if>
						</c:forEach>
	                </div>
	            </li>
			</ul>
		</div>
	</div>
	<!-- 主要内容 -->
	<div class="content-main ovh">
		<div class="wp">
			<div class="ui-column ovh">
				<div class="columu-con ovh">
					<div class="timesale-item">
						<ul>
							<c:forEach items="${itemList}" var="data" varStatus="loopCounter">
							<li>
								<a href="${ctx}/item/${data.id}">
								<c:if test="${empty data.img}">
				                <img src="${ctx}/images/noimages.png" alt="" width="280" height="300"/> 
				                </c:if>
               					<c:if test="${not empty data.img}">
               					<img src="${ctx}/img?img=${data.img}" alt="" width="280" height="300"/> 
               					</c:if>
								<h3>${data.title}</h3>  <span>${data.product.title} ${data.getItemPriceStr()} 元/千克</span>
								</a>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			
		</div>
	</div>

	<div class="copyright">
		<p>客服热线：400-870-7050 <br /> Copyright © 2016 永昌e篮子 版权所有 <br />沪ICP备 15054258号-1</p>
	</div>
</body>
</html>
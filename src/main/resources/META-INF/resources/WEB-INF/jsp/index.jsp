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
		                    <a href="${ctx}/register/supplier">注册供应商</a>
		                    <a href="${ctx}/register/buyer">注册采购商</a>
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
					<input type="text" name="keywords" id="keyword" value="大排" class="box">
				</div>
				<!-- <p class="hot_serach">
					<a href="#">新鲜蔬菜</a> <a href="#">牛肉</a> <a href="#">羊肉</a><a
						href="#">新鲜水果</a>
				</p> -->
			</div>
		</div>
	</div>
	<!-- 导航 -->
	<div class="ui-nav">
		<div class="wp">
			<ul class="menu-main">
				<li class="on"><a href="${ctx}/">首页</a></li>
				<c:forEach items="${categoryList}" var="data" varStatus="loopCounter">
				<c:if test="${loopCounter.count < 5}">
				<li><a href="${ctx}/index/${data.id}">${data.name}</a></li>
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
	
	<!-- 轮播 -->
	<div class="slideshow pr">
	    <div class="hd">
	        <ul>
	        	<c:forEach items="${showcases}" var="data" varStatus="loopCounter">
	        	<c:if test="${empty data.pic}">
                <c:set var="img" value="${ctx}/images/noimages.png" />
                </c:if>
    			<c:if test="${not empty data.pic}">
    			<c:set var="img" value="${ctx}/img?img=${data.pic}" />
    			</c:if>
	        	<c:if test="${loopCounter.index == 1}">
        	    <li style="display: list-item; opacity: 0.9804; background: url(&quot;${img}&quot;) center top no-repeat;"><a href="#"></a></li>
	        	</c:if>
	        	<c:if test="${loopCounter.index != 1}">
	            <li style="display: none; background: url(&quot;${img}&quot;) center top no-repeat;"><a href="#"></a></li>
	            </c:if>
	            </c:forEach>
	        </ul>
	    </div>
	    <div class="bd">
	    	<c:forEach items="${showcases}" var="data" varStatus="loopCounter">
	    	<c:if test="${loopCounter.index == 1}">
	    	<li class="on">1</li>
	    	</c:if>
	    	<c:if test="${loopCounter.index != 1}">
	    	<li class="">${loopCounter}</li>
	    	</c:if>
	    	</c:forEach>
	    </div>
	</div>
	
	<!-- 主要内容 -->
	<div class="content-main ovh">
		<div class="wp">
			<!-- 热卖 -->
			<div class="ui-column ovh">
				<div class="columu-tit sale-tit ovh">
					<h2>热卖产品</h2>
				</div>
				<div class="columu-con ovh">
					<div class="timesale-item">
						<ul>
							<c:forEach items="${hots}" var="data" varStatus="loopCounter">
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
			<!-- 限时 -->
			<div class="ui-column ovh">
				<div class="columu-tit timesale-tit ovh">
					<h2>新品上市</h2>
				</div>
				<div class="columu-con ovh">
					<div class="timesale-item">
						<ul>
							<c:forEach items="${promotions}" var="data" varStatus="loopCounter">
							<li><a href="${ctx}/item/${data.id}">
								<c:if test="${empty data.img}">
				                <img src="${ctx}/images/noimages.png" alt="" width="280" height="300"/> 
				                </c:if>
               					<c:if test="${not empty data.img}">
               					<img src="${ctx}/img?img=${data.img}" alt="" width="280" height="300"/> 
               					</c:if>
								<h3>${data.title}</h3> <span>${data.product.title} ${data.getItemPriceStr()} 元/千克</span> </a>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<!-- 超级精选 -->
			<div class="ui-column ovh">
				<div class="columu-tit2 ovh">
					<h2>超级精选</h2>
				</div>
				<div class="columu-con ovh">
					<div class="choice-item" id="choice-1">
						<ul>
							<c:forEach items="${hots}" var="data" varStatus="loopCounter">
							<li>
								<a href="${ctx}/item/${data.id}">
								<c:if test="${empty data.img}">
				                <img src="${ctx}/images/noimages.png" alt="" width="280" height="300"/> 
				                </c:if>
               					<c:if test="${not empty data.img}">
               					<img src="${ctx}/img?img=${data.img}" alt="" width="280" height="300"/> 
               					</c:if>
								<h3>${data.title}</h3>  <span>${data.product.title} ${data.getItemFullPriceStr()} 元/千克</span>
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
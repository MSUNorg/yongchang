<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${item.title}-永昌e篮子</title>
<link type="text/css" rel="stylesheet" href="${ctx}/js/mall/css/detail.css" />
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
				<a href="${ctx}/" title="永昌e篮子"><i>永昌e篮子</i></a>
			</div>
			<div class="serach fl">
				<div class="serach_div">
					<input type="button" value="搜索" class="btn fr main-pic btn-search"> 
					<input type="text" name="keywords" id="keyword" value="龙虾" class="box">
				</div>
				<p class="hot_serach">
					<a href="#">新鲜蔬菜</a> <a href="#">牛肉</a> <a href="#">羊肉</a><a href="#">新鲜水果</a>
				</p>
			</div>

		</div>
	</div>

	<div class="webNav-mod ovh">
		<div class="wp">
			<span class="tip-bz fr"></span> <span>您现在的位置:</span> <a href="${ctx}/">首页</a>
			> <a href="#">商品列表</a>
		</div>
	</div>
	<!-- 网站导航 end -->

	<!-- 主要内容 -->
	<div class="content-warp ovh">
		<div class="wp">
			<h1 class="pro-title">${item.title}</h1>
			<div class="pro_detail ovh">
				<!-- 左边图片 -->
				<div class="pro_detail_img fl">
					<div class="jqzoom bigImg ovh pr">
						<c:if test="${empty item.img}">
		                <img src="${ctx}/images/noimages.png" alt="" width="270" height="270"/> 
		                </c:if>
       					<c:if test="${not empty item.img}">
       					<img src="${ctx}/img?img=${item.img}" alt="" width="270" height="270"/> 
       					</c:if>
					</div>
				</div>
				<!-- 右边介绍 -->
				<div class="pro_detail_main fr">
					<div class="pro-dsku">
						<div class="sk-item ovh">
							<span class="t1">价格</span>
							<div>
								<strong><span>￥</span>${item.getItemFullPriceStr()}</strong>
							</div>
						</div>
						<div class="sk-item ovh">
							<span class="t1">销量</span>
							<div>
								<strong>0</strong>
							</div>
						</div>
						<div class="sk-item ovh">
							<span class="t1">起批量</span>
							<div><fmt:formatNumber value="${item.product.minOrderQty}" type="currency" pattern="#0.00"/>Kg</div>
						</div>
					</div>

				</div>
			</div>
			<div class="clearfix"></div>


			<div class="sidebar fl ovh mt20">
				<div class="hot-rank ovh b-sd">
					<div class="top">
						<strong>热销排行</strong>
					</div>
					<div class="con">
						<c:forEach items="${hots}" var="data" varStatus="loopCounter">
							<dl>
								<dt>
									<a href="${ctx}/item/${data.id}">
									<c:if test="${empty data.img}">
					                <img src="${ctx}/images/noimages.png" alt="" width="180" height="180"/> 
					                </c:if>
	               					<c:if test="${not empty data.img}">
	               					<img src="${ctx}/img?img=${data.img}" alt="" width="180" height="180"/> 
	               					</c:if>
									</a>
								</dt>
								<dd>
									<span>￥${data.getItemPriceStr()}</span>
									<p><a href="${ctx}/item/${data.id}">${data.title}</a></p>
								</dd>
							</dl>
						</c:forEach>
					</div>
				</div>
			</div>

			<!-- 商品相关介绍说明 -->
			<div class="spmain fr ovh">
				<div class="detatab ovh idTabs">
					<ul>
						<li><a href="#detatab1">详细信息</a></li>
					</ul>
				</div>

				<div class="detamain ovh items">
					<!-- 商品展示 -->
					<div class="prd-show" id="detatab1">
						<table class="ui-table">
							<tr>
								<th>建议零售价</th>
								<td>${item.getItemFullPriceStr()}</td>
								<th>品种</th>
								<td>好</td>
							</tr>
							<!-- 
							<tr>
								<th>单果重</th>
								<td>30-40g</td>
								<th>等级</th>
								<td>1级</td>
							</tr>
							<tr>
								<th>口味口感</th>
								<td>香甜可口</td>
								<th>一箱重</th>
								<td>3kg</td>
							</tr>
							<tr>
								<th>原产地</th>
								<td>江西</td>
								<th>一箱净含量</th>
								<td>2.6kg</td>
							</tr>
							-->
						</table>
						<div class="goods_intro">
							<c:if test="${empty item.img}">
			                <img src="${ctx}/images/noimages.png" alt="" width="270" height="270"/> 
			                </c:if>
	       					<c:if test="${not empty item.img}">
	       					<img src="${ctx}/img?img=${item.img}" alt="" width="270" height="270"/> 
	       					</c:if>
	       					${item.detail}
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="content-warp">
		&nbsp;</br>&nbsp;
	</div>
	
	<div class="copyright">
		<p>客服热线：400-870-7050 <br /> Copyright © 2016 永昌e篮子 版权所有 <br />沪ICP备 15054258号-1</p>
	</div>
</body>
</html>
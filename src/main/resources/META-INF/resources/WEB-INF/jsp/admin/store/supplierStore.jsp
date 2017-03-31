<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>供货商店铺-永昌e篮子</title>
    <link href="${ctx}/msun/global/plugins/cubeportfolio/css/cubeportfolio.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/msun/pages/css/portfolio.min.css" rel="stylesheet" type="text/css" />
</rapid:override> 

<rapid:override name="content">     
<div class="page-container">
    <div class="page-content-wrapper">
        <div class="page-head">
            <div class="container"><div class="page-title"><h1></h1></div></div>
        </div>
        <div class="page-content">
            <div class="container">
                <ul class="page-breadcrumb breadcrumb">
                    <li>
                        <a href="${ctx}/">首页</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>供货商店铺</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                	<div class="portfolio-content portfolio-1">
                        <div id="js-grid-juicy-projects" class="cbp1">
                        	<c:forEach  items="${userList.content}" var="data" varStatus="loopCounter">
                            <div class="cbp-item graphic">
                                <div class="cbp-caption">
                                    <div>
                                        <a href="${ctx}/admin/supplierItem/${data.id}">
                                        <c:if test="${empty data.logo}">
						                <img src="${ctx}/images/noimages.png" alt="" width="200" height="150"> 
						                </c:if>
                  						<c:if test="${not empty data.logo}">
                  						<img src="${ctx}/img?img=${data.logo}" alt="" width="200" height="150"> 
                  						</c:if>
                                        </a>
                                    </div>
                                </div>
                                <div class="cbp-l-grid-projects-title uppercase text-center uppercase text-center">${data.company}</div>
                                <div class="cbp-l-grid-projects-desc uppercase text-center uppercase text-center">地区：${data.province}${data.city}</div>
                            </div>
                        	</c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <a href="javascript:;" class="page-quick-sidebar-toggler">
        <i class="icon-login"></i>
    </a>
</div>
</rapid:override> 
    
<%@include file="../../common/layout.jsp" %>
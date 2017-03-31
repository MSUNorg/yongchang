<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>供货信息列表-永昌e篮子</title>
    <script>
    
    </script>
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
                        <span>采购汇总信息清单</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class="fa "></i>采购汇总信息清单 </div>
                                </div>
                                <div class="portlet-body">
                                    <div class="table-container">
                                        <table class="table table-striped table-bordered table-hover table-checkable" id="datatable_products">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th width="1%"><input type="checkbox" class="group-checkable"> </th>
                                                    <th width="10%"> 图片 </th>
                                                    <th width="15%"> 商品类别 </th>
                                                    <th width="15%"> 商品名称 </th>
                                                    <th width="15%"> 采购商 </th>
                                                    <th width="15%"> 采购量(千克) </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            	<c:forEach items="${detailList.content}" var="data" varStatus="loopCounter">
                                            	<tr role="row" class="filter">
                                                    <td>
                                                    	<input type="checkbox" class="group-checkable"> 
                                                    </td>
                                                    <td>
                                                    	<c:if test="${empty data.item.img}">
										                <img src="${ctx}/images/noimages.png" alt="" width="200" height="150"> 
										                </c:if>
                                    					<c:if test="${not empty data.item.img}">
                                    					<img src="${ctx}/img?img=${data.item.img}" alt="" width="200" height="150" /> 
                                    					</c:if>
                                                    </td>
                                                    <td>${data.item.product.category.name}</td>
                                                    <td>${data.item.product.title}</td>
                                                    <td>${data.order.user.company}</td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                	
                                	<tags:pagination page="${detailList}"/>
                                </div>
                            </div>
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
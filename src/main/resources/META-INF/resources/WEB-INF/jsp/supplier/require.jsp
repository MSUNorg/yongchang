<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>平台需求列表-永昌e篮子</title>
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
                        <span>平台需求</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption"><i class="fa "></i>平台需求列表 </div>
                                </div>
                                <div class="portlet-body">
                                    <div class="table-container">
                                        <table class="table table-striped table-bordered table-hover table-checkable" id="datatable_products">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th width="1%"><input type="checkbox" class="group-checkable"> </th>
                                                    <th width="10%"> 编号 </th>
                                                    <th width="15%"> 商品类别 </th>
                                                    <th width="15%"> 商品名称 </th>
                                                    <th width="8%"> 需求量(千克) </th>
                                                    <th width="8%"> 已中标量(千克) </th>
                                                    <th width="8%"> 指导价(元) </th>
                                                    <th width="10%"> 截止时间 </th>
                                                    <th width="10%"> 状态 </th>
                                                    <th width="10%"> 操作 </th>
                                                </tr>
                                            </thead>
                                            <tbody> 
                                            	<c:forEach items="${requireList.content}" var="data" varStatus="loopCounter">
                                            	<tr role="row" class="filter">
                                                    <td><input type="checkbox" class="group-checkable"></td>
                                                    <td>${data.id}</td>
                                                    <td>${data.product.category.name}</td>
                                                    <td>${data.title}</td>
                                                    <td>
                                                    <fmt:formatNumber value="${data.requireCount}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    <fmt:formatNumber value="${data.finishCount}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    <fmt:formatNumber value="${data.startPrice}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td><fmt:formatDate value="${data.createTime}" pattern="yyyy-MM-dd"/></td>
                                                    <td>
                                                    <c:if test="${data.state == 1}">有效</c:if>
                                                   	<c:if test="${data.state == 2}">无效</c:if>
                                                    </td>
                                                    <td>
                                                        <div class="margin-bottom-5">
	                                                        <button class="btn btn-sm btn-success filter-cancel margin-bottom"
	                                                        onclick="location.href='${ctx}/supplier/require/bid/${data.id}'">
	                                                            <i class="fa "></i> 竞标
	                                                        </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                	
                                	<tags:pagination page="${requireList}"/>
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
    
<%@include file="../common/layout.jsp" %>
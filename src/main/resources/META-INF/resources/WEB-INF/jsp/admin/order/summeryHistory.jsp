<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>采购商品汇总历史-永昌e篮子</title>
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
                        <span>采购商品汇总</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption"><i class="fa "></i>采购商品汇总历史 </div>
                                </div>
                                
                                <div class="portlet-body">
                                    <div class="table-container">
                                        <table class="table table-striped table-bordered table-hover table-checkable" id="datatable_products">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th width="10%"> 编号 </th>
                                                    <th width="10%"> 图片 </th>
                                                    <th width="15%"> 商品名称 </th>
                                                    <th width="15%"> 需求量(千克) </th>
                                                    <th width="15%"> 供应价格(元/千克) </th>
                                                    <th width="15%"> 供应商 </th>
                                                    <th width="15%"> 汇总日期 </th>
                                                    <th width="10%"> 状态 </th>
                                                    <th width="10%"> 操作 </th>
                                                </tr>
                                            </thead>
                                            <tbody> 
                                            	<c:forEach items="${itemSumList.content}" var="data" varStatus="loopCounter">
                                            	<tr role="row" class="filter">
                                                    <td>
                                                    	<input type="hidden" class="form-control count" name="count" value="${data.count}"/>
                                                    	<input type="hidden" class="itemId" name="id" value="${data.item.id}"/>
                                                    </td>
                                                    <td>${data.id}</td>
                                                    <td>
                                                    	<c:if test="${empty data.item.img}">
										                <img src="${ctx}/images/noimages.png" alt="" width="200" height="150"> 
										                </c:if>
                                    					<c:if test="${not empty data.item.img}">
                                    					<img src="${ctx}/img?img=${data.item.img}" alt="" width="200" height="150" /> 
                                    					</c:if>
                                                    </td>
                                                    <td>${data.item.title}</td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.item.itemPrice}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>${data.item.user.company}</td>
                                                    <td><fmt:formatDate value="${data.createTime}" pattern="yyyy-MM-dd"/></td>
                                                    <td>已下单</td>
                                                    <td>
                                                        <div class="margin-bottom-5">
                                                            <button class="btn btn-sm btn-success filter-submit margin-bottom"
                                                            onclick="location.href='${ctx}/admin/itemSum/detail/${data.id}'">
                                                                <i class="fa "></i> 查看详情
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                	
                                	<tags:pagination page="${itemSumList}"/>
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
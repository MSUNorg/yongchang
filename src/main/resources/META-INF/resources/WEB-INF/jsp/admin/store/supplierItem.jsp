<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>供货信息列表-永昌e篮子</title>
    <script>
    function modify(id,state) {
		if(!id) return;
		$.ajax({
   			url: "/admin/item/modify",
   			type: "POST",
   			cache: false,
   			dataType: "json",
   			data: {"itemId":id,"state":state},
   			success: function(data) {
   				if(!data.status){
   					alert(data.message);
   					return;
   				}
   				if(data.status){
   					window.location.href = "${ctx}/admin/supplierItem/${userId}";
   				}
   			},
   			error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert("服务器错误码:"+XMLHttpRequest.status);
            }
   		});
	}
    function showcase(id,state) {
		if(!id) return;
		$.ajax({
   			url: "/admin/item/showcase",
   			type: "POST",
   			cache: false,
   			dataType: "json",
   			data: {"itemId":id,"state":state},
   			success: function(data) {
   				if(!data.status){
   					alert(data.message);
   					return;
   				}
   				if(data.status){
   					window.location.href = "${ctx}/admin/supplierItem/${userId}";
   				}
   			},
   			error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert("服务器错误码:"+XMLHttpRequest.status);
            }
   		});
	}
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
                        <span>供货信息</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class="fa "></i>供货信息列表 </div>
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
                                                    <th width="15%"> 价格(元/千克) </th>
                                                    <th width="15%"> 供应量(千克) </th>
                                                    <th width="10%"> 状态 </th>
                                                    <th width="10%"> 操作 </th>
                                                </tr>
                                            </thead>
                                            <tbody> 
                                            	<c:forEach items="${itemList.content}" var="data" varStatus="loopCounter">
                                            	<tr role="row" class="filter">
                                                    <td>
                                                    	<input type="checkbox" class="group-checkable"> 
                                                    </td>
                                                    <td>
                                                    	<c:if test="${empty data.img}">
										                <img src="${ctx}/images/noimages.png" alt="" width="200" height="150"> 
										                </c:if>
                                    					<c:if test="${not empty data.img}">
                                    					<img src="${ctx}/img?img=${data.img}" alt="" width="200" height="150" /> 
                                    					</c:if>
                                                    </td>
                                                    <td>${data.product.category.name}</td>
                                                    <td>${data.product.title}</td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.itemPrice}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<c:if test="${data.state == 0}">未审核</c:if>
                                                    	<c:if test="${data.state == 1}">正常出售中</c:if>
                                                    	<c:if test="${data.state == 2}">已停止</c:if>
                                                    </td>
                                                    <td>
                                                        <div class="margin-bottom-5">
                                                            <button class="btn btn-sm btn-success filter-submit margin-bottom" onclick="window.location.href='${ctx}/admin/item/view/${data.id}'">
                                                                <i class="fa "></i> 查看
                                                            </button>
                                                        </div>
                                                         <!-- 状态:0=未审核,1=正常出售中,2=停止 -->
                                                    	<c:if test="${data.state==0 || data.state==2}">
                                                    	<div class="margin-bottom-5">
	                                                        <button class="btn btn-sm btn-default filter-cancel margin-bottom"
	                                                        onclick="modify(${data.id},1)">
	                                                            <i class="fa "></i> 发布
	                                                        </button>
                                                        </div>
                                                    	</c:if>
                                                    	<c:if test="${data.state==1}">
                                                    	<div class="margin-bottom-5">
	                                                        <button class="btn btn-sm btn-default filter-cancel margin-bottom"
	                                                        onclick="modify(${data.id},2)">
	                                                            <i class="fa "></i> 暂停
	                                                        </button>
                                                        </div>
                                                    	</c:if>
                                                    	<%--
                                                    	<c:if test="${empty data.showcase || data.showcase==0}">
                                                    	<div class="margin-bottom-5">
	                                                        <button class="btn btn-sm btn-default filter-cancel margin-bottom"
	                                                        onclick="showcase(${data.id},1)">
	                                                            <i class="fa "></i> 加入轮播
	                                                        </button>
                                                        </div>
                                                        </c:if>
                                                        <c:if test="${data.showcase==1}">
                                                        <div class="margin-bottom-5">
	                                                        <button class="btn btn-sm btn-default filter-cancel margin-bottom"
	                                                        onclick="showcase(${data.id},0)">
	                                                            <i class="fa "></i> 取消轮播
	                                                        </button>
                                                        </div>
                                                        </c:if>
                                                        --%>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                	
                                	<tags:pagination page="${itemList}"/>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>产品基础信息管理-永昌e篮子</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/js/esayui/css/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/js/esayui/css/icon.css">
	<script type="text/javascript" src="${ctx}/js/esayui/jquery.easyui.min.js"></script>
    
    <script>
    $(function () {
	    $(".btn-save").click(function() {
			$.ajax({
	   			url: "/admin/product",
	   			type: "POST",
	   			cache: false,
	   			dataType: "json",
	   			data: $('.yc-form').serialize(),
	   			success: function(data) {
	   				if(!data.status){
	   					alert(data.message);
	   					return;
	   				}
	   				if(data.status){
	   					window.location.href = "${ctx}/admin/product";
	   				}
	   			},
	   			error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert("服务器错误码:"+XMLHttpRequest.status);
                }
	   		});
	   });
	   $(".tree-select").combotree({
		   url: "${ctx}/category",
           cascadeCheck: $(this).is(':checked'),
           onCheck:function(node){
               var $titles=$(this).find("span.tree-hit");
               $titles.each(function(index,value){
                   $(this).siblings().eq(1).removeClass("tree-checkbox tree-checkbox0");
               })
           },
           onLoadSuccess: function () { 
        	   $('.tree-select').combotree('setValue', '${product.categoryId}').combotree('setText','${product.category.name}');
           }
       });
    })
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
		                <span>产品信息编辑</span>
		            </li>
		        </ul>
		        <div class="page-content-inner">
		            <div class="row">
		                <div class="col-md-12">
		                    <form class="form-horizontal form-row-seperated yc-form" action="#">
		                    	<input type="hidden" name="id" value="${product.id}">
		                        <div class="portlet">
		                            <div class="portlet-title">
		                                <div class="caption">
		                                    <i class="fa "></i>产品基础信息编辑
		                                </div>
		                            </div>
		                            <div class="portlet-body">
		                                <div class="tabbable-bordered">
		                                    <ul class="nav nav-tabs">
		                                        <li class="active">
		                                            <a href="#tab_general" data-toggle="tab"> 产品基础信息 </a>
		                                        </li>
		                                    </ul>
		                                    <div class="tab-content">
		                                        <div class="tab-pane active" id="tab_general">
		                                        	<div class="form-body">
		                                        	    <!--  
			                                        	<div class="form-group">
		                                                    <label class="col-md-2 control-label">所属类别:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <select class="table-group-action-input form-control input-medium" name="categoryId">
		                                                            <c:forEach  items="${categoryList}" var="data" varStatus="loopCounter">
		                                                            <option value="${data.id}" <c:if test="${product.categoryId==data.id}">selected</c:if>>${data.name}</option>
		                                                            </c:forEach>
		                                                        </select>
		                                                    </div>
		                                                </div>
		                                                -->
		                                                
		                                                <div class="form-group">
	                                                        <label class="col-md-2 control-label">所属类别:
	                                                        	<span class="required"> * </span>
	                                                        </label>
	                                                        <div class="col-md-9">
	                                                            <select class="bs-select form-control bs-select-hidden input-medium tree-select" 
	                                                            name="categoryId">
	                                                        	</select>
	                                                        </div>
                                                    	</div>
                                                    	
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">商品名称:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium" 
		                                                        name="title" value="${product.title}"> 
		                                                    </div>
		                                                </div>
														<div class="form-group">
		                                                    <label class="col-md-2 control-label">最小下单重量:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium" 
		                                                        name="minOrderQty" 
		                                                        value="${product.minOrderQty}"> 
		                                                    	<span class="help-inline"> 千克 </span>
		                                                    </div>
		                                                </div>
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">加价金额:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium" 
		                                                        name="priceAddAmount" 
		                                                        <c:if test="${not empty product.priceAddAmount}">
		                                                        value="<fmt:formatNumber value="${product.priceAddAmount}" type="currency" pattern="#0.00"/>" 
		                                                    	</c:if>
		                                                    	>
		                                                    	<span class="help-inline"> 元/千克 </span>
		                                                    </div>
		                                                </div>
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">运费:
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium" 
		                                                        name="freight" 
		                                                        <c:if test="${not empty product.freight}">
		                                                        value="<fmt:formatNumber value="${product.freight}" type="currency" pattern="#0.00"/>"
		                                                        </c:if>
		                                                        > 
		                                                    	<span class="help-inline"> 元/千克 </span>
		                                                    </div>
		                                                </div>
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">损耗:
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium" 
		                                                        name="loss" 
		                                                        <c:if test="${not empty product.loss}">
		                                                        value="<fmt:formatNumber value="${product.loss}" type="currency" pattern="#0.00"/>"
		                                                        </c:if>
		                                                        > 
		                                                    	<span class="help-inline"> 元/千克 </span>
		                                                    </div>
		                                                </div>
			                                            <div class="form-group">
		                                                    <label class="col-md-2 control-label">是否有效:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-10">
		                                                        <select class="table-group-action-input form-control input-medium" name="state">
		                                                            <option value="0" <c:if test="${product.state==0}">selected</c:if>>有效</option>
		                                                            <option value="1" <c:if test="${product.state==1}">selected</c:if>>无效</option>
		                                                        </select>
		                                                    </div>
		                                                </div>
		                                            </div>
		                                            <div class="form-actions">
													    <div class="row">
													        <div class="col-md-offset-3 col-md-9">
													            <button type="button" class="btn green btn-save">保存</button>
													            <button type="button" class="btn default" 
													            onclick="history.back()">返回</button>
													        </div>
													    </div>
													</div>
		                                        </div>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                    </form>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
    </div>
</div>
</rapid:override> 
    
<%@include file="../../common/layout.jsp" %>
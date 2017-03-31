<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>商品类别管理-永昌e篮子</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/js/esayui/css/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/js/esayui/css/icon.css">
	<script type="text/javascript" src="${ctx}/js/esayui/jquery.easyui.min.js"></script>
    <script>
    $(function () {
	    $(".btn-save").click(function() {
			$.ajax({
	   			url: "/admin/category",
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
	   					window.location.href = "${ctx}/admin/category";
	   				}
	   			},
	   			error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert("服务器错误码:"+XMLHttpRequest.status);
                }
	   		});
		});
	    $(".tree-select").combotree({
		   url: "${ctx}/category?root=true",
           cascadeCheck: $(this).is(':checked'),
           valueField:'id',
           textField:'text',
           onCheck:function(node){
               var $titles=$(this).find("span.tree-hit");
               $titles.each(function(index,value){
                   $(this).siblings().eq(1).removeClass("tree-checkbox tree-checkbox0");
               })
           },
           onLoadSuccess: function () { 
        	   $('.tree-select').combotree('setValue', '${category.parentId}').combotree('setText','<c:if test="${empty category.parent}">无</c:if><c:if test="${not empty category.parent}">${category.parent.name}</c:if>');
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
		                <span>商品类别编辑</span>
		            </li>
		        </ul>
		        <div class="page-content-inner">
		            <div class="row">
		                <div class="col-md-12">
		                    <form class="form-horizontal form-row-seperated yc-form" action="#">
		                    	<input type="hidden" name="id" value="${category.id}">
		                        <div class="portlet">
		                            <div class="portlet-title">
		                                <div class="caption">
		                                    <i class="fa "></i>商品类别
		                                </div>
		                            </div>
		                            <div class="portlet-body">
		                                <div class="tabbable-bordered">
		                                    <ul class="nav nav-tabs">
		                                        <li class="active">
		                                            <a href="#tab_general" data-toggle="tab"> 商品类别信息 </a>
		                                        </li>
		                                    </ul>
		                                    <div class="tab-content">
		                                        <div class="tab-pane active" id="tab_general">
		                                        	<div class="form-body">
		                                        		<!--  
			                                        	<div class="form-group">
		                                                    <label class="col-md-2 control-label">上级类别:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-10">
		                                                        <select class="table-group-action-input form-control input-medium" name="parentId">
		                                                        	<option value="">无</option>
		                                                            <c:forEach  items="${parents}" var="data" varStatus="loopCounter">
		                                                            <option value="${data.id}" <c:if test="${category.parentId==data.id}">selected</c:if>>${data.name}</option>
		                                                            </c:forEach>
		                                                        </select>
		                                                    </div>
		                                                </div>
		                                                -->
		                                                
		                                                <div class="form-group">
	                                                        <label class="col-md-2 control-label">上级类别:
	                                                        	<span class="required"> * </span>
	                                                        </label>
	                                                        <div class="col-md-9">
	                                                            <select class="bs-select form-control bs-select-hidden input-medium tree-select" 
	                                                            name="parentId">
	                                                            <option value="">无</option>
	                                                        	</select>
	                                                        </div>
                                                    	</div>
		                                                
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">类别名称:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium" name="name" value="${category.name}"> 
		                                                    </div>
		                                                </div>
			                                            <div class="form-group">
		                                                    <label class="col-md-2 control-label">是否有效:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-10">
		                                                        <select class="table-group-action-input form-control input-medium" name="state">
		                                                            <option value="0" <c:if test="${category.state==0}">selected</c:if>>有效</option>
		                                                            <option value="1" <c:if test="${category.state==1}">selected</c:if>>无效</option>
		                                                        </select>
		                                                    </div>
		                                                </div>
		                                            </div>
		                                            <div class="form-actions">
													    <div class="row">
													        <div class="col-md-offset-3 col-md-9">
													            <button type="button" class="btn green btn-save">保存</button>
													            <button type="button" class="btn default" onclick="history.back()">返回</button>
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
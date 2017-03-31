<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>平台需求发布-永昌e篮子</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/js/esayui/css/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/js/esayui/css/icon.css">
	<script type="text/javascript" src="${ctx}/js/esayui/jquery.easyui.min.js"></script>
	<script src="${ctx}/msun/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
    
    <link href="${ctx}/msun/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
    
    <script>
    function selectChange(categoryId,productId){
    	var suffix = '<select class="table-group-action-input form-control input-medium" onchange="changeTitle(this);" name="productId">';
		var prefix = '</select>';
		$.ajax({
   			url: "/"+categoryId+"/product",
   			type: "POST",
   			cache: false,
   			dataType: "json",
   			contentType:false,
   			success: function(data) {
   				if(data=='{}'){
   					alert("操作失败");
   					return;
   				}
	        	for(var x = 0;x < data.length;x++){ 
        	    	var id = data[x].id;
        	    	var text = data[x].text;
        	    	if(productId == id){
        	    		var option = '<option value="'+id+'" selected>'+text+'</option>';
        	    	}else{
        	    		var option = '<option value="'+id+'">'+text+'</option>';
        	    	}
        	    	suffix = suffix+option;
        	  	} 
	        	suffix = suffix+prefix;
	        	$(suffix).replaceAll($('select[name="productId"]'));
   			},
   			error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert("服务器错误码:"+XMLHttpRequest.status);
            }
   		});
    }
    function changeTitle(th) {
		var value = $(th).find('option:selected').text();
		$('#title').val(value);
	}
    $(function () {
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
          	   <c:if test="${not empty require.productId}">
          	   $('.tree-select').combotree('setValue', '${require.product.categoryId}').combotree('setText','${require.product.category.name}');
          	   selectChange(${require.product.categoryId},${require.product.id});
          	   </c:if>
             },
             onChange: function (categoryId) {
             	selectChange(categoryId,0);
             }
        });
    	
	    $(".save-btn").click(function() {
			$.ajax({
	   			url: "/admin/require",
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
	   					window.location.href = "${ctx}/admin/require";
	   				}
	   			},
	   			error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert("服务器错误码:"+XMLHttpRequest.status);
                }
	   		});
		});
	    
	    $('#deadline').datetimepicker({  
	   	      format: 'yyyy-MM-dd hh:mm',  
	   	      language: 'ch',  
	   	      pickDate: true,  
	   	      pickTime: true,  
	   	      hourStep: 1,  
	   	      minuteStep: 15,  
	   	      secondStep: 30,  
	   	      inputMask: true  
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
		                <span>平台需求编辑</span>
		            </li>
		        </ul>
		        <div class="page-content-inner">
		            <div class="row">
		                <div class="col-md-12">
		                    <form class="form-horizontal form-row-seperated yc-form" action="#">
		                    	<input type="hidden" name="id" value="${require.id}">
		                        <div class="portlet">
		                            <div class="portlet-title">
		                                <div class="caption">
		                                    <i class="fa "></i>平台需求发布 
		                                </div>
		                            </div>
		                            <div class="portlet-body">
		                                <div class="tabbable-bordered">
		                                    <ul class="nav nav-tabs">
		                                        <li class="active">
		                                            <a href="#tab_general" data-toggle="tab"> 平台需求内容 </a>
		                                        </li>
		                                    </ul>
		                                    <div class="tab-content">
		                                        <div class="tab-pane active" id="tab_general">
		                                        	<div class="form-body">
			                                        	<div class="form-group">
	                                                        <label class="col-md-2 control-label">类别:
	                                                        	<span class="required"> * </span>
	                                                        </label>
	                                                        <div class="col-md-9">
	                                                            <select class="bs-select form-control bs-select-hidden input-medium tree-select" name="categoryId">
	                                                        	
	                                                        	</select>
	                                                        </div>
                                                    	</div>
                                                    	
			                                        	<div class="form-group">
		                                                    <label class="col-md-2 control-label">产品:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-10">
		                                                        <select class="table-group-action-input form-control input-medium" onchange="changeTitle(this);" name="productId">
		                                                        <option value="${require.productId}" selected>${require.product.title}</option>    
		                                                        </select>
		                                                    </div>
		                                                </div>
		                                                
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">商品名称:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" id="title" class="form-control input-inline input-medium" name="title"
		                                                        value="${require.title}" placeholder=""> 
		                                                    </div>
		                                                </div>
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">需求量:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium" name="requireCount"
		                                                        value="<fmt:formatNumber value="${require.requireCount}" type="currency" pattern="#0.00"/>" placeholder=""> 
		                                                    	<span class="help-inline"> 千克 </span>
		                                                    </div>
		                                                </div>
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">指导价:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium" name="startPrice"
		                                                        value="<fmt:formatNumber value="${require.startPrice}" type="currency" pattern="#0.00"/>" placeholder=""> 
		                                                    	<span class="help-inline"> 元 </span>
		                                                    </div>
		                                                </div>
		                                                
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">截止日期:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <div id="deadline" class="input-group input-medium">
												                    <input type="text" name="deadline" class="form-control" 
												                    value="${deadline}" readonly>
												                    <span class="input-group-btn add-on">
												                        <button class="btn default " type="button">
												                            <i class="fa fa-calendar"></i>
												                        </button>
												                    </span>
												                </div>
		                                                    </div>
		                                                </div>
		                                                
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">状态:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <select class="table-group-action-input form-control input-medium" name="state">
		                                                        <option value="1" <c:if test="${require.state == 1}">selected</c:if>>有效</option>
		                                                        <option value="2" <c:if test="${require.state == 2}">selected</c:if>>无效</option>   
		                                                        </select>
		                                                    </div>
		                                                </div>
		                                            </div>
		                                            <div class="form-actions">
													    <div class="row">
													        <div class="col-md-offset-3 col-md-9">
													            <button type="button" class="btn green save-btn">发布</button>
													            <button type="button" class="btn default">返回</button>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>供货信息-永昌e篮子</title>
    <meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="${ctx}/js/esayui/css/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/js/esayui/css/icon.css">
	<script type="text/javascript" src="${ctx}/js/esayui/jquery.easyui.min.js"></script>
	<script src="${ctx}/msun/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
	
    <script>
    function selectChange(categoryId,productId){
    	var suffix = '<select class="table-group-action-input form-control input-medium" name="productId">';
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
         	   <c:if test="${not empty item.productId}">
         	   $('.tree-select').combotree('setValue', '${item.product.categoryId}').combotree('setText','${item.product.category.name}');
         	   selectChange(${item.product.categoryId},${item.product.id});
         	   </c:if>
            },
            onChange: function (categoryId) {
            	selectChange(categoryId,0);
            }
        });
    	
	    $(".btn-save").click(function() {
	    	var productId = $('select[name="productId"] option:selected').val();
	    	var title = $('input[type="text"][name="title"]').val();
	    	var itemPrice = $('input[type="text"][name="itemPrice"]').val();
	    	var count = $('input[type="text"][name="count"]').val();
	    	if(productId == null || productId == ''){
	    		alert('请选择产品');
	    		return;
	    	}
	    	if(title == null || title == ''){
	    		alert('请填写产品标题');
	    		return;
	    	}
	    	if(itemPrice == null || itemPrice == ''){
	    		alert('请填写出售价格');
	    		return;
	    	}
	    	if(count == null || count == ''){
	    		alert('请填写出售重量');
	    		return;
	    	}
	   		
	    	var form = $(this).closest('form');
	    	var url = $(this).closest('form').attr('action');
			$.ajax({
	   			url: url,
	   			type: "POST",
	   			cache: false,
	   			dataType: "json",
	   			data: form.serialize(),
	   			success: function(data) {
	   				console.log(data);
	   				if(!data.status){
	   					alert(data.message);
	   					return;
	   				}
	   				if(data.status){
	   					window.location.href = "${ctx}/supplier";
	   				}
	   			},
	   			error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert("服务器错误码:"+XMLHttpRequest.status);
                }
	   		});
		});
	    
	    $(".upload").change(function() {
    		var current=$(this);
   		  	var uploadFile=$(this).val();
   		    var formData = new FormData(); 
   		    var ispost=false;
	   		jQuery.each(jQuery(this)[0].files, function(i, file) {
	   			var size=file.size/1024;
	   			if(size > 1024){
	   				alert('文件超过1M');
   					return;
	   			}
	   			formData.append('imgfile', file);
	   			ispost=true;
	   		});
	   		if(!ispost) return;
	   		$.ajax({
		   	     url: '${ctx}/upload',
		   	     type: 'POST',
		   	     data: formData,
		   	     async: false,
		   	     cache: false,
		   	     contentType: false,
		   	  	 dataType: 'json',
		   	     enctype: 'multipart/form-data',
		   	     processData: false,
		   	     success: function (data) {
		   	        console.log(data.message);
		   	     	if(!data.status){
	   					alert(data.message);
	   					return;
	   				}
	   				if(data.status){
	   					current.closest('div').find('.upload-file').val(data.data);
	   				}
		   	     },
	   			 error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert("服务器错误码:"+XMLHttpRequest.status);
                 }
	   	   });
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
		                <span>发布供货信息</span>
		            </li>
		        </ul>
		        <div class="page-content-inner">
		            <div class="row">
		                <div class="col-md-12">
		                    <form id="item-form" class="form-horizontal form-row-seperated yc-form" action="${ctx}/supplier/item/save"
		                    enctype="multipart/form-data" method="post">
		                    	<input type="hidden" name="id" value="${item.id}">
		                    	<input type="hidden" name="state" value="${item.state}">
		                        <div class="portlet">
		                            <div class="portlet-title">
		                                <div class="caption">
		                                    <i class="fa "></i>编辑供货信息 
		                                </div>
		                            </div>
		                            <div class="portlet-body">
		                                <div class="tabbable-bordered">
		                                    <ul class="nav nav-tabs">
		                                        <li class="active">
		                                            <a href="#tab_general" data-toggle="tab"> 供货信息 </a>
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
		                                                        <select class="table-group-action-input form-control input-medium" name="productId">
		                                                        <option value="${item.productId}" selected>${item.product.title}</option>    
		                                                        </select>
		                                                    </div>
		                                                </div>
			                                            <div class="form-group">
		                                                    <label class="col-md-2 control-label">标题:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium title" name="title" value="${item.title}"> 
		                                                        <span class="help-inline"> </span>
		                                                    </div>
		                                                </div>
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">价格:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium" 
		                                                        name="itemPrice" value="<fmt:formatNumber type="currency" value="${item.itemPrice}" pattern="#0.00"/>"> 
		                                                        <span class="help-inline"> 元/千克 </span>
		                                                    </div>
		                                                </div>
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">重量:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium" name="count" value="<fmt:formatNumber value="${item.count}" type="currency" pattern="#0.00"/>">
		                                                        <span class="help-inline"> 千克 </span>
		                                                    </div>
		                                                </div>
		                                                <div class="form-group">
														    <label class="col-md-2 control-label">图片:</label>
													        <div class="col-md-9 fileinput fileinput-new" data-provides="fileinput">
													            <div class="fileinput-new thumbnail" style="width: 250px; height: 150px;">
													                <c:if test="${empty item.img}">
													                <img src="${ctx}/images/noimages.png" alt=""> 
													                </c:if>
                                               						<c:if test="${not empty item.img}">
                                               						<img src="${ctx}/img?img=${item.img}" alt=""/> 
                                               						</c:if>
													            </div>
													            <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 250px; max-height: 150px;"> </div>
													            <div>
													                <span class="btn default btn-file">
													                    <span class="fileinput-new"> Select image </span>
													                    <span class="fileinput-exists"> Change </span>
													                    <input type="file" class="upload" name="imgfile" value="${item.img}"> 
													                </span>
												                    <input type="hidden" class="upload-file" name="img" value="${item.img}">
													                <a href="javascript:;" class="btn red fileinput-exists" data-dismiss="fileinput"> Remove </a>
													                <span class="help-inline"> 选择照片尺寸不能大于1M </span>
													            </div>
													        </div>
														</div>
														
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">详情:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-10">
		                                                        <textarea class="form-control input-inline input-medium" name="detail" placeholder="请输入产品描述...">${item.detail}</textarea>
		                                                    </div>
		                                                </div>
		                                            </div>
		                                            <div class="form-actions">
													    <div class="row">
													        <div class="col-md-offset-3 col-md-9">
													            <button type="button" class="btn green btn-save">保存</button>
													            <button type="button" class="btn default" onclick="history.back()">取消</button>
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
    
<%@include file="../common/layout.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>首页轮播图管理-永昌e篮子</title>
   	<script src="${ctx}/msun/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
    
    <script>
    $(function () {
	    $(".save-btn").click(function() {
	    	var turn=$('.turn').val();
	    	if(!(/^(\+|-)?\d+$/.test(turn)) || turn<=0){
	   	        alert("排序请输入正整数!");  
	   	     	$('.turn').val("0");  
	   	        return false;  
	   	    }
			$.ajax({
	   			url: "/admin/cms/slideshow",
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
	   					window.location.href = "${ctx}/admin/cms/slideshow";
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
		                <span>首页轮播图编辑</span>
		            </li>
		        </ul>
		        <div class="page-content-inner">
		            <div class="row">
		                <div class="col-md-12">
		                    <form class="form-horizontal form-row-seperated yc-form" action="#">
		                    	<input type="hidden" name="id" value="${slideshow.id}">
		                        <div class="portlet">
		                            <div class="portlet-title">
		                                <div class="caption"><i class="fa "></i>添加轮播图</div>
		                            </div>
		                            <div class="portlet-body">
		                                <div class="tabbable-bordered">
		                                    <ul class="nav nav-tabs">
		                                        <li class="active">
		                                            <a href="#tab_general" data-toggle="tab"> 轮播图内容 </a>
		                                        </li>
		                                    </ul>
		                                    <div class="tab-content">
		                                        <div class="tab-pane active" id="tab_general">
		                                        	<div class="form-body">
			                                        	<div class="form-group">
		                                                    <label class="col-md-2 control-label">标题:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium" 
		                                                        name="title" value="${slideshow.title}"> 
		                                                    </div>
		                                                </div>
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">链接:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium" 
		                                                        name="link" value="${slideshow.link}"> 
		                                                    </div>
		                                                </div>
		                                                <div class="form-group">
														    <label class="col-md-2 control-label">图片:</label>
													        <div class="col-md-9 fileinput fileinput-new" data-provides="fileinput">
													            <div class="fileinput-new thumbnail" style="width: 250px; height: 150px;">
													                <c:if test="${empty slideshow.pic}">
													                <img src="${ctx}/images/noimages.png" alt=""> 
													                </c:if>
                                               						<c:if test="${not empty slideshow.pic}">
                                               						<img src="${ctx}/img?img=${slideshow.pic}" alt=""/> 
                                               						</c:if>
													            </div>
													            <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 250px; max-height: 150px;"> </div>
													            <div>
													                <span class="btn default btn-file">
													                    <span class="fileinput-new"> Select image </span>
													                    <span class="fileinput-exists"> Change </span>
													                    <input type="file" class="upload" name="imgfile" value="${slideshow.pic}"> 
													                </span>
												                    <input type="hidden" class="upload-file" name="pic" value="${slideshow.pic}">
													                <a href="javascript:;" class="btn red fileinput-exists" data-dismiss="fileinput"> Remove </a>
													                <span class="help-inline"> 选择照片尺寸不能大于1M,尺寸为1366px 358px </span>
													            </div>
													        </div>
														</div>
														<div class="form-group">
		                                                    <label class="col-md-2 control-label">排序:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium turn" 
		                                                        name="turn" value="${slideshow.turn}"> 
		                                                    </div>
		                                                </div>
			                                            <div class="form-group">
		                                                    <label class="col-md-2 control-label">是否有效:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-10">
		                                                        <select class="table-group-action-input form-control input-medium" name="state">
		                                                            <option value="0" <c:if test="${model.state==0}">selected</c:if>>有效</option>
		                                                            <option value="1" <c:if test="${model.state==1}">selected</c:if>>无效</option>
		                                                        </select>
		                                                    </div>
		                                                </div>
		                                            </div>
		                                            <div class="form-actions">
													    <div class="row">
													        <div class="col-md-offset-3 col-md-9">
													            <button type="button" class="btn green save-btn">提交</button>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>需求竞标-永昌e篮子</title>
    <script>
    $(function () {
    	var startPrice=$("#startPrice").val();
    	var bidPrice=$("#bidPrice").val();
    	if(bidPrice >= startPrice){
    		alert("竞标价格只能小于起始价");
			return;
    	}
    	
	    $(".save-btn").click(function() {
			$.ajax({
	   			url: "/supplier/require/bid",
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
	   					window.location.href = "${ctx}/supplier/require/bid";
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
		                <span>需求竞标</span>
		            </li>
		        </ul>
		        <div class="page-content-inner">
		            <div class="row">
		                <div class="col-md-12">
		                    <form class="form-horizontal form-row-seperated yc-form" action="#">
		                    	<input type="hidden" name="id" value="${bid.id}">
		                    	<input type="hidden" name="requireId" value="${requireId}">
		                    	<input type="hidden" name="startPrice" id="startPrice" value="${require.startPrice}">
		                        <div class="portlet">
		                            <div class="portlet-title">
		                                <div class="caption">
		                                    <i class="fa "></i>填写竞标申请 
		                                </div>
		                            </div>
		                            <div class="portlet-body">
		                                <div class="tabbable-bordered">
		                                    <ul class="nav nav-tabs">
		                                        <li class="active">
		                                            <a href="#tab_general" data-toggle="tab"> 竞标内容 </a>
		                                        </li>
		                                    </ul>
		                                    <div class="tab-content">
		                                        <div class="tab-pane active" id="tab_general">
		                                        	<div class="form-body">
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">供应量:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium" name="bidCount"
		                                                        value="<fmt:formatNumber value="${data.bidCount}" type="currency" pattern="#0.00"/>" placeholder=""> 
		                                                    	<span class="help-inline"> 千克 </span>
		                                                    </div>
		                                                </div>
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">竞标价:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input id="bidPrice" type="text" class="form-control input-inline input-medium" name="bidPrice"
		                                                        value="<fmt:formatNumber value="${data.bidPrice}" type="currency" pattern="#0.00"/>" placeholder=""> 
		                                                    	<span class="help-inline"> 元 </span>
		                                                    </div>
		                                                </div>
		                                            </div>
		                                            
		                                            <div class="form-actions">
													    <div class="row">
													        <div class="col-md-offset-3 col-md-9">
													            <button type="button" class="btn green save-btn">申请</button>
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
    
<%@include file="../common/layout.jsp" %>
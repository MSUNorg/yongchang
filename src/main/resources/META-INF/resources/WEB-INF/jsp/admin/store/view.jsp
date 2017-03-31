<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>商品详情-永昌e篮子</title>
    <script>
    $(function () {
    	$(".item-state").change(function() {
   		  	var count=$(this).val();
	   		if(count == 2){  
	   			$(".item-description").attr("style", ""); 
	   	    } 
   		});
    	
	    $(".save-btn").click(function() {
			$.ajax({
	   			url: "/admin/item/viewUpdate/"+${item.id},
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
	   					alert(data.message);
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
                        <span>商品详情</span>
                    </li>
		        </ul>
		        <div class="page-content-inner">
		            <div class="row">
		                <div class="col-md-12">
		                    <form class="form-horizontal form-row-seperated  yc-form" action="#">
		                        <div class="portlet">
		                            <div class="portlet-title">
		                                <div class="caption"><i class="fa "></i>商品详情信息编辑</div>
		                            </div>
		                            <div class="portlet-body">
		                                <div class="tabbable-bordered">
		                                    <div class="tab-content">
		                                        <div class="tab-pane active" id="tab_general">
		                                        	<div class="form-body">
		                                        		<div class="form-group">
		                                        			<label class="col-md-2 control-label">图片: </label>
		                                        			<div class="col-md-9">
															<input type="hidden" name="img" value="${item.img}">
					                                        <c:if test="${empty item.img}">
											                <img src="${ctx}/images/noimages.png" alt="" width="240" height="160"> 
											                </c:if>
					                  						<c:if test="${not empty item.img}">
					                  						<img src="${ctx}/img?img=${item.img}" alt="" width="240" height="160"> 
					                  						</c:if>
					                  						</div>
														</div>
														<div class="form-group">
															<label class="col-md-2 control-label">名称: </label>
															<div class="col-md-9">
															<input type="text" class="form-control input-inline input-medium" name="title" value="${item.title}" readonly> 
															</div>
														</div>
														<div class="form-group">
															<label class="col-md-2 control-label">价格: </label>
															<div class="col-md-9">
															<input type="text" class="form-control input-inline input-medium" name="itemPrice" value="<fmt:formatNumber value="${item.itemPrice}" type="currency" pattern="#0.00"/>" readonly> 
															<span class="help-inline"> 元/千克 </span>
															</div>
														</div>
														<div class="form-group">
															<label class="col-md-2 control-label">供应量: </label>
															<div class="col-md-9">
															<input type="text" class="form-control input-inline input-medium" name="count" value="<fmt:formatNumber value="${item.count}" type="currency" pattern="#0.00"/>" readonly> 
															<span class="help-inline"> 千克 </span>
															</div>
														</div>
														<div class="form-group">
		                                                    <label class="col-md-2 control-label">状态:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <select class="table-group-action-input form-control input-medium item-state" name="state">
		                                                        <option value="0" <c:if test="${item.state == 0}">selected</c:if>>未审核</option>
		                                                        <option value="1" <c:if test="${item.state == 1}">selected</c:if>>正常出售中</option>
		                                                        <option value="2" <c:if test="${item.state == 2}">selected</c:if>>已停止</option>   
		                                                        </select>
		                                                    </div>
		                                                </div>
														<div class="form-group">
															<label class="col-md-2 control-label">详情: </label>
															<div class="col-md-9">
															<input type="text" class="form-control input-inline input-medium" name="detail" value="${item.detail}" readonly> 
															</div>
														</div>
														<div class="form-group">
					                                        <label class="col-md-2 control-label">平台评价：</label>
					                                        <div class="col-md-9">
					                                            <textarea class="form-control input-inline input-medium" 
					                                            name="comment" placeholder="请进行商品评价...">${item.comment}</textarea>
					                                        </div>
					                                    </div>
					                                    <div class="form-group item-description" style="display:none">
					                                        <label class="col-md-2 control-label">不通过理由：</label>
					                                        <div class="col-md-9">
					                                            <textarea class="form-control input-inline input-medium" 
					                                            name="description" placeholder="如不通过,请设置理由...">${item.description}</textarea>
					                                        </div>
					                                    </div>
					                                    
					                                    <div class="form-group">
		                                                    <label class="col-md-2 control-label">加价金额:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium" 
		                                                        name="priceAddAmount" 
		                                                        <c:if test="${not empty item.priceAddAmount}">
		                                                        value="<fmt:formatNumber value="${item.priceAddAmount}" type="currency" pattern="#0.00"/>" 
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
		                                                        <c:if test="${not empty item.freight}">
		                                                        value="<fmt:formatNumber value="${item.freight}" type="currency" pattern="#0.00"/>"
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
		                                                        <c:if test="${not empty item.loss}">
		                                                        value="<fmt:formatNumber value="${item.loss}" type="currency" pattern="#0.00"/>"
		                                                        </c:if>
		                                                        > 
		                                                    	<span class="help-inline"> 元/千克 </span>
		                                                    </div>
		                                                </div>
		                                            </div>
		                                            <div class="form-actions">
													    <div class="row">
													        <div class="col-md-offset-3 col-md-9">
													            <button type="button" class="btn green save-btn">保存</button>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>商品详情-永昌e篮子</title>
	<script type="text/javascript" src="${ctx}/js/esayui/jquery.easyui.min.js"></script>
    <script>
    $(function () {
	    $(".btn-save").click(function() {
	    	var count=$('.minOrderQty').val();
	    	var itemId=$('.itemId').val();
			$.ajax({
	   			url: "/buyer/cart",
	   			type: "POST",
	   			cache: false,
	   			dataType: "json",
	   			data: {"itemId":itemId,"count":count},
	   			success: function(data) {
	   				if(!data.status){
	   					alert(data.message);
	   					return;
	   				}
	   				if(data.status){
	   					//window.location.href = "${ctx}/buyer/cart";
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
                        <a href="index.html">首页</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>产品详情</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class="fa "></i>产品详情 </div>
                                </div>
		                        <div class="box-body">
		                        	<input type="hidden" class="itemId" value="${item.id}">
		                        	<input type="hidden" class="form-control minOrderQty" value="${item.product.minOrderQty}">
		                        	<div class="form-group">
										<c:if test="${empty item.img}">
						                <img src="${ctx}/images/noimages.png" alt="" width="200" height="150"> 
						                </c:if>
                         				<c:if test="${not empty item.img}">
                         				<img src="${ctx}/img?img=${item.img}" alt="" width="200" height="150" /> 
                         				</c:if>
									</div>
									<div class="form-group">
										<label for="remainCount">名称：${item.title}</label>
									</div>
									<div class="form-group">
										<label for="remainCount">价格：
										<fmt:formatNumber value="${item.itemPrice+item.priceAddAmount+item.freight+item.loss}"  type="currency" pattern="#0.00"/> 元/千克</label>
									</div>
									<div class="form-group">
										<label for="remainCount">详情：${item.detail}</label>
									</div>
									<div class="form-group">
										<label for="remainCount">平台评价：${item.comment}</label>
									</div>
		                        </div>                	
								<div>
									<button type="button" class="btn green btn-save">加入购物车</button>
									<button type="button" class="btn default" onclick="history.back()">返回</button>
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
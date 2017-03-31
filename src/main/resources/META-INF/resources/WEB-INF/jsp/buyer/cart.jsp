<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>购物车-永昌e篮子</title>
    <script>
    $(function () {
    	$(".count").change(function() {
   		  	var price=$(this).closest('tr').find('.price').html();
   		    var amount=count*price;
   		    $(this).closest('tr').find('.amount').html(amount.toFixed(2));
   		});
    	
    	$(".part").change(function() {
   		  	var part=$(this).val();
	   		if((/^(\+|-)?\d+$/.test(part)) && part>0){  
	   			var minOrder=$(this).closest('tr').find('.minOrderQty').val();
	   		  	var price=$(this).closest('tr').find('.price').html();
	   		 	var count=part*minOrder;
	   		    var amount=part*minOrder*price;
	   		    $(this).closest('tr').find('.count').val(count.toFixed(2));
	   		    $(this).closest('tr').find('.amount').html(amount.toFixed(2));
	   	    }else{  
	   	        alert("份数请输入正整数!");  
	   	     	$(this).val("0");  
	   	        return false;  
	   	    } 
   		});
    	
    	$(".btn-order").click(function() {
    		var trs=$('tbody tr');
        	var datas=[]; 
        	$.each(trs, function(key, val) {
       			var data = {};  
        		data["id"] = $(val).find('.cartId').val();  
        		data["count"] = $(val).find('.count').val(); 
        		datas.push(data);
       		});
        	if(datas == null || datas.length == 0){
        		alert('购物车为空');
        	}
        	
			$.ajax({
	   			url: "/buyer/order",
	   			type: "POST",
	   			cache: false,
	   			dataType: "json",
	   			data: JSON.stringify(datas),
		   		beforeSend: function(xhr) {
		             xhr.setRequestHeader("Accept", "application/json");
		             xhr.setRequestHeader("Content-Type", "application/json");
		        },
	   			success: function(data) {
	   				if(!data.status){
	   					alert(data.message);
	   					return;
	   				}
	   				if(data.status){
	   					window.location.href = "${ctx}/buyer/order";
	   				}
	   			},
	   			error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert("服务器错误码:"+XMLHttpRequest.status);
                }
	   		});
		});
    })
    function del(id) {
    	if(!id || !confirm("确定要删除吗?")) return;
		$.ajax({
   			url: "/buyer/cart/"+id,
   			type: "POST",
   			cache: false,
   			dataType: "json",
   			success: function(data) {
   				if(!data.status){
   					alert(data.message);
   					return;
   				}
   				if(data.status){
   					window.location.href = "${ctx}/buyer/cart";
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
                        <a href="index.html">首页</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>我的购物车</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption"><i class="fa "></i>购物车列表 </div>
                                </div>
                                <div class="portlet-body">
                                    <div class="table-container">
                                        <table class="table table-striped table-bordered table-hover table-checkable" id="datatable_products">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th width="15%"> 图片 </th>
                                                    <th width="12%"> 商品类目 </th>
                                                    <th width="12%"> 商品名称 </th>
                                                    <th width="10%"> 价格(元/千克)</th>
                                                    <th width="10%"> 采购份数(整数) </th>
                                                    <th width="8%"> 采购量(千克) </th>
                                                    <th width="8%"> 金额(元) </th>
                                                    <th width="5%"> 操作 </th>
                                                </tr>
                                            </thead>
                                            <tbody> 
                                            	<c:forEach items="${cartList.content}" var="data" varStatus="loopCounter">
                                            	<tr role="row" class="filter">
                                                    <td>
                                                    	<c:if test="${empty data.item.img}">
										                <img src="${ctx}/images/noimages.png" alt="" width="200" height="150"> 
										                </c:if>
                                    					<c:if test="${not empty data.item.img}">
                                    					<img src="${ctx}/img?img=${data.item.img}" alt="" width="200" height="150" /> 
                                    					</c:if>
                                                    </td>
                                                    <td>${data.item.product.category.name}</td>
                                                    <td>${data.item.title}</td>
                                                    <td class="price">
                                                    <fmt:formatNumber value="${data.item.itemPrice+data.item.priceAddAmount+data.item.freight+data.item.loss}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<input type="text" class="form-control part" name="part" value="<fmt:formatNumber value="${data.count/data.item.product.minOrderQty}" type="currency" pattern="#0"/>"/>
                                                    	<input type="hidden" class="minOrderQty" value="${data.item.product.minOrderQty}">
                                                    </td>
                                                    <td>
                                                    	<input type="text" class="form-control count" name="count" readonly value="<fmt:formatNumber value="${data.count}" type="currency" pattern="#0"/>"/>
                                                    	<input type="hidden" class="cartId" name="id" value="${data.id}">
                                                    </td>
                                                    <td class="amount">
                                                    <fmt:formatNumber value="${(data.item.itemPrice+data.item.priceAddAmount+data.item.freight+data.item.loss)*data.count}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                        <div class="margin-bottom-5">
	                                                        <button class="btn btn-sm btn-default filter-cancel margin-bottom"
	                                                        onclick="del(${data.id})">
	                                                            <i class="fa "></i> 删除
	                                                        </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                	<div class="form-actions">
									    <div class="row">
									        <div class="col-md-offset-3 col-md-9">
									            <button type="button" class="btn green btn-order">下订单</button>
									            <button type="button" class="btn default" onclick="history.back()">返回</button>
									        </div>
									    </div>
									</div>
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
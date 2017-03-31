<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="et" uri="/WEB-INF/tld/enum.tld"%>
<%@ page import="com.yongchang.b2b.cons.EnumCollections" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>订单-永昌e篮子</title>
    <script>
    function del(id) {
		if(!id) return;
		$.ajax({
   			url: "/buyer/order/"+id,
   			type: "POST",
   			cache: false,
   			dataType: "json",
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
	}
    function cancel(id) {
		if(!id) return;
		$.ajax({
   			url: "/buyer/order/cancel/"+id,
   			type: "POST",
   			cache: false,
   			dataType: "json",
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
                        <span>订单</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption"><i class="fa "></i>订单列表 </div>
                                </div>
                                <div class="portlet-body">
                                    <div class="table-container">
                                        <table class="table table-striped table-bordered table-hover table-checkable" id="datatable_products">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th width="15%"> 订单编号 </th>
                                                    <th width="7%"> 状态 </th>
                                                    <th width="10%"> 总价</th>
                                                    <th width="10%"> 物流 </th>
                                                    <th width="15%"> 支付状态 </th>
                                                    <th width="10%"> 操作 </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            	<!-- store_order --> 
                                            	<c:forEach items="${orderList.content}" var="data" varStatus="loopCounter">
                                            	<tr role="row" class="filter">
                                                    <td>${data.orderNum}</td>
                                                    <td>
                                                    	${et:str("OrderState", data.state)}
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.orderPrice}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>${data.expresType}</td>
                                                    <td>
                                                    	<c:if test="${data.payState == 0}">未支付</c:if>
                                                    	<c:if test="${data.payState == 1}">已支付</c:if>
                                                    	<c:if test="${data.payState == 2}">已发货</c:if>
													</td>
                                                    <td>
                                                        <div class="margin-bottom-5">
	                                                        <button class="btn btn-sm btn-primary filter-cancel margin-bottom"
	                                                        onclick="location.href='${ctx}/buyer/order/detail/${data.id}'">
	                                                            <i class="fa "></i> 查看
	                                                        </button>
	                                                    </div>
	                                                    <c:if test="${data.payState == 0}">
                                                        <div class="margin-bottom-5">
	                                                        <button class="btn btn-sm btn-default filter-cancel margin-bottom"
	                                                        onclick="cancel(${data.id})">
	                                                            <i class="fa "></i> 取消订单
	                                                        </button>
                                                        </div> 
                                                        </c:if>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
									<tags:pagination page="${orderList}"/>
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
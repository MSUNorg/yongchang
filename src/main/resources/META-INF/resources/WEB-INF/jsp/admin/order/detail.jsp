<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>订单信息-永昌e篮子</title>
    <script>
    $(function () {
	    $(".btn-primary").click(function() {
			$.ajax({
	   			url: "/admin/order/detail",
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
	   					window.location.href = "${ctx}/admin/order/buyer";
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
                        <span>订单详情</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption"><i class="fa "></i>订单详情信息 </div>
                                </div>
                                <div class="portlet-body">
                                    <div class="table-container">
                                        <table class="table table-striped table-bordered table-hover table-checkable" id="datatable_products">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th width="15%"> 图片 </th>
                                                    <th width="15%"> 商品类别 </th>
                                                    <th width="15%"> 商品名称 </th>
                                                    <th width="15%"> 价格(元/千克) </th>
                                                    <th width="15%"> 采购量(千克) </th>
                                                    <th width="10%"> 小计金额 </th>
                                                </tr>
                                            </thead>
                                            <tbody> 
                                            	<c:forEach items="${detailList.content}" var="data" varStatus="loopCounter">
                                            	<c:set var="totalAmount" value="${data.amount + totalAmount}"/>
                                            	<c:set var="count" value="${count + 1}"/>
                                            	<tr role="row" class="filter">
                                                    <td>
                                                    	<img src="${ctx}/images/noimages.png" height="100" width="140"  alt="">
                                                    </td>
                                                    <td>${data.item.product.category.name}</td>
                                                    <td>${data.item.title}</td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.price}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.amount}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                	<div class="row">                                                      
					    <div class="col-md-12">
					        <div class="well portlet light">
					            <div class="row static-info align-reverse">
					                <div class="col-md-8 name">订单总金额:</div>
					                <div class="col-md-3 value"><fmt:formatNumber value="${totalAmount}" type="currency" pattern="#0.00"/>元</div>
					            </div>
					            <div class="row static-info align-reverse">
					                <div class="col-md-8 name">货物总数量:</div>
					                <div class="col-md-3 value">${count}</div>
					            </div>
					        </div>
					    </div>
					</div>
					<c:if test="${order.payState == 1}">
					<form class="form-horizontal form-row-seperated yc-form" action="#">
		            <input type="hidden" name="id" value="${order.id}">
					<div class="row">                                                      
					    <div class="col-md-12">
					        <div class="well portlet light">
					            <div class="row static-info align-reverse">
					                <div class="col-md-8 name">物流公司:</div>
					                <div class="col-md-3 value"><input type="text" name="expresType" class="form-control input-inline input-medium" /></div>
					            </div>
					            <div class="row static-info align-reverse">
					                <div class="col-md-8 name">物流单号:</div>
					                <div class="col-md-3 value"><input type="text" name="expresNum" class="form-control input-inline input-medium" /></div>
					            </div>
					            <div class="row static-info align-reverse">
					                <div class="col-md-8 name">物流价格:</div>
					                <div class="col-md-3 value"><input type="text" name="expresPrice" class="form-control input-inline input-medium" /></div>
					            </div>
					            
					            <div class="row static-info align-reverse">
					            	 <div class="col-md-8 name">
					                	<button type="button" class="btn btn-primary">确认发货</button>
					            	 </div>
					            </div>
					        </div>
					    </div>
					</div>
					</form>
					</c:if>
					<c:if test="${order.payState == 2}">
					<form class="form-horizontal form-row-seperated yc-form" action="#">
		            <input type="hidden" name="id" value="${order.id}">
					<div class="row">                                                      
					    <div class="col-md-12">
					        <div class="well portlet light">
					            <div class="row static-info align-reverse">
					                <div class="col-md-8 name">物流公司:</div>
					                <div class="col-md-3 value">${order.expresType}</div>
					            </div>
					            <div class="row static-info align-reverse">
					                <div class="col-md-8 name">物流单号:</div>
					                <div class="col-md-3 value">${order.expresNum}</div>
					            </div>
					            <div class="row static-info align-reverse">
					                <div class="col-md-8 name">物流价格:</div>
					                <div class="col-md-3 value">
					                <fmt:formatNumber value="${order.expresPrice}" type="currency" pattern="#0.00"/>元</div>
					            </div>
					            <div class="row static-info align-reverse">
					                <div class="col-md-8 name">物流时间:</div>
					                <div class="col-md-3 value">${order.expresTime}</div>
					            </div>
					        </div>
					    </div>
					</div>
					</form>
					</c:if>
                </div>
            </div>
        </div>
    </div>
    <a href="javascript:;" class="page-quick-sidebar-toggler">
        <i class="icon-login"></i>
    </a>
</div>

</rapid:override> 
    
<%@include file="../../common/layout.jsp" %>
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
    	$(".btn-export").click(function() {
	    	var form=$("<form>");//定义一个form表单
	    	form.attr("style","display:none");
	    	form.attr("target","");
	    	form.attr("method","post");
	    	form.attr("action","${ctx}/supplier/order/detail/${orderId}");
	    	var input1=$("<input>");
	    	input1.attr("type","hidden");
	    	input1.attr("name","exportData");
	    	input1.attr("value",(new Date()).getMilliseconds());
	    	$("body").append(form);//将表单放置在web中
	    	form.append(input1);
	    	form.submit();
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
                                    <div class="actions">
									    <div class="btn-group">
									        <a class="btn btn-circle btn-default dropdown-toggle" href="javascript:;" data-toggle="dropdown" aria-expanded="false">
									            <i class="fa fa-share"></i>
									            <span class="hidden-xs"> 导出 </span>
									            <i class="fa fa-angle-down"></i>
									        </a>
									        <div class="dropdown-menu pull-right">
									            <li>
									                <a href="javascript:;" class="hidden-xs btn-export"> 导出Excel </a>
									            </li>
									        </div>
									    </div>
									</div>
                                </div>
                                <div class="portlet-body">
                                    <div class="table-container">
                                        <table class="table table-striped table-bordered table-hover table-checkable" id="datatable_products">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th width="15%"> 图片 </th>
                                                    <th width="15%"> 商品类别 </th>
                                                    <th width="15%"> 商品名称 </th>
                                                    <th width="10%"> 价格(元/千克) </th>
                                                    <th width="10%"> 供应量(千克) </th>
                                                    <th width="10%"> 小计金额 </th>
                                                </tr>
                                            </thead>
                                            <tbody> 
                                            	<c:forEach items="${detailList.content}" var="data" varStatus="loopCounter">
                                            	<c:set var="totalAmount" value="${data.amount + totalAmount}"/>
                                            	<c:set var="count" value="${count + 1}"/>
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
                                                    <td>
                                                    	<fmt:formatNumber value="${data.price}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>${data.amount}</td>
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
					                <div class="col-md-8 name"> 订单金额: </div>
					                <div class="col-md-3 value"><fmt:formatNumber value="${totalAmount}" type="currency" pattern="#0.00"/>元</div>
					            </div>
					            <div class="row static-info align-reverse">
					                <div class="col-md-8 name"> 订单货物数量: </div>
					                <div class="col-md-3 value">${count}</div>
					            </div>
					        </div>
					    </div>
					</div>
					<div class="row">                                                      
					    <div class="col-md-12">
					        <div class="well portlet light">
					            <div class="row static-info align-reverse">
					                <div class="col-md-8 name"> 物流信息: </div>
					                <div class="col-md-3 value"> 顺丰快递 </div>
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
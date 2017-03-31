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
  	<c:if test="${userType == 'supplier'}">
    <title>供应商订单详情报表-永昌e篮子</title>
  	</c:if>
  	<c:if test="${userType == 'buyer'}">
  	<title>采购商订单详情报表-永昌e篮子</title>
  	</c:if>
  	
    <script>
    $(function () {
    	$(".btn-export").click(function() {
	    	var form=$("<form>");//定义一个form表单
	    	form.attr("style","display:none");
	    	form.attr("target","");
	    	form.attr("method","post");
	    	form.attr("action","${ctx}/admin/rpt/order/detail/${userType}/${orderId}");
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
                        <c:if test="${userType == 'supplier'}">
					    <span>供货订单</span>
					  	</c:if>
					  	<c:if test="${userType == 'buyer'}">
					  	<span>采购订单</span>
					  	</c:if>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                	<div class="caption"><i class="fa "></i>订单详情列表 </div>
                                	
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
                                                    <c:if test="${userType == 'supplier'}">
												    <th width="10%"> 供应商名称 </th>
												  	</c:if>
												  	<c:if test="${userType == 'buyer'}">
												  	<th width="10%"> 采购商名称 </th>
												  	</c:if>
                                                    
                                                    <th width="15%"> 商品名称 </th>
                                                    <th width="15%"> 价格 </th>
												    <th width="15%"> 重量 </th>
												    <th width="15%"> 金额 </th>
                                                    <th width="10%"> 日期 </th>
                                                </tr>
                                            </thead>
                                            <tbody> 
                                            	<c:forEach items="${detailList}" var="data" varStatus="loopCounter">
                                            	<tr role="row" class="filter">
                                            		<c:if test="${userType == 'supplier'}">
												    <td>${data.itemUser.company}</td>
												  	</c:if>
												  	<c:if test="${userType == 'buyer'}">
												  	<td>${data.order.user.company}</td>
												  	</c:if>
                                                    
                                                    <td>${data.item.title}</td>
                                                    <td>${data.price}</td>
                                                    <td>${data.count}</td>
                                                    <td>${data.amount}</td>
												  	<td><fmt:formatDate value="${data.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
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

</rapid:override> 
    
<%@include file="../../common/layout.jsp" %>
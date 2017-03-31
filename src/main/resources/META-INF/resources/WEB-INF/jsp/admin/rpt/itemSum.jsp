<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>采购商品汇总报表-永昌e篮子</title>
    <script>
    $(function () {
    	$(".btn-export").click(function() {
	    	var form=$("<form>");//定义一个form表单
	    	form.attr("style","display:none");
	    	form.attr("target","");
	    	form.attr("method","post");
	    	form.attr("action","${ctx}/admin/rpt/itemSum");
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
                        <span>采购商品汇总</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption"><i class="fa "></i>采购商品汇总列表 </div>
                                    <div class="actions">
                                        <a href="javascript:;" class="btn btn-circle btn-info">
                                            <i class="fa fa-plus"></i>
                                            <span class="hidden-xs btn-export"> 导出Excel </span>
                                        </a>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <div class="table-container">
                                        <table class="table table-striped table-bordered table-hover table-checkable" id="datatable_products">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th width="10%"> 编号 </th>
                                                    <th width="10%"> 图片 </th>
                                                    <th width="15%"> 商品名称 </th>
                                                    <th width="8%"> 需求量(千克) </th>
                                                    <th width="8%"> 供应价格(元/千克) </th>
                                                    <th width="8%"> 金额(元) </th>
                                                    <th width="15%"> 供应商 </th>
                                                    <th width="15%"> 汇总日期 </th>
                                                    <th width="8%"> 成本(元) </th>
                                                    <th width="8%"> 运费(元) </th>
                                                    <th width="8%"> 损耗(元) </th>
                                                    <th width="8%"> 利润(元) </th>
                                                    <th width="10%"> 状态 </th>
                                                </tr>
                                            </thead>
                                            <tbody> 
                                            	<c:forEach items="${itemSumList.content}" var="data" varStatus="loopCounter">
                                            	<tr role="row" class="filter">
                                                    <td>${data.id}</td>
                                                    <td>
                                                    	<c:if test="${empty data.item.img}">
										                <img src="${ctx}/images/noimages.png" alt="" width="200" height="150"> 
										                </c:if>
                                    					<c:if test="${not empty data.item.img}">
                                    					<img src="${ctx}/img?img=${data.item.img}" alt="" width="200" height="150" /> 
                                    					</c:if>
                                                    </td>
                                                    <td>${data.item.title}</td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.item.getItemFullPrice()}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count*data.item.getItemFullPrice()}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>${data.item.user.company}</td>
                                                    <td><fmt:formatDate value="${data.createTime}" pattern="yyyy-MM-dd"/></td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count*data.item.getItemPrice()}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count*data.item.getFreight()}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count*data.item.getLoss()}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count*data.item.getPriceAddAmount()}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<c:if test="${data.state == 0}">未下单</c:if>
                                                    	<c:if test="${data.state == 1}">已下单</c:if>
                                                    	<c:if test="${data.state == 2}">关闭</c:if>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                	
                                	<tags:pagination page="${itemSumList}"/>
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
    
<%@include file="../../common/layout.jsp" %>
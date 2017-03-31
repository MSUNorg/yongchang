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
    <title>供应商订单汇总信息报表-永昌e篮子</title>
  	</c:if>
  	<c:if test="${userType == 'buyer'}">
  	<title>采购商订单汇总信息报表-永昌e篮子</title>
  	</c:if>
  	<link href="${ctx}/msun/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
  	
    <script>
    $(function () {
    	$(".btn-search").click(function() {
   			var storeId=$('#storeId').val();
   			var start=$('#date-start').val();
    		var end=$('#date-end').val();
   			window.location.href = "${ctx}/admin/rpt/order/${userType}?storeId="+storeId+"&start="+start+"&end="+end;
   		});
    	$(".btn-export").click(function() {
    		var storeId=$('#storeId').val();
    		var start=$('#date-start').val();
    		var end=$('#date-end').val();
    		
	    	var form=$("<form>");//定义一个form表单
	    	form.attr("style","display:none");
	    	form.attr("target","");
	    	form.attr("method","post");
	    	form.attr("action","${ctx}/admin/rpt/order/${userType}?storeId="+storeId+"&start="+start+"&end="+end);
	    	var input1=$("<input>");
	    	input1.attr("type","hidden");
	    	input1.attr("name","exportData");
	    	input1.attr("value",(new Date()).getMilliseconds());
	    	$("body").append(form);//将表单放置在web中
	    	form.append(input1);
	    	form.submit();
    	});
    	$(".btn-export-itemsum").click(function() {
    		var storeId=$('#storeId').val();
    		var start=$('#date-start').val();
    		var end=$('#date-end').val();
    		
	    	var form=$("<form>");//定义一个form表单
	    	form.attr("style","display:none");
	    	form.attr("target","");
	    	form.attr("method","post");
	    	form.attr("action","${ctx}/admin/rpt//order/buyer/itemsum?storeId="+storeId+"&start="+start+"&end="+end);
	    	var input1=$("<input>");
	    	input1.attr("type","hidden");
	    	input1.attr("name","exportData");
	    	input1.attr("value",(new Date()).getMilliseconds());
	    	$("body").append(form);//将表单放置在web中
	    	form.append(input1);
	    	form.submit();
    	});
    	
    	$('#date-picker-start').datetimepicker({  
	   	      format: 'yyyy-MM-dd hh:mm',  
	   	      language: 'ch',  
	   	      pickDate: true,  
	   	      pickTime: true,  
	   	      hourStep: 1,  
	   	      minuteStep: 15,  
	   	      secondStep: 30,  
	   	      inputMask: true  
 	    });
  		$('#date-picker-end').datetimepicker({  
	   	      format: 'yyyy-MM-dd hh:mm',  
	   	      language: 'ch',  
	   	      pickDate: true,  
	   	      pickTime: true,  
	   	      hourStep: 1,  
	   	      minuteStep: 15,  
	   	      secondStep: 30,  
	   	      inputMask: true  
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
                                	<div class="caption"><i class="fa "></i>订单信息汇总列表 </div>
                                	
                                </div>  
								<div class="portlet-title"> 
                                    <div class="col-md-4 col-sm-12">
								        <div class="table-group-actions pull-left">
								        	<c:if test="${userType == 'supplier'}">
										    <label class="control-label col-md-4">供应商</label>
										  	</c:if>
										  	<c:if test="${userType == 'buyer'}">
										  	<label class="control-label col-md-4">采购商</label>
										  	</c:if>
								            
								            <div class="col-md-2">
                                                 <select class="table-group-action-input form-control input-medium" id="storeId" name="storeId">
                                                 <option value="">无</option>
                                                 <c:forEach items="${userList}" var="data" varStatus="loopCounter">
                                                 <option value="${data.id}" <c:if test="${data.id == storeId}">selected</c:if>>${data.company}</option>
                                                 </c:forEach>
                                                 </select>
								            </div>
								        </div>
								    </div>
							   </div>
							   
							   <div class="portlet-title">   
							    
								    <div class="col-md-4 col-sm-12">
								        <div class="table-group-actions pull-left">
								            <label class="control-label col-md-4">开始日期</label>
								            <div class="col-md-2">
								                <div id="date-picker-start" class="input-group input-medium">
								                    <input type="text" id="date-start" class="form-control" value="${start}" readonly>
								                    <span class="input-group-btn add-on">
								                        <button class="btn default " type="button">
								                            <i class="fa fa-calendar"></i>
								                        </button>
								                    </span>
								                </div>
								            </div>
								        </div>
								    </div>
								    
								    <div class="col-md-4 col-sm-12">
								        <div class="table-group-actions pull-left">
								            <label class="control-label col-md-4">结束日期</label>
								            <div class="col-md-2">
								                <div id="date-picker-end" class="input-group input-medium">
								                    <input type="text" id="date-end" class="form-control" value="${end}" readonly>
								                    <span class="input-group-btn add-on">
								                        <button class="btn default " type="button">
								                            <i class="fa fa-calendar"></i>
								                        </button>
								                    </span>
								                </div>
								            </div>
								        </div>
								    </div>
							      
                                    <div class="actions">
									    <a href="javascript:;" class="btn btn-circle btn-info btn-search">
									        <i class="fa fa-search"></i>
									        <span class="hidden-xs"> 搜索 </span>
									    </a>
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
									            <c:if test="${userType == 'buyer'}">
											  	<li>
									                <a href="javascript:;" class="hidden-xs btn-export-itemsum"> 导出所有采购商品详情Excel </a>
									            </li>
											  	</c:if>
									        </div>
									    </div>
									</div>
                                </div>
                                <div class="portlet-body">
                                    <div class="table-container">
                                        <table class="table table-striped table-bordered table-hover table-checkable" id="datatable_products">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th width="15%"> 编号 </th>
                                                    <th width="10%"> 订单金额 </th>
                                                    <th width="15%"> 下单时间 </th>
                                                    
                                                    <c:if test="${userType == 'supplier'}">
												    <th width="15%"> 供应商 </th>
												  	</c:if>
												  	<c:if test="${userType == 'buyer'}">
												  	<th width="15%"> 采购商 </th>
												  	</c:if>
                                                    
                                                    <th width="10%"> 状态 </th>
                                                    <th width="10%"> 操作 </th>
                                                </tr>
                                            </thead>
                                            <tbody> 
                                            	<c:forEach items="${orderList.content}" var="data" varStatus="loopCounter">
                                            	<tr role="row" class="filter">
                                                    <td>${data.orderNum}</td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.orderPrice}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td><fmt:formatDate value="${data.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                                    
                                                    <c:if test="${userType == 'supplier'}">
												    <td>
                                                    <c:set var="iterator" value="${data.details.iterator()}"/> 
                                                    <c:if test="${iterator.hasNext()}">
                                                       ${iterator.next().itemUser.company}
                                                    </c:if>
                                                    </td>
												  	</c:if>
												  	<c:if test="${userType == 'buyer'}">
												  	<td>
												  	${data.user.company}
                                                    </td>
												  	</c:if>
												  	
                                                    <td>
                                                    	${et:str("OrderState", data.state)}
                                                    </td>
                                                    
                                                    <td>
                                                    	<div class="margin-bottom-5">
                                                            <button class="btn btn-sm btn-success filter-submit margin-bottom"
                                                            onclick="location.href='${ctx}/admin/rpt/order/detail/${userType}/${data.id}'">
                                                                <i class="fa "></i> 查看
                                                            </button>
                                                        </div>
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
</div>

</rapid:override> 
    
<%@include file="../../common/layout.jsp" %>
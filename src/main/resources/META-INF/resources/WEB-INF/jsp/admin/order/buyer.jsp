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
    <title>采购订单列表-永昌e篮子</title>
    <link href="${ctx}/msun/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
    <script>
    $(function () {
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
		$(".btn-search").click(function() {
			var start=$('#date-start').val();
    		var end=$('#date-end').val();
   			window.location.href = "${ctx}/admin/order/buyer?start="+start+"&end="+end;
   		});
    })
    function confirmPay(id) {
    	if(!id || !confirm("确定要修改付款状态吗?")) return;
		$.ajax({
   			url: "/admin/order/buyer/confirm/"+id,
   			type: "POST",
   			cache: false,
   			dataType: "json",
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
                        <a href="${ctx}/">首页</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>采购订单</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class="fa "></i>采购订单列表 </div>
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
                                                    <th width="15%"> 采购商 </th>
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
                                                    <td>${data.user.company}</td>
                                                    <td>
                                                    	<c:if test="${data.payState == 0}">未支付</c:if>
                                                    	<c:if test="${data.payState == 1}">已支付</c:if>
                                                    	<c:if test="${data.payState == 2}">已发货</c:if>
													</td>
                                                    <td>
                                                        <div class="margin-bottom-5">
                                                            <button class="btn btn-sm btn-success filter-submit margin-bottom"
                                                            onclick="location.href='${ctx}/admin/order/detail/${data.id}'">
                                                                <i class="fa "></i> 查看
                                                            </button>
                                                        </div>
                                                        <c:if test="${data.payState == 0}">
                                                        <div class="margin-bottom-5">
                                                            <button class="btn btn-sm btn-default filter-cancel margin-bottom"
                                                            onclick="confirmPay(${data.id})">
	                                                            <i class="fa "></i> 确认付款
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
    
<%@include file="../../common/layout.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>产品管理-永昌e篮子</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/js/esayui/css/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/js/esayui/css/icon.css">
	<script type="text/javascript" src="${ctx}/js/esayui/jquery.easyui.min.js"></script>
	
    <script>
    $(function () {
    	$(".checkAll").click(function() {
			if (this.checked) {
				$("input[name='chk']:checkbox").each(function() {
					$(this).prop("checked", true);
				});
			} else {
				$("input[name='chk']:checkbox").each(function() {
					$(this).prop("checked", false);
				});
			}
		});
    	
    	$(".tree-select").combotree({
 		   url: "${ctx}/category",
            cascadeCheck: $(this).is(':checked'),
            onCheck:function(node){
                var $titles=$(this).find("span.tree-hit");
                $titles.each(function(index,value){
                    $(this).siblings().eq(1).removeClass("tree-checkbox tree-checkbox0");
                })
            },
            onLoadSuccess: function () { 
         	   $('.tree-select').combotree('setValue', '${category.id}').combotree('setText','${category.name}');
            }
        });
    	
    	$(".btn-search").click(function() {
   			var categoryId=$('input[type="hidden"][name="categoryId"]').val();
   			window.location.href = "${ctx}/admin/product?categoryId="+categoryId;
   		});
    })
    
    function batchDel(){
    	var datas=[]; 
    	$.each($('input[type="checkbox"][name="chk"]:checked'), function(key, val) {
    		datas.push(eval($(val).closest('td').find('.productId').val()));
   		});
    	if(!datas || !confirm("确定要删除吗?")) return;
		$.ajax({
   			url: "/admin/product/batchDel",
   			type: "POST",
   			cache: false,
   			dataType: "json",
   			data:JSON.stringify(datas),
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
   					//window.location.href = "${ctx}/admin/product";
   				}
   			},
   			error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert("服务器错误码:"+XMLHttpRequest.status);
            }
   		});
    }
    
    function del(id) {
    	if(!id || !confirm("确定要删除吗?")) return;
		$.ajax({
   			url: "/admin/product/"+id,
   			type: "POST",
   			cache: false,
   			dataType: "json",
   			success: function(data) {
   				if(!data.status){
   					alert(data.message);
   					return;
   				}
   				if(data.status){
   					window.location.href = "${ctx}/admin/product";
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
                        <span>产品信息</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption"> <i class="fa "></i>产品信息列表 </div>
                                    <div class="actions">
                                        <a href="javascript:;" class="btn btn-circle btn-info add-btn" 
                                        onclick="location.href='${ctx}/admin/product/0'">
                                            <i class="fa fa-plus"></i>
                                            <span class="hidden-xs add-code"> 添加 </span>
                                        </a>
                                    </div>
                                </div>
                                
                                <div class="portlet-title">
                                    <div class="caption">
                                        <button class="btn btn-sm btn-default filter-cancel margin-bottom"
										onclick="batchDel()">
										    <i class="fa "></i> 批量删除
										</button>
                                    </div>
                                    
                                    <div class="col-md-4 col-sm-12">
								        <div class="table-group-actions pull-left">
								            <label class="control-label col-md-3">类别</label>
								            <div class="col-md-2">
                                                <select class="bs-select form-control bs-select-hidden input-medium tree-select" 
                                                name="categoryId" id="categoryId">
                                            	</select>
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
                                                    <th width="1%">
                                                    	<input type="checkbox" class="group-checkable checkAll"> 
                                                    </th>
                                                    <th width="10%"> 编号 </th>
                                                    <th width="15%"> 产品类别 </th>
                                                    <th width="15%"> 产品名称 </th>
                                                    <th width="10%"> 最小下单重量 </th>
                                                    <th width="8%"> 加价金额 </th>
                                                    <th width="8%"> 运费 </th>
                                                    <th width="8%"> 损耗 </th>
                                                    <th width="10%"> 状态 </th>
                                                    <th width="15%"> 操作 </th>
                                                </tr>
                                            </thead>
                                            <tbody> 
                                            	<c:forEach items="${productList.content}" var="data" varStatus="loopCounter">
                                            	<tr role="row" class="filter">
                                                    <td>
                                                    	<input type="checkbox" id="data-id-${loopCounter.count}" name="chk" class="group-checkable"> 
                                                    	<input type="hidden" class="productId" name="id" value="${data.id}"/>
                                                    </td>
                                                    <td>${data.id}</td>
                                                    <td>${data.category.name}</td>
                                                    <td>${data.title}</td>
                                                    <td>${data.minOrderQty}</td>
                                                    <td><fmt:formatNumber value="${data.priceAddAmount}" type="currency" pattern="#0.00"/></td>
                                                    <td><fmt:formatNumber value="${data.freight}" type="currency" pattern="#0.00"/></td>
                                                    <td><fmt:formatNumber value="${data.loss}" type="currency" pattern="#0.00"/></td>
                                                    <td>
                                                    	<c:if test="${data.state==0}">有效</c:if>
                                                    	<c:if test="${data.state==1}">无效</c:if>
                                                    </td>
                                                    <td>
                                                        <div class="margin-bottom-5">
                                                            <button class="btn btn-sm btn-success filter-submit margin-bottom" 
                                                            onclick="location.href='${ctx}/admin/product/${data.id}'">
                                                                <i class="fa "></i> 编辑
                                                            </button>
	                                                        <button class="btn btn-sm btn-default filter-cancel margin-bottom"
	                                                        onclick="del(${data.id})">
	                                                            <i class="fa "></i> 删除
	                                                        </button>
                                                        </div>
                                                        <div class="margin-bottom-5">
                                                        </div>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                	
                                	<tags:pagination page="${productList}"/>
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
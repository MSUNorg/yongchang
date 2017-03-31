<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>供货信息-永昌e篮子</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/js/esayui/css/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/js/esayui/css/icon.css">
	<script type="text/javascript" src="${ctx}/js/esayui/jquery.easyui.min.js"></script>
    <script>
    $(function () {
    	$(".part").change(function() {
   		  	var part=$(this).val();
   		 	if((/^(\+|-)?\d+$/.test(part)) && part>0){  
	   		 	var minOrder=$(this).closest('tr').find('.minOrderQty').val();
	   		 	var count=part*minOrder;
	   		    $(this).closest('tr').find('.count').val(count.toFixed(2));  
	   	    }else{  
	   	        alert("份数请输入正整数!");  
	   	     	$(this).val("1");
	   	        return false;
	   	    }
   		});
    	
	    $(".add-cart").click(function() {
	    	var count=$(this).closest('.filter').find('.count').val();
	    	var itemId=$(this).closest('td').find('.itemId').val();
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
	    $(".btn-export").click(function() {
	    	var categoryId="";
	    	var keyword="";
	    	var form=$("<form>");//定义一个form表单
	    	form.attr("style","display:none");
	    	form.attr("target","");
	    	form.attr("method","post");
	    	form.attr("action","${ctx}/buyer/list/export?categoryId="+categoryId+"&keyword="+keyword);
	    	var input1=$("<input>");
	    	input1.attr("type","hidden");
	    	input1.attr("name","exportData");
	    	input1.attr("value",(new Date()).getMilliseconds());
	    	$("body").append(form);//将表单放置在web中
	    	form.append(input1);
	    	form.submit();
    	});
	    
	    $(".tree-select").combotree({
		   url: "${ctx}/category?root=true",
           cascadeCheck: $(this).is(':checked'),
           valueField:'id',
           textField:'text',
           onCheck:function(node){
               var $titles=$(this).find("span.tree-hit");
               $titles.each(function(index,value){
                   $(this).siblings().eq(1).removeClass("tree-checkbox tree-checkbox0");
               })
           },
           onLoadSuccess: function () { 
        	   $('.tree-select').combotree('setValue', '${categoryId}').combotree('setText','<c:if test="${empty category}">无</c:if><c:if test="${not empty category}">${category.name}</c:if>');
           },
           onChange: function (categoryId) {
        	   $('#category_id').val(categoryId);
           }
        });
	    
	    $(".btn-search").click(function() {
   			var categoryId=$('#category_id').val();
   			var keyword=$('#keyword').val();
   			window.location.href = "${ctx}/buyer?categoryId="+categoryId+"&keyword="+keyword;
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
                        <span>供货列表</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption"><i class="fa "></i>供货列表 </div>
                                </div>
                                
                                <div class="portlet-title">   
								    <div class="col-md-4 col-sm-12">
								        <div class="table-group-actions pull-left">
								            <label class="col-md-2 control-label">上级类别:</label>
                                            <div class="col-md-9">
                                            	<input type="hidden" name="category_id" id="category_id" value="${categoryId}">
                                                <select class="bs-select form-control bs-select-hidden input-medium tree-select" 
                                                name="categoryId" id="categoryId">
                                                <option value="">无</option>
                                            	</select>
                                            </div>
								        </div>
								    </div>
								    
								    <div class="col-md-4 col-sm-12">
								        <div class="table-group-actions pull-left">
								            <label class="control-label col-md-4">关键词</label>
								            <div class="col-md-2">
								                <input type="text" class="form-control input-inline input-medium" id="keyword" name="keyword" value="${keyword}"> 
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
									        </div>
									    </div>
									</div>
                                </div>
                                
                                <div class="portlet-body">
                                    <div class="table-container">
                                        <table class="table table-striped table-bordered table-hover table-checkable" id="datatable_products">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th width="20%"> 图片 </th>
                                                    <th width="10%"> 商品类目 </th>
                                                    <th width="10%"> 商品名称 </th>
                                                    <th width="15%"> 供货标题 </th>
                                                    <th width="10%"> 价格(元/千克) </th>
                                                    <th width="8%"> 供应量(千克) </th>
                                                    <th width="8%"> 购买份数(整数) </th>
                                                    <th width="8%"> 购买数量(千克) </th>
                                                    <th width="8%"> 状态 </th>
                                                    <th width="10%"> 操作 </th>
                                                </tr>
                                            </thead>
                                            <tbody> 
                                            	<c:forEach items="${itemList.content}" var="data" varStatus="loopCounter">
                                            	<tr role="row" class="filter">
                                                    <td>
                                                    	<c:if test="${empty data.img}">
										                <img src="${ctx}/images/noimages.png" alt="" width="200" height="150"> 
										                </c:if>
                                    					<c:if test="${not empty data.img}">
                                    					<img src="${ctx}/img?img=${data.img}" alt="" width="200" height="150" /> 
                                    					</c:if>
                                                    </td>
                                                    <td>${data.product.category.name}</td>
                                                    <td>${data.product.title}</td>
                                                    <td>${data.title}</td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.itemPrice+data.priceAddAmount+data.freight+data.loss}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                   	<input type="text" class="form-control part" name="part" value="1"/>
                                                   	<input type="hidden" class="minOrderQty" value="${data.product.minOrderQty}">
                                                    </td>
                                                    <td>
                                                    <input type="text" class="form-control minOrderQty count" value="${data.product.minOrderQty}" readonly/>
                                                    </td>
                                                    <td>可采购</td>
                                                    <td>
                                                    	<input type="hidden" class="itemId" name="itemId" value="${data.id}">
                                                        <div class="margin-bottom-5">
                                                            <button class="btn btn-sm btn-success filter-submit margin-bottom"
                                                            onclick="window.location.href='${ctx}/buyer/view/${data.id }'">
                                                                <i class="fa "></i> 查看
                                                            </button>
                                                        </div>
                                                        <div class="margin-bottom-5">
                                                        	<button class="btn btn-sm btn-default filter-cancel margin-bottom add-cart">
	                                                            <i class="fa "></i> 加入购物车
	                                                        </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                	
                                	<tags:pagination page="${itemList}"/>
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
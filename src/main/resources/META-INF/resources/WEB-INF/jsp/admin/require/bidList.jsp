<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<rapid:override name="head">
	<title>供应商需求竞标-永昌e篮子</title>
	<script>
	//审核
    function modify(id,state) {
		if(!id) return;
		$.ajax({
   			url: "/admin/bid/modify",
   			type: "POST",
   			cache: false,
   			dataType: "json",
   			data: {"bidId":id,"state":state},
   			success: function(data) {
   				if(!data.status){
   					alert(data.message);
   					return;
   				}
   				if(data.status){
   					window.location.href = "${ctx}/admin/bid/${requireId}";
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
				<div class="container">
					<div class="page-title">
						<h1></h1>
					</div>
				</div>
			</div>
			<div class="page-content">
				<div class="container">
					<ul class="page-breadcrumb breadcrumb">
						<li><a href="${ctx}/">首页</a> <i class="fa fa-circle"></i></li>
						<li><span>供应商需求竞标</span></li>
					</ul>
					<div class="page-content-inner">
						<div class="row">
							<div class="col-md-12">
								<div class="portlet light">
									<div class="portlet-title">
										<div class="caption">
											<i class="fa "></i>需求竞标列表
										</div>
									</div>
									<div class="portlet-body">
										<div class="table-container">
											<table
												class="table table-striped table-bordered table-hover table-checkable"
												id="datatable_products">
												<thead>
													<tr role="row" class="heading">
														<th width="1%"><input type="checkbox" class="group-checkable"></th>
														<th width="10%">编号</th>
														<th width="10%">竞标商家</th>
														<th width="15%">商品名称</th>
														<th width="8%">供应重量(千克)</th>
														<th width="8%">竞标价格(元)</th>
														<th width="15%">申请时间</th>
														<th width="10%">状态</th>
														<th width="10%">操作</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${bidList.content}" var="data"
														varStatus="loopCounter">
														<tr role="row" class="filter">
															<td><input type="checkbox" class="group-checkable"></td>
															<td>${data.id}</td>
															<td>${data.user.company}</td>
															<td>${data.require.title}</td>
															<td>
															<fmt:formatNumber value="${data.bidCount}" type="currency" pattern="#0.00"/>
															</td>
															<td>
															<fmt:formatNumber value="${data.bidPrice}" type="currency" pattern="#0.00"/>
															</td>
															<td><fmt:formatDate value="${data.createTime}" pattern="yyyy-MM-dd"/></td>
															<td>
															<c:if test="${data.state == 0}">未审核</c:if>
															<c:if test="${data.state == 1}">审核通过</c:if>
                                                   			<c:if test="${data.state == 2}">审核不通过</c:if>
															</td>
															<td>
																<c:if test="${data.state == 0}">
																<div class="margin-bottom-5">
																	<button
																		class="btn btn-sm btn-success filter-submit margin-bottom"
																		onclick="modify(${data.id},1)">
																		<i class="fa "></i> 审核通过
																	</button>
																</div>
																</c:if>
																<c:if test="${data.state == 0}">
																<div class="margin-bottom-5">
																	<button
																		class="btn btn-sm btn-success filter-submit margin-bottom"
																		onclick="modify(${data.id},2)">
																		<i class="fa "></i> 不通过
																	</button>
																</div>
																</c:if>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>

										<tags:pagination page="${bidList}" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<a href="javascript:;" class="page-quick-sidebar-toggler"> <i
			class="icon-login"></i>
		</a>
	</div>

</rapid:override>

<%@include file="../../common/layout.jsp"%>
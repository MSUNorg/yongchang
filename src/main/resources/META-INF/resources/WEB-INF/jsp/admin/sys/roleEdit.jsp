<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>添加权限角色-永昌e篮子</title>
    <script>
    $(function () {
	    $(".save-btn").click(function() {
	    	var id=$("input[name='id']:hidden").val();
	    	var name=$("input[name='name']:text").val();
	    	var state=$("select[name='state']").val();
	    	var resources=[]; 
	    	$("input[name='resources']:checkbox:checked").each(function() {
	    		resources.push($(this).val());
			});
	    	
			$.ajax({
	   			url: "/admin/role",
	   			type: "POST",
	   			cache: false,
	   			dataType: "json",
	   			data: {'id':id,'name':name,'state':state,'resource':resources.join(',')},
	   			success: function(data) {
	   				console.log(data);
	   				if(!data.status){
	   					alert(data.message);
	   					return;
	   				}
	   				if(data.status){
	   					window.location.href = "${ctx}/admin/role";
	   				}
	   			},
	   			error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert("服务器错误码:"+XMLHttpRequest.status);
                }
	   		});
		});
    })
    $(function () {
	    $(".checker").click(function () {
	    	var ischeck = $(this).children().children('input').prop('checked');
	        $(this).children().children('input').prop("checked", !(ischeck === 'checked' || ischeck === 'true' || ischeck === true));
	    });
	});
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
                        <a href="${ctx}/admin/user">员工管理</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>角色权限</span>
                    </li>
		        </ul>
		        <div class="page-content-inner">
		            <div class="row">
		                <div class="col-md-12">
		                    <form class="form-horizontal form-row-seperated  yc-form" action="#">
		                    	<input type="hidden" name="id" value="${role.id}">
		                        <div class="portlet">
		                            <div class="portlet-title">
		                                <div class="caption">
		                                    <i class="fa "></i>角色权限信息编辑 
		                                </div>
		                            </div>
		                            <div class="portlet-body">
		                                <div class="tabbable-bordered">
		                                    <ul class="nav nav-tabs">
		                                        <li class="active">
		                                            <a href="#tab_general" data-toggle="tab"> 角色权限内容 </a>
		                                        </li>
		                                    </ul>
		                                    <div class="tab-content">
		                                        <div class="tab-pane active" id="tab_general">
		                                        	<div class="form-body">
		                                                <div class="form-group">
		                                                    <label class="col-md-2 control-label">角色名称:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-9">
		                                                        <input type="text" class="form-control input-inline input-medium" name="name" value="${role.name}"> 
		                                                    </div>
		                                                </div>
		                                                
		                                                <div class="form-group">
															<label class="col-md-2 control-label">资源选择: <span
																class="required"> * </span>
															</label>
															<div class="col-md-10">
																<div class="form-control height-auto">
																	<div class="slimScrollDiv"
																		style="position: relative; overflow: hidden; width: auto; height: auto;">
																		<div class="scroller"
																			style="height: auto; overflow: hidden; width: auto;" data-initialized="1">
																			<c:forEach  items="${resourceJson}" var="data" varStatus="loopCounter">
																			<ul class="list-unstyled">
																				<li>
																					<label>
																						<span><input type="checkbox" name="resources" 
																						<c:if test="${fn:contains(role.getResourceList(),data.get('link'))}">checked="true"</c:if>
																						value="${data.get('link')}" class="group-checkable"/>
																						</span>
																						${data.get('title')}
																					</label>
																					<c:if test="${not empty data.get('child')}">
																					<c:forEach  items="${data.get('child')}" var="child" varStatus="loopCounter">
																					<ul class="list-unstyled">
																						<li>
																							<label>
																							<span>
																							<input type="checkbox" name="resources" 
																							<c:if test="${fn:contains(role.getResourceList(),child.get('link'))}">checked="true"</c:if>
																							value="${child.get('link')}" class="group-checkable"/>
																							</span>
																							${child.get('title')}
																							</label>
																						</li>
																					</ul>
																					</c:forEach>
																					</c:if>
																				</li>
																			</ul>
																			</c:forEach>
																		</div>
																	</div>
																</div>
															</div>
														</div>

			                                            <div class="form-group">
		                                                    <label class="col-md-2 control-label">审核状态:
		                                                        <span class="required"> * </span>
		                                                    </label>
		                                                    <div class="col-md-10">
		                                                        <select class="table-group-action-input form-control input-medium" name="state">
		                                                            <option value="0" <c:if test="${role.state==0}">selected</c:if>>未审核</option>
		                                                            <option value="1" <c:if test="${role.state==1}">selected</c:if>>正常</option>
		                                                            <option value="2" <c:if test="${role.state==2}">selected</c:if>>停止</option>
		                                                        </select>
		                                                    </div>
		                                                </div>
		                                            </div>
		                                            <div class="form-actions">
													    <div class="row">
													        <div class="col-md-offset-3 col-md-9">
													            <button type="button" class="btn green save-btn">保存</button>
													            <button type="button" class="btn default"
													            onclick="history.back()">返回</button>
													        </div>
													    </div>
													</div>
		                                        </div>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                    </form>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
    </div>
</div>
</rapid:override> 
    
<%@include file="../../common/layout.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>员工管理-永昌e篮子</title>
    <script>
    function del(id) {
    	if(!id || !confirm("确定要删除吗?")) return;
		$.ajax({
   			url: "/admin/user/"+id,
   			type: "POST",
   			cache: false,
   			dataType: "json",
   			success: function(data) {
   				if(!data.status){
   					alert(data.message);
   					return;
   				}
   				if(data.status){
   					window.location.href = "${ctx}/admin/user";
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
                        <a href="${ctx}/admin/user">员工管理</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>员工信息</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption"><i class="fa "></i>员工列表 </div>
                                    <div class="actions">
                                        <a href="javascript:;" class="btn btn-circle btn-info"
                                        onclick="location.href='${ctx}/admin/user/0'">
                                            <i class="fa fa-plus"></i>
                                            <span class="hidden-xs add-user"> 添加 </span>
                                        </a>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <div class="table-container">
                                        <table class="table table-striped table-bordered table-hover table-checkable" id="datatable_products">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th width="10%"> 编号 </th>
                                                    <th width="10%"> 姓名 </th>
                                                    <th width="10%"> 邮箱 </th>
                                                    <th width="15%"> 联系电话 </th>
                                                    <th width="10%"> 公司名称 </th>
                                                    <th width="10%"> 添加时间 </th>
                                                    <th width="10%"> 角色 </th>
                                                    <th width="10%"> 状态 </th>
                                                    <th width="10%"> 操作 </th>
                                                </tr>
                                            </thead>
                                            <tbody> 
                                            	<c:forEach  items="${userList.content}" var="data" varStatus="loopCounter">
                                            	<tr role="row" class="filter">
                                                    <td>${data.id}</td>
                                                    <td>${data.realname}</td>
                                                    <td>${data.email}</td>
                                                    <td>${data.phone}</td>
                                                    <td>${data.company}</td>
                                                    <td><fmt:formatDate value="${data.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                                    <td>${data.role.name}</td>
                                                    <td>
                                                    	<c:if test="${data.state==0}">未审核</c:if>
                                                    	<c:if test="${data.state==1}">正常</c:if>
                                                    	<c:if test="${data.state==2}">停止</c:if>
                                                    </td>
                                                    <td>
                                                        <div class="margin-bottom-5">
                                                            <button class="btn btn-sm btn-success filter-submit margin-bottom"
                                                            onclick="location.href='${ctx}/admin/user/${data.id}'">
                                                                <i class="fa "></i> 权限
                                                            </button>
                                                        </div>
                                                        <div class="margin-bottom-5">
	                                                        <button class="btn btn-sm btn-default filter-cancel margin-bottom"
	                                                        onclick="del(${data.id})">
	                                                            <i class="fa "></i> 删除
	                                                        </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    
                                    <tags:pagination page="${userList}"/>
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
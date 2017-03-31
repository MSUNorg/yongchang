<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<c:if test="${empty pagesize}">
<c:set var="pagesize" value="10"/> 
</c:if>
<div class="row">
	<div class="col-md-7 col-sm-12">
		<div class="dataTables_paginate paging_bootstrap_number"
			id="sample_1_paginate">
			<ul class="pagination" style="visibility: visible;">
				<li class="prev disabled">
					<a href="#" title="Prev"> 
						<i class="fa fa-angle-left"></i>
					</a>
				</li>
				<li class="active"><a href="#">1</a></li>
				<li><a href="#">2</a></li>
				<li><a href="#">3</a></li>
				<li><a href="#">4</a></li>
				<li><a href="#">5</a></li>
				<li class="next">
					<a href="#" title="Next">
						<i class="fa fa-angle-right"></i>
					</a>
				</li>
			</ul>
		</div>
	</div>
</div>
<script src="${ctx}/js/URI.min.js"></script>
<script>
//参数传入要去的页面
function gotoPage(page) { 
	var uri = new URI(); 
	uri.setSearch("p", page);  
	location.href = uri.toString();  
}
</script>

<%@tag pageEncoding="UTF-8"%>
<%@ attribute name="page" type="org.springframework.data.domain.Page" required="true"%>
<%--  <%@ attribute name="paginationSize" type="java.lang.Integer" required="true"%> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
int paginationSize = page.getSize();
int current = (page== null) ? 1: (page.getNumber() + 1);

int count=10;
int begin = Math.max(1, current - count/2);
int end = Math.min(begin + (count - 1), page.getTotalPages());

request.setAttribute("current", current);
request.setAttribute("begin", begin);
request.setAttribute("end", end);
%>

<% if (page!= null && page.getContent() != null && page.getContent().size() >0){%>

<div class="row">
	<div class="col-md-7 col-sm-12">
		<div class="dataTables_paginate paging_bootstrap_number">
			<ul class="pagination" style="visibility: visible;">
				<li class="prev disabled">
					 <% if (page.hasPrevious()){%>
							<a href="javascript:void(0);" onclick="gotoPage('${current-1}')" title="上一页"><i class="fa fa-angle-left"></i></a>
					 <%}else{%>
							<a href="#" title="上一页"><i class="fa fa-angle-left"></i></a>
					 <%} %> 
				</li>
				
				<c:forEach var="i" begin="${begin}" end="${end}">
					<c:choose>
						<c:when test="${i == current}">
							<li class="active"><a href="#">${i}</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="javascript:void(0);" onclick="gotoPage('${i}')">${i}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<li class="next">
					<% if (page.hasNext()){%>
							<a href="javascript:void(0);" onclick="gotoPage('${current+1}')" title="下一页"><i class="fa fa-angle-right"></i></a>
					<%}else{%>
							<a href="#" title="下一页"><i class="fa fa-angle-right"></i></a>
					<%} %>
				</li>
			</ul>
		</div>
	</div>
</div>
<script src="${ctx}/js/URI.min.js"></script>
<script>
function gotoPage(page) { 
	var uri = new URI(); 
	uri.setSearch("p", page);  
	location.href = uri.toString();  
}
</script>
<%} %>

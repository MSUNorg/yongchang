<%@tag pageEncoding="UTF-8"%>
<%@ attribute name="page" type="org.springframework.data.domain.Page" required="true"%>
<%@ attribute name="paginationSize" type="java.lang.Integer" required="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    //int paginationSize =page.getSize();
    int current = page.getNumber() + 1;
    int begin = Math.max(1, current - paginationSize / 2);
    int end = Math.min(begin + (paginationSize - 1), page.getTotalPages());

    request.setAttribute("current", current);
    request.setAttribute("begin", begin);
    request.setAttribute("end", end);
%>

<nav>
	<ul class="pagination">
		<li>总计<b>${page.totalElements}</b>条结果
		</li>
		<%
		    if (page.hasPrevious()) {
		%>
		<%--有上一页 --%>
		<li><a href="?page=1">第一页&lt;&lt;</a></li>
		<li><a href="?page=${current-1}" aria-label="Previous"><span
				aria-hidden="true">&laquo;</span></a></li>
		<%
		    } else {
		%>
		<%--没有上一页 --%>
		<li class="disabled"><a href="#">&lt;&lt;</a></li>
		<li class="disabled"><a href="javascript:;"><span
				aria-hidden="true">&laquo;</span></a></li>
		<%
		    }
		%>
		<c:forEach var="i" begin="${begin}" end="${end}">
			<c:choose>
				<c:when test="${i == current}">
					<li class="active"><a href="?page=${i}">${i}</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="?page=${i}">${i}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<%
		    if (page.hasNext()) {
		%>
		<li><a href="?page=${current+1}" aria-label="Next"><span
				aria-hidden="true">&raquo;</span></a></li>
		<li><a href="?page=${page.totalPages}">最后一页&gt;&gt;</a></li>
		<%
		    } else {
		%>
		<li class="disabled"><a href="javascript:;"><span
				aria-hidden="true">&raquo;</span></a></li>
		<li class="disabled"><a href="#">&gt;&gt;</a></li>
		<%
		    }
		%>
	</ul>
</nav>

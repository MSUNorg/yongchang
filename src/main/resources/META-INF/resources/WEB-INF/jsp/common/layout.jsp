<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="zh-CN">
<!--<![endif]-->
<head>  
    <%@include file="meta.jsp"%>
    
    <rapid:block name="head">
    	<title>永昌e篮子-全国最大的蔬菜电商网站</title>  
    </rapid:block> 
</head>  
<body class="page-container-bg-solid page-boxed"> 
	<!-- header -->
    <rapid:block name="top">
    	<!-- main header -->
		<rapid:block name="main-header-container"> 
			<sec:authorize access="hasAuthority('BUYER')">
	    	<%@include file="header_buyer.jsp" %>
		    </sec:authorize>
		    <sec:authorize access="hasAuthority('SUPPLIER')">
	    	<%@include file="header_supplier.jsp" %>
		    </sec:authorize>
		    <sec:authorize access="hasAuthority('ADMIN')">
	    	<%@include file="header_admin.jsp" %>
		    </sec:authorize>
		    <sec:authorize access="isAnonymous()">
			<%@include file="header.jsp" %>
			</sec:authorize>
		</rapid:block>
    </rapid:block>  
    
    <!-- content -->
    <rapid:block name="content">  
    </rapid:block> 
     
    <!-- footer -->
    <rapid:block name="footer">
    	<%@include file="footer.jsp" %> 
    </rapid:block>  
</body>  
</html> 
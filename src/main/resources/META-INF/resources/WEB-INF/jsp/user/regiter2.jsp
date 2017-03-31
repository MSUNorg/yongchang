<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>注册-永昌e篮子</title>
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />
    <link href="${ctx}/msun/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/msun/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/msun/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/msun/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/msun/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/msun/global/plugins/cubeportfolio/css/cubeportfolio.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/msun/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
    <link href="${ctx}/msun/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/msun/pages/css/portfolio.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/msun/layouts/layout3/css/layout.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/msun/layouts/layout3/css/themes/default.min.css" rel="stylesheet" type="text/css" id="style_color" />
    <link href="${ctx}/msun/layouts/layout3/css/custom.min.css" rel="stylesheet" type="text/css" />
</rapid:override> 

<rapid:override name="top">

</rapid:override>

<rapid:override name="content">     
<div class="portlet-body">
    <!-- BEGIN FORM-->
    <form action="#" id="form_sample_1" class="form-horizontal" novalidate="novalidate">
        <div class="form-body">
            <div class="alert alert-danger display-hide">
                <button class="close" data-close="alert"></button> You have some form errors. Please check below. </div>
            <div class="alert alert-success display-hide">
                <button class="close" data-close="alert"></button> Your form validation is successful! </div>
            <div class="form-group">
                <label class="control-label col-md-3">Name
                    <span class="required" aria-required="true"> * </span>
                </label>
                <div class="col-md-4">
                    <input type="text" name="name" data-required="1" class="form-control"> </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3">Email
                    <span class="required" aria-required="true"> * </span>
                </label>
                <div class="col-md-4">
                    <input name="email" type="text" class="form-control"> </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3">URL
                    <span class="required" aria-required="true"> * </span>
                </label>
                <div class="col-md-4">
                    <input name="url" type="text" class="form-control">
                    <span class="help-block"> e.g: http://www.demo.com or http://demo.com </span>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3">Number
                    <span class="required" aria-required="true"> * </span>
                </label>
                <div class="col-md-4">
                    <input name="number" type="text" class="form-control"> </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3">Digits
                    <span class="required" aria-required="true"> * </span>
                </label>
                <div class="col-md-4">
                    <input name="digits" type="text" class="form-control"> </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3">Credit Card
                    <span class="required" aria-required="true"> * </span>
                </label>
                <div class="col-md-4">
                    <input name="creditcard" type="text" class="form-control">
                    <span class="help-block"> e.g: 5500 0000 0000 0004 </span>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3">Occupation&nbsp;&nbsp;</label>
                <div class="col-md-4">
                    <input name="occupation" type="text" class="form-control">
                    <span class="help-block"> optional field </span>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3">Select
                    <span class="required" aria-required="true"> * </span>
                </label>
                <div class="col-md-4">
                    <select class="form-control" name="select">
                        <option value="">Select...</option>
                        <option value="Category 1">Category 1</option>
                        <option value="Category 2">Category 2</option>
                        <option value="Category 3">Category 5</option>
                        <option value="Category 4">Category 4</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3">Multi Select
                    <span class="required" aria-required="true"> * </span>
                </label>
                <div class="col-md-4">
                    <select class="form-control" name="select_multi" multiple="">
                        <option value="Category 1">Category 1</option>
                        <option value="Category 2">Category 2</option>
                        <option value="Category 3">Category 3</option>
                        <option value="Category 4">Category 4</option>
                        <option value="Category 5">Category 5</option>
                    </select>
                    <span class="help-block"> select max 3 options, min 1 option </span>
                </div>
            </div>
        </div>
        <div class="form-actions">
            <div class="row">
                <div class="col-md-offset-3 col-md-9">
                    <button type="submit" class="btn green">Submit</button>
                    <button type="button" class="btn grey-salsa btn-outline">Cancel</button>
                </div>
            </div>
        </div>
    </form>
    <!-- END FORM-->
</div>
</rapid:override> 

<rapid:override name="footer">

</rapid:override> 
    
<%@include file="../common/layout.jsp" %>
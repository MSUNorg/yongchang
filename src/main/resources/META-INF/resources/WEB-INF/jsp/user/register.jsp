<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="renderer" content="webkit"/>
  <title>用户注册-永昌e篮子</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport"/>
  <link rel="stylesheet" href="${ctx}/css/admin/bootstrap/css/bootstrap.min.css" />
  <link rel="stylesheet" href="http://cdn.bootcss.com/font-awesome/4.4.0/css/font-awesome.min.css"/>
  <link rel="stylesheet" href="http://cdn.bootcss.com/ionicons/2.0.1/css/ionicons.min.css"/>
  <link rel="stylesheet" href="${ctx}/css/admin/dist/css/AdminLTE.min.css"/>
  <link rel="stylesheet" href="${ctx}/css/admin/dist/css/skins/skin-blue.min.css"/>
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>
<body class="hold-transition login-page">
<div class="login-box" style="width: 600px;">
  <div class="login-logo">
    <a href="${ctx}/">永昌e篮子</a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <p class="login-box-msg">注册一个新的账户</p>
	<c:if test="${param.error == 'phonecode'}"><p class="login-box-msg" style="color: red;">短信验证码错误！</p></c:if>
    <form action="${ctx}/register/${userType}" method="post" id="register-form">
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="登陆邮箱" name="email" value="">
        <span class="glyphicon form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="登陆密码" name="passwd" value="">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="单位名称" name="company" value="">
        <span class="glyphicon form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback xxg-area-select">
      	<select class="form-control" name="province" style="width:265px;margin-bottom: 15px;display:inline-block;zoom:1;margin-right: 27px;">
      		<option value="">选择省</option>
        </select>
        <select class="form-control" name="city" style="width:265px;margin-bottom: 15px;display:inline-block;zoom:1;">
          	<option value="">选择市</option>
        </select>
        <span class="glyphicon form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="详细地址" name="address" value="">
        <span class="glyphicon form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="联系人" name="name" value="">
        <span class="glyphicon form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="联系电话" name="phone" value="">
        <span class="glyphicon form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="认证码" name="code" id="code" value="">
        <span class="glyphicon form-control-feedback"></span>
        <span style="color: #666">认证码为空请联系电话：800-000-0000</span>
      </div>
      <div class="row">
        <div class="col-xs-8">
        	<a href="${ctx}/login">我已经注册过了，现在登录</a>
        </div>
        <!-- /.col -->
        <div class="col-xs-4">
          <button type="button" class="btn btn-primary btn-block btn-flat btn-register">注册</button>
        </div>
        <!-- /.col -->
      </div>
    </form>
    
  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<c:if test="${param.error == 'checkcode'}">
<script>
alert("短信验证码错误");
location.href = "${ctx}/register";
</script>
</c:if>

<script src="${ctx}/js/admin/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script src="${ctx}/js/admin/bootstrap/js/bootstrap.min.js"></script>
<script src="${ctx}/js/distpicker/distpicker.data.js"></script>
<script src="${ctx}/js/distpicker/distpicker.js"></script>
<script>
$(document).ready(function() {
	$(".xxg-area-select").distpicker();
	
	function showSucc($input, msg) {
		$input.attr("title", msg);
		$input.tooltip({
			duration:10,
			placement: "right",
			container: "body",
			trigger: "manual"
		}).tooltip('fixTitle').tooltip('show');
		$input.parent().addClass("has-succ");
	}
	function showError($input, msg) {
		$input.attr("title", msg);
		$input.tooltip({
			placement: "right",
			container: "body",
			trigger: "manual"
		}).tooltip('fixTitle').tooltip('show');
		$input.parent().addClass("has-error");
	}
	function hideError($input) {
		$input.tooltip('hide');
		$input.parent().removeClass("has-error");
	}
	/*
	$("input[name='phone']").change(function() {
		var $this = $(this);
		var phone = $this.val();
		if(!phone.match(/^1[0-9]{10}$/)) {
			showError($this, "手机号不正确");
			return;
		}
		hideError($this);
	});
	*/
	$("input[name='passwd']").change(function() {
		var $this = $(this);
		var password = $this.val();
		if(password.length < 8) {
			showError($this, "密码不能小于8位");
			return;
		}
		hideError($this);
	});
	/*
	$("#register-form").submit(function() {
		$("input[name='password']").change();
		//$("input[name='phone']").change();
		if($(this).find(".has-error").length > 0) {
			return false;
		}
	});
	*/
	$(".btn-register").click(function() {
		var $this = $(this);
		$("input[name='password']").change();
		if($(this).find(".has-error").length > 0) {
			return false;
		}
		$.ajax({
   			url: "${ctx}/register/${userType}",
   			type: "POST",
   			cache: false,
   			dataType: "json",
   			data: $('#register-form').serialize(),
   			success: function(data) {
   				if(!data.status){
   					showError($this, data.message);
   					return;
   				}
   				if(data.status){
   					showSucc($this, data.message);
   					window.location.href = "/";
   				}
   			},
   			error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert("服务器错误码:"+XMLHttpRequest.status);
            }
   		});
	});
});
</script>
</body>
</html>
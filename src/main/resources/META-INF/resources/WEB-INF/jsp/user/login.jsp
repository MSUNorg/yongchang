<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="renderer" content="webkit"/>
  <title>登录-永昌e篮子</title>
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
<div class="login-box">
  <div class="login-logo">
    <a href="${ctx}/" style="font-family: 'Microsoft Yahei'">永昌e篮子</a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <c:if test="${param.error != null}"><p class="login-box-msg" style="color: red;">用户名或密码错误！</p></c:if>
    <form action="${ctx}/login" method="post">
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="用户" name="username">
        <span class="glyphicon glyphicon-user form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="密码" name="password">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input style="float:left;width:200px;" type="text" class="form-control" placeholder="请输入图形验证码" name="code"/>
        <img style="float:right;width:120px;height: 34px;" src="${ctx}/verify/code" id="codeImg" onclick="this.src='${ctx}/verify/code?t='+new Date().getTime()"/>
      </div>
      <br/><br/><br/>
      <div class="row">
        <div class="col-xs-8">
        	<a href="${ctx}/register/buyer" style="line-height: 30px;">注册新账户</a>
        </div>
        <!-- /.col -->
        <div class="col-xs-4">
          <button type="submit" class="btn btn-primary btn-block btn-flat">登录</button>
        </div>
        <!-- /.col -->
      </div>
    </form>
  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->
</body>
</html>
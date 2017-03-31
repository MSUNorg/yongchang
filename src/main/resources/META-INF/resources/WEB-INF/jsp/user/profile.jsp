<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<rapid:override name="head">  
    <title>个人中心-永昌e篮子</title>
    <meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
    <link href="${ctx}/msun/pages/css/profile.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${ctx}/js/esayui/jquery.easyui.min.js"></script>
    <script src="${ctx}/msun/global/scripts/app.min.js" type="text/javascript"></script>
    <script src="${ctx}/msun/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
	
    <script>
    $(function () {
    	$(".upload").change(function() {
    		var current=$(this);
   		  	var uploadFile=$(this).val();
   		    var formData = new FormData(); 
   		    var ispost=false;
	   		jQuery.each(jQuery(this)[0].files, function(i, file) {
	   			var size=file.size/1024;
	   			if(size > 1024){
	   				alert('文件超过1M');
   					return;
	   			}
	   			formData.append('imgfile', file);
	   			ispost=true;
	   		});
	   		if(!ispost) return;
	   		$.ajax({
		   	     url: '${ctx}/upload',
		   	     type: 'POST',
		   	     data: formData,
		   	     async: false,
		   	     cache: false,
		   	     contentType: false,
		   	  	 dataType: 'json',
		   	     enctype: 'multipart/form-data',
		   	     processData: false,
		   	     success: function (data) {
		   	        console.log(data.message);
		   	     	if(!data.status){
	   					alert(data.message);
	   					return;
	   				}
	   				if(data.status){
	   					current.closest('div').find('.upload-file').val(data.data);
	   				}
		   	     },
	   			 error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert("服务器错误码:"+XMLHttpRequest.status);
                 }
	   	   });
   		});
    	
	    $(".btn-save").click(function() {
	    	$(this).closest('form').submit();
		});
	    $(".btn-save-ajax").click(function() {
	    	var form = $(this).closest('form');
	    	var url = $(this).closest('form').attr('action');
	    	var id = $(this).closest('.tab-pane').attr('id');
			$.ajax({
	   			url: url,
	   			type: "POST",
	   			cache: false,
	   			dataType: "json",
	   			data: form.serialize(),
	   			success: function(data) {
	   				console.log(data);
	   				if(!data.status){
	   					alert(data.message);
	   					return;
	   				}
	   				if(data.status){
	   					window.location.href = "${ctx}/profile";
	   				}
	   			},
	   			error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert("服务器错误码:"+XMLHttpRequest.status);
                }
	   		});
		});
    })
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
                        <span>${pageContext.request.remoteUser}</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="profile-sidebar">
                                <div class="portlet light profile-sidebar-portlet ">
                                    <div class="profile-userpic">
                                        <c:if test="${empty user.avatar}">
						                <img src="${ctx}/images/noimages.png" alt="" 
						               width="200" height="150" class="img-responsive"> 
						                </c:if>
                            			<c:if test="${not empty user.avatar}">
                            			<img src="${ctx}/img?img=${user.avatar}" alt="" class="img-responsive"> 
                            			</c:if>
                                    </div>
                                    <div class="profile-usertitle">
                                        <div class="profile-usertitle-name"> ${pageContext.request.remoteUser} </div>
                                    </div>
                                    <div class="profile-usermenu">
                                        <ul class="nav">
                                            <li class="active">
                                                <a href=${ctx}/profile><i class="icon-settings"></i> 个人信息 </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="profile-content">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="portlet light ">
                                            <div class="portlet-title tabbable-line">
                                                <div class="caption caption-md">
                                                    <i class="icon-globe theme-font hide"></i>
                                                    <span class="caption-subject font-blue-madison bold uppercase">个人中心</span>
                                                </div>
                                                <ul class="nav nav-tabs">
                                                    <li class="active">
                                                        <a href="#tab_1_1" data-toggle="tab">基础信息</a>
                                                    </li>
                                                    <li>
                                                        <a href="#tab_1_2" data-toggle="tab">我的图像</a>
                                                    </li>
                                                    <li>
                                                        <a href="#tab_1_3" data-toggle="tab">修改密码</a>
                                                    </li>
                                                    <li>
                                                        <a href="#tab_1_4" data-toggle="tab">所属公司</a>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="portlet-body">
                                                <div class="tab-content">
                                                    <!-- PERSONAL INFO TAB -->
                                                    <div class="tab-pane active" id="tab_1_1">
                                                        <form role="form" action="${ctx}/profile" enctype="multipart/form-data" method="post">
                                                            <div class="form-group">
                                                                <label class="control-label">昵称</label>
                                                                <input type="text" placeholder="张三" class="form-control" name="name" value="${user.name}"/> 
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label">真实姓名</label>
                                                                <input type="text" placeholder="张三" class="form-control" name="realname" value="${user.realname}"/> 
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label">手机号</label>
                                                                <input type="text" placeholder="18900000000" class="form-control" name="phone" value="${user.phone}"/> 
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label">邮箱</label>
                                                                <input type="text" placeholder="zxc@yahoo.com" class="form-control" name="email" value="${user.email}"/> 
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label">信誉等级</label>
                                                                <input type="text" placeholder="B级" class="form-control" value="${user.getLevelStr()}" readonly/> 
                                                            </div>
                                                            <div class="margiv-top-10">
                                                                <a href="javascript:;" class="btn green btn-save-ajax"> 保存 </a>
                                                                <a href="javascript:;" class="btn default"> 取消 </a>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <!-- END PERSONAL INFO TAB -->
                                                    <!-- CHANGE AVATAR TAB -->
                                                    <div class="tab-pane" id="tab_1_2">
                                                        <form action="${ctx}/avatar" role="form" enctype="multipart/form-data" method="post">
                                                            <div class="form-group">
                                                                <div class="fileinput fileinput-new" data-provides="fileinput">
                                                                    <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                                                        <c:if test="${empty user.avatar}">
														                <img src="${ctx}/images/noimages.png" alt=""> 
														                </c:if>
                                                   						<c:if test="${not empty user.avatar}">
                                                   						<img src="${ctx}/img?img=${user.avatar}" alt=""> 
                                                   						</c:if>
                                                                    </div>
                                                                    <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"> 
                                                                    </div>
                                                                    <div>
                                                                        <span class="btn default btn-file">
                                                                            <span class="fileinput-new"> 选择图片 </span>
                                                                            <span class="fileinput-exists"> 修改 </span>
                                                                            <input type="file" class="upload" name="avatarfile" value="${user.avatar}">
                                                                        </span>
                                                                        <input type="hidden" class="upload-file" name="avatar" value="${user.avatar}">
                                                                        <a href="javascript:;" class="btn default fileinput-exists" data-dismiss="fileinput"> 移除 </a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="margin-top-10">
                                                                <a href="javascript:;" class="btn green btn-save-ajax"> 保存 </a>
                                                                <a href="javascript:;" class="btn default" onclick="history.back()"> 取消 </a>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <!-- END CHANGE AVATAR TAB -->
                                                    <!-- CHANGE PASSWORD TAB -->
                                                    <div class="tab-pane" id="tab_1_3">
                                                        <form action="${ctx}/passwd" method="post">
                                                            <div class="form-group">
                                                                <label class="control-label">当前密码</label>
                                                                <input type="password" class="form-control" name="passwd" /> </div>
                                                            <div class="form-group">
                                                                <label class="control-label">新密码</label>
                                                                <input type="password" class="form-control" name="newpasswd" /> </div>
                                                            <div class="form-group">
                                                                <label class="control-label">确认密码</label>
                                                                <input type="password" class="form-control" name="confirpasswd" /> </div>
                                                            <div class="margin-top-10">
                                                                <a href="javascript:;" class="btn green btn-save-ajax"> 保存 </a>
                                                                <a href="javascript:;" class="btn default" onclick="history.back()"> 取消 </a>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <!-- END CHANGE PASSWORD TAB -->
                                                    <!-- PRIVACY SETTINGS TAB -->
                                                    <div class="tab-pane" id="tab_1_4">
                                                        <form action="${ctx}/company" enctype="multipart/form-data" method="post">
                                                            <div class="form-group">
                                                                <label class="control-label">公司名称</label>
                                                                <input type="text" placeholder="xxx农场" class="form-control" name="company" value="${user.company}"/> 
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label">省</label>
                                                                <input type="text" placeholder="上海" class="form-control" name="province" value="${user.province}"/> 
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label">市</label>
                                                                <input type="text" placeholder="上海" class="form-control" name="city" value="${user.city}"/> 
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label">区/县</label>
                                                                <input type="text" placeholder="徐汇区" class="form-control" name="county" value="${user.county}"/> 
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label">详细地址</label>
                                                                <input type="text" placeholder="详细地址" class="form-control" name="address" value="${user.address}"/> 
                                                            </div>
                                                            <div class="form-group">
															    <label class="control-label">公司logo:</label>
														        <div class="fileinput fileinput-new" data-provides="fileinput">
														            <div class="fileinput-new thumbnail" style="width: 300px; height: 150px;">
														                <c:if test="${empty user.logo}">
														                <img src="${ctx}/images/noimages.png" alt=""> 
														                </c:if>
                                                   						<c:if test="${not empty user.logo}">
                                                   						<img src="${ctx}/img?img=${user.logo}" alt=""> 
                                                   						</c:if>
														            </div>
														            <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"> </div>
														            <div>
														                <span class="btn default btn-file">
														                    <span class="fileinput-new"> Select image </span>
														                    <span class="fileinput-exists"> Change </span>
														                    <input type="file" class="upload" name="logofile" value="${user.logo}">
														                </span>
														                <input type="hidden" class="upload-file" name="logo" value="${user.logo}">
														                <a href="javascript:;" class="btn red fileinput-exists" data-dismiss="fileinput"> Remove </a>
														            </div>
														        </div>
															</div>
                                                            <div class="form-group">
                                                                <label class="control-label">公司QQ</label>
                                                                <input type="text" placeholder="QQ" class="form-control" name="qq" value="${user.qq}"/> 
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label">公司电话</label>
                                                                <input type="text" placeholder="mobile" class="form-control" name="mobile" value="${user.mobile}"/> 
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label">简介</label>
                                                                <textarea class="form-control" rows="3" name="aboutus" placeholder="关于我们">${user.aboutus}</textarea>
                                                            </div>
                                                            <div class="margiv-top-10">
                                                                <a href="javascript:;" class="btn green btn-save-ajax"> 保存 </a>
                                                                <a href="javascript:;" class="btn default" onclick="history.back()"> 取消 </a>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</rapid:override> 
    
<%@include file="../common/layout.jsp" %>
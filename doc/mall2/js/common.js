$(function(){
	//--------------------------------------------搜索框关键词占位符
	var ori_keyword = $('#keyword').attr('value');
	$('#keyword').val(ori_keyword);
	$('#keyword').focus(function(){
		if($(this).val()==ori_keyword){
			$(this).val('');
		}
	}).blur(function(){
		if($(this).val()==''){
			$(this).val(ori_keyword).css('color','');
		}
	}).keyup(function(){
		if($(this).val().length>0 && $(this).val()!=ori_keyword){
			$(this).css('color','#333');
		}
	});
	

	jQuery(".top-tools").slide({ type:"menu", titCell:".n", targetCell:".sub",effect:"slideDown",delayTime:300,triggerTime:0,returnDefault:true});

	jQuery(".slideshow").slide({mainCell:".hd ul",autoPlay:true,autoPage:true,titCell:".bd"});

	/* 购物车 */
	$('.shop-cart').hover(function(){
		$(this).addClass('shop_txt_hover')
		$('.shopBody').fadeIn('fast').css({'display':'block','opacity':1}).stop();	
	},function(){
		$(this).removeClass('shop_txt_hover')
		$('.shopBody').fadeOut('fast');
		$('.shopBody').hover(function(){	
			$('.shop-cart').addClass("shop_txt_hover");			
			$(this).stop().fadeIn('fast').css({'display':'block','opacity':1});
		},function(){
			$('.shop-cart').removeClass("shop_txt_hover")
			$('.shopBody').stop().fadeOut('fast');
		});
	});
	
	
});


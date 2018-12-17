/**
 * 
 */

//이미지 바꾸는 플러그인 함수
$.fn.extend({
	myPluginFn : function(){
		var count = 0;
		   
		setInterval(function(){
			  count++;
			  
			  $('#g').attr('src','resources/images/'+count+'.jpg');   
			   
			   if(count ==3){
				   count = 0;
			   }
		},2000);
	}
});

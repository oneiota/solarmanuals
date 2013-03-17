/********************************************* ROTATE FUNCTION *********************************************/

$(document).ready(function(){
 var _e = document.createElement("canvas").width
 $.fn.cssrotate = function(d) {  
    return this.css({
  '-moz-transform':'rotate('+d+'deg)',
  '-webkit-transform':'rotate('+d+'deg)',
  '-o-transform':'rotate('+d+'deg)',
  '-ms-transform':'rotate('+d+'deg)'
 }).prop("rotate", _e ? d : null)
 }; 
 var $_fx_step_default = $.fx.step._default;
 $.fx.step._default = function (fx) {
 if(fx.prop != "rotate")return $_fx_step_default(fx);
 if(typeof fx.elem.rotate == "undefined")fx.start = fx.elem.rotate = 0;
 $(fx.elem).cssrotate(fx.now)
 }; 


/********************************************* ABOUT SLIDESHOW CODE *********************************************/
	
	$('.slideshow div').each(function(){ 
		var rannum = randomMinToMax(-10,10);
		$(this).cssrotate(rannum);
	});

	
	$('.slideshow')
		.cycle({ 
	    	fx:    'shuffle',
	    	speed: '150',
	    	timeout: 5000, 
			/* pager:  '#nav', */
			height: 'auto',
			/* slideExpr: '.cycle', */
	    
	    	shuffle: { 
	        top:  230,
	        left: 100 
	        },
	});
	
	$('.slideshow').css('width','85%');
		
	function randomMinToMax(min,max) {
		var result = (max - min) + 1;
		var result2 = Math.floor(Math.random()*result+min);
		return result2;
		console.log(result2);
	}

});

    
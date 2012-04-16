$(".counter-number").each( function(i) {
	$(this).attr('id','num'+i);
});

function initializeTicker(ticnum) {
	
	var fticnum = ticnum;
	var numheight=10;
	addticker(fticnum);
	
	var s = String(fticnum);
	
	for (i=s.length;i>=0; i--) {
		var onum=s.charAt(i);			
		$("#num"+i).attr('value',onum);
	}
	$(".counter-number").each( function() {
		var nval=$(this).attr("value");
		if (!isNaN(nval)) {
			var nheight = Number(nval)*numheight*-1;
			$(this).animate({ top: nheight+'px'}, 0 );
		} 
		if (nval==','){
			$(this).animate({ top: '-180px'}, 0 );
		}
	});
}



function loadticker(ticnum) {
	/* var fticnum = add_commas(ticnum); */

	var fticnum = ticnum;
	var numheight=10;
	addticker(fticnum);
	
	// breaks going to zero
	// if (ticnum && ticnum != 0) { 
		
		var s = String(fticnum);
			
		for (i=s.length;i>=0; i--) {
				var onum=s.charAt(i);			
				$("#num"+i).attr('value',onum);
		}
	
		$(".counter-number").each( function() {
				var nval=$(this).attr("value");
				if (!isNaN(nval)) {
					var nheight = Number(nval)*numheight*-1;
					$(this).animate({ top: nheight+'px'}, 500 );
				} 
				if (nval==','){
					$(this).animate({ top: '-180px'}, 500 );
				}
 		});

	// }
}

function addticker(newnum) {

	var digitcnt = $(".counter-number").length-1; /* why -1? Makes it work tho */
	var nnum = String(newnum).length;

	var digitdiff = Number(nnum - Number(digitcnt));
	
	/* alert(nnum + '-' +  digitcnt + '=' + digitdiff) */
	
	if (digitdiff < 0) {
		var ltdig = (Number(nnum)); /* was (Number(nnum)-1) */
		$(".counter-number:gt(" + ltdig + ")").remove();
	}
	
	for(i=1;i<=digitdiff;i++) {
		$(".counter-wrap").append('<div class="counter-number" id="num' + (Number(digitcnt+i-1)) + '">&nbsp;</div>');
	}
}

function add_commas(nStr) {
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}
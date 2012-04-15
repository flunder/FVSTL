
	// analytics
  var _gaq = _gaq || []; _gaq.push(['_setAccount', 'UA-30905929-1']); _gaq.push(['_trackPageview']);
  (function() { var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true; ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s); })();

	// plugins
	// easing 1.3 http://gsgd.co.uk/sandbox/jquery/easing
	jQuery.easing['jswing'] = jQuery.easing['swing']; jQuery.extend( jQuery.easing, { easeInExpo: function (x, t, b, c, d) { return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b; }, easeOutExpo: function (x, t, b, c, d) { return (t==d) ? b+c : c * (-Math.pow(2, -10 * t/d) + 1) + b; } });

	// url parser 2.0 https://github.com/allmarkedup/jQuery-URL-Parser
	(function(h,f){var i={a:"href",img:"src",form:"action",base:"href",script:"src",iframe:"src",link:"href"},j=["source","protocol","authority","userInfo","user","password","host","port","relative","path","directory","file","query","fragment"],e={anchor:"fragment"},a={strict:/^(?:([^:\/?#]+):)?(?:\/\/((?:(([^:@]*):?([^:@]*))?@)?([^:\/?#]*)(?::(\d*))?))?((((?:[^?#\/]*\/)*)([^?#]*))(?:\?([^#]*))?(?:#(.*))?)/,loose:/^(?:(?![^:@]+:[^:@\/]*@)([^:\/?#.]+):)?(?:\/\/)?((?:(([^:@]*):?([^:@]*))?@)?([^:\/?#]*)(?::(\d*))?)(((\/(?:[^?#](?![^?#\/]*\.[^?#\/.]+(?:[?#]|$)))*\/?)?([^?#\/]*))(?:\?([^#]*))?(?:#(.*))?)/},c=/(?:^|&|;)([^&=;]*)=?([^&;]*)/g,b=/(?:^|&|;)([^&=;]*)=?([^&;]*)/g;function g(k,n){var p=decodeURI(k),m=a[n||false?"strict":"loose"].exec(p),o={attr:{},param:{},seg:{}},l=14;while(l--){o.attr[j[l]]=m[l]||""}o.param.query={};o.param.fragment={};o.attr.query.replace(c,function(r,q,s){if(q){o.param.query[q]=s}});o.attr.fragment.replace(b,function(r,q,s){if(q){o.param.fragment[q]=s}});o.seg.path=o.attr.path.replace(/^\/+|\/+$/g,"").split("/");o.seg.fragment=o.attr.fragment.replace(/^\/+|\/+$/g,"").split("/");o.attr.base=o.attr.host?o.attr.protocol+"://"+o.attr.host+(o.attr.port?":"+o.attr.port:""):"";return o}function d(l){var k=l.tagName;if(k!==f){return i[k.toLowerCase()]}return k}h.fn.url=function(l){var k="";if(this.length){k=h(this).attr(d(this[0]))||""}return h.url(k,l)};h.url=function(k,l){if(arguments.length===1&&k===true){l=true;k=f}l=l||false;k=k||window.location.toString();return{data:g(k,l),attr:function(m){m=e[m]||m;return m!==f?this.data.attr[m]:this.data.attr},param:function(m){return m!==f?this.data.param.query[m]:this.data.param.query},fparam:function(m){return m!==f?this.data.param.fragment[m]:this.data.param.fragment},segment:function(m){if(m===f){return this.data.seg.path}else{m=m<0?this.data.seg.path.length+m:m-1;return this.data.seg.path[m]}},fsegment:function(m){if(m===f){return this.data.seg.fragment}else{m=m<0?this.data.seg.fragment.length+m:m-1;return this.data.seg.fragment[m]}}}}})(jQuery);

	// functions
	$(document).ready(function(){
			$('#mainWrap').isotope({
		   	itemSelector: '.row',
				layoutMode : 'fitRows'
			
		  });
	})
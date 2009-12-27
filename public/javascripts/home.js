document.getElementsByClassName = function (cl) {
	var retnode = [];
	var myclass = new RegExp('\\b'+cl+'\\b');
	var elem = this.getElementsByTagName('*');
	for (var i = 0; i < elem.length; i++) {
		var classes = elem[i].className;
		if (myclass.test(classes)) retnode.push(elem[i]);
	}
	return retnode;
};
function getCurrent() {
	var contents = document.getElementsByClassName("content");
	for (i=0; i<contents.length; i++) {
		if (contents[i].style != null && contents[i].style.display == "block")
			return contents[i];
	}
	return null;
}
function showContent(x) {
	var xanchor = x;
	var x = "content_"+x;
	var current = getCurrent();
	if (current == null || current.id.indexOf("_") == -1)
		return;
	var canchor = current.id.substr(current.id.indexOf("_")+1);
	if (current.id != x) {
		$(current.id).style.display = "none";
		$(x).style.display = "block";
		$("buttona_"+canchor).style.display = "none";
		$("buttonb_"+xanchor).style.display = "none";
		$("buttona_"+xanchor).style.display = "block";
		$("buttonb_"+canchor).style.display = "block";
	}
}
function navUp() {
	oldtoppx = Number(document.getElementById('navwindow').style.top.substring(0,document.getElementById('navwindow').style.top.indexOf("px")));
	navTop = -54*document.getElementsByClassName("content").length+324;
	if (oldtoppx == navTop) {
		// we're at the bottom now
		$("arwbtndngrey").style.display = "none";
		$("arwbtndnorange").style.display = "block";
	}
	newtoppx = oldtoppx+54;
	if (newtoppx >= 0) {
		// reached the top
		newtoppx = 0;
		$("arwbtnuporange").style.display = "none";
		$("arwbtnupgrey").style.display = "block";
	}
	$("navwindow").style.top = String(newtoppx)+"px";
}
function navDn() {
	oldtoppx = Number(document.getElementById('navwindow').style.top.substring(0,document.getElementById('navwindow').style.top.indexOf("px")));
	if (oldtoppx == 0) {
		// we're at the top now
		$("arwbtnupgrey").style.display = "none";
		$("arwbtnuporange").style.display = "block";
	}
	newtoppx = oldtoppx-54;
	navTop = -54*document.getElementsByClassName("content").length+324;
	if (newtoppx <= navTop) {
		// reached the bottom
		newtoppx = navTop;
		$("arwbtndnorange").style.display = "none";
		$("arwbtndngrey").style.display = "block";
	}
	$("navwindow").style.top = String(newtoppx)+"px";
}	/*
	function navUp() {
		oldtoppx = Number(document.getElementById('navwindow').style.top.substring(0,document.getElementById('navwindow').style.top.indexOf("px")));
		if (oldtoppx == -<?php echo $navTop; ?>) {
			// we're at the bottom now
			document.getElementById('arwbtndngrey').style.display = "none";
			document.getElementById('arwbtndnorange').style.display = "block";
		}
		newtoppx = oldtoppx+54;
		if (newtoppx >= 0) {
			// reached the top
			newtoppx = 0;
			document.getElementById('arwbtnuporange').style.display = "none";
			document.getElementById('arwbtnupgrey').style.display = "block";
		}	
		document.getElementById('navwindow').style.top = String(newtoppx)+"px";
	}
	function navDn() {
		oldtoppx = Number(document.getElementById('navwindow').style.top.substring(0,document.getElementById('navwindow').style.top.indexOf("px")));
		if (oldtoppx == 0) {
			// we're at the top now
			document.getElementById('arwbtnupgrey').style.display = "none";
			document.getElementById('arwbtnuporange').style.display = "block";
		}
		newtoppx = oldtoppx-54;
		if (newtoppx <= -<?php echo $navTop; ?>) {
			// reached the bottom
			newtoppx = -<?php echo $navTop; ?>;
			document.getElementById('arwbtndnorange').style.display = "none";
			document.getElementById('arwbtndngrey').style.display = "block";
		}
		document.getElementById('navwindow').style.top = String(newtoppx)+"px";
	}
	*/
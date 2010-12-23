function left() {
  $('#carousellinkscontainer')[0].style.right = navright+"px";
  var x = $("#carousellinkscontainer")[0].style.right;
  if (x == "") x = "0px";
  var y = parseInt(x.substring(0,x.indexOf("px")));
  y -= 165;
  x = y+"px";
  if (y > navmin) {
    navright = y;
    $("#carousellinkscontainer").animate({right: x},"fast");
  }
}

function right() {
  $('#carousellinkscontainer')[0].style.right = navright+"px";
  var x = $("#carousellinkscontainer")[0].style.right;
  if (x == "") x = "0px";
  var y = parseInt(x.substring(0,x.indexOf("px")));
  y += 165;
  x = y+"px";
  if (y <= 0) {
    navright = y;
    $("#carousellinkscontainer").animate({right: x},"fast");
  }
}

function carousel(abbrev) {
  for (i=0; i<$('#carouselitemscontainer > div').size(); i++)
    if ($('#carouselitemscontainer > div')[i].id == "carouselitem_"+abbrev)
      break;
  x = ($("#carouselitemscontainer > div").size()-i-1)*-511;
  y = x+"px";
  $("#carouselitemscontainer").animate({right: y},"fast");
}
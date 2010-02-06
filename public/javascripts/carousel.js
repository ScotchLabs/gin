function left() {
  jQuery('#carousellinkscontainer')[0].style.right = navright+"px";
  var x = jQuery("#carousellinkscontainer")[0].style.right;
  if (x == "") x = "0px";
  var y = parseInt(x.substring(0,x.indexOf("px")));
  y -= 165;
  x = y+"px";
  if (y > navmin) {
    navright = y;
    jQuery("#carousellinkscontainer").animate({right: x},"fast");
  }
}

function right() {
  jQuery('#carousellinkscontainer')[0].style.right = navright+"px";
  var x = jQuery("#carousellinkscontainer")[0].style.right;
  if (x == "") x = "0px";
  var y = parseInt(x.substring(0,x.indexOf("px")));
  y += 165;
  x = y+"px";
  if (y <= 0) {
    navright = y;
    jQuery("#carousellinkscontainer").animate({right: x},"fast");
  }
}

function carousel(abbrev) {
  for (i=0; i<jQuery('#carouselitemscontainer > div').size(); i++)
    if (jQuery('#carouselitemscontainer > div')[i].id == "carouselitem_"+abbrev)
      break;
  x = (jQuery("#carouselitemscontainer > div").size()-i-1)*-511;
  y = x+"px";
  jQuery("#carouselitemscontainer").animate({right: y},"fast");
}
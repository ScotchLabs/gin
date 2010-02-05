function left() {
  jQuery('#carousellinkscontainer')[0].style.left = navleft+"px";
  var x = jQuery("#carousellinkscontainer")[0].style.left;
  if (x == "") x = "0px";
  var y = parseInt(x.substring(0,x.indexOf("px")));
  y += 165;
  x = y+"px";
  if (y <= 0) {
    navleft = y;
    jQuery("#carousellinkscontainer").animate({left: x},"fast");
  }
}

function right() {
  jQuery('#carousellinkscontainer')[0].style.left = navleft+"px";
  var x = jQuery("#carousellinkscontainer")[0].style.left;
  if (x == "") x = "0px";
  var y = parseInt(x.substring(0,x.indexOf("px")));
  y -= 165;
  x = y+"px";
  if (y > navmin) {
    navleft = y;
    jQuery("#carousellinkscontainer").animate({left: x},"fast");
  }
}

function carousel(abbrev) {
  for (i=0; i<jQuery('#carouselitemscontainer > div').size(); i++)
    if (jQuery('#carouselitemscontainer > div')[i].id == "carouselitem_"+abbrev)
      break;
  x = i*-511;
  y = x+"px";
  jQuery("#carouselitemscontainer").animate({left: y},"fast");
}
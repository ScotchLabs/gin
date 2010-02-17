function ticket(abbrev, type) {
  jQuery("#f_"+type+"_"+abbrev).hide();
  jQuery("#f_"+type+"_"+abbrev+"_form").hide();
  jQuery("#f_"+type+"_"+abbrev+"_valid").hide();
  // error checking
  if (type==null || abbrev == null) return;
  if (invalid(abbrev,type)) {
    jQuery("#f_"+type+"_"+abbrev).show();
    jQuery("#f_"+type+"_"+abbrev+"_valid").show();
  }
  else {
    email = jQuery("#e_"+type+"_"+abbrev).attr('value');
    // send request
    if (type == "alert") {
      jQuery.ajax({type: 'post', url: "/createticketalert/", data: {email: email, showid: abbrev}, success: function(data, textStatus, XMLHttpRequest){ticketSuccess(data);}, error: function(xhr){ticketError(xhr, abbrev, type);}});
    }
    else if (type == "rez") {
      
    }
    // loading gif
    jQuery("#cboxLoadedContent").hide();
    jQuery("#cboxLoadingGraphic").show();
  }
}

function ticketSuccess(data) {
  data = data.match(/\<div id='ticketAlert'\>([a-zA-Z\ ]+)\<\/div\>/)[1];
  jQuery("#cboxLoadingGraphic").hide();
  jQuery("#cboxLoadedContent").html(data);
  jQuery("#cboxLoadedContent").show();
}

function ticketError(xhr, abbrev ,type) {
  jQuery("#cboxLoadingGraphic").hide();
  jQuery("#f_"+type+"_"+abbrev).show();
  jQuery("#f_"+type+"_"+abbrev+"_form").show();
  jQuery("#cboxLoadedContent").show();
}

function invalid(abbrev, type) {
  email = jQuery("#e_"+type+"_"+abbrev).attr('value');
  if (type == "alert" && !email.match(/[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/))
      return true;
  return false;
}
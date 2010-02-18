function ticket(abbrev) {
  jQuery("#flash_"+abbrev).hide();
  jQuery("#flash_"+abbrev+"_form").hide();
  jQuery("#flash_"+abbrev+"_valid").hide();
  // error checking
  if (abbrev == null) return;
  type = jQuery("#form_"+abbrev+" > #type")[0].value;
  if (invalid(abbrev)) {
    jQuery("#flash_"+abbrev).show();
    jQuery("#flash_"+abbrev+"_valid").show();
  }
  else {
  email = jQuery("#form_"+abbrev+" > #email")[0].value;
    // send request
    if (type == "alert") {
      jQuery.ajax({type: 'post', url: "/createticketalert/", data: {email: email, showid: abbrev}, success: function(data){ticketSuccess(data, abbrev);}, error: function(){ticketError(abbrev);}});
    }
    else if (type == "rez") {
      name = jQuery("#form_"+abbrev+" > #name")[0].value;
      phone = jQuery("#form_"+abbrev+" > #phone")[0].value;
      perf = jQuery("#form_"+abbrev+" > #perf")[0].value;
      jQuery.ajax({type: 'post', url: "/createticketrez/", data: {name: name, phone: phone, email: email, perf: perf}, success: function(data){ticketSuccess(data, abbrev);}, error: function(){ticketError(abbrev);}});
    }
    // loading gif
    jQuery("#cboxLoadedContent").hide();
    jQuery("#cboxLoadingGraphic").show();
  }
}

function ticketSuccess(data, abbrev) {
  data = data.match(/\<div id='ticketResponse'\>([a-zA-Z\ ]+)\<\/div\>/)[1];
  jQuery("#cboxLoadingGraphic").hide();
  jQuery("#response_"+abbrev).html(data);
  jQuery("#response_"+abbrev).show();
  jQuery("#query_"+abbrev).hide();
  jQuery("#cboxLoadedContent").show();
}

function ticketError(xhr, abbrev) {
  jQuery("#cboxLoadingGraphic").hide();
  jQuery("#flash_"+abbrev).show();
  jQuery("#flash_"+abbrev+"_form").show();
  jQuery("#cboxLoadedContent").show();
}

function invalid(abbrev) {
  type = jQuery("#form_"+abbrev+" > #type")[0].value;
  email = jQuery("#form_"+abbrev+" > #email")[0].value;
  if (type == "alert" && !email.match(/[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/))
      return true;
  else if (type == "rez") {
    
  }
  return false;
}
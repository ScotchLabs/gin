function updateprice() {
  var hasid = document.getElementById("ticketrez_hasid_true").checked;
  var pricesum = 0;
  var qtysum = 0;
  for (var i=0; i<numperformances; i++) {
    var tix = parseInt(document.getElementById("form_quantity["+i+"]").value);
    if (isNaN(tix)) tix = 0;
    
    qtysum=qtysum+tix;
    var sectionid = parseInt(document.getElementById("form_section["+i+"]").value);
    var sectionprice;
    for (var j=0; j<sections.length; j++) {
      if (sections[j]["id"] == sectionid) {
        if (hasid)
          sectionprice = sections[j]["pricewithid"];
        else
          sectionprice = sections[j]["pricewoutid"];
      }
    }
    pricesum=pricesum+tix*sectionprice;
  }
  jQuery("#numtickets").html(""+qtysum);
  jQuery("#pricetickets").html(""+pricesum);
}

function reservetickets() {
  // set the form
  jQuery("#ticketrez_submit").attr("disabled","true");
  jQuery("#ticketrez_name").css("border","1px solid black");
  jQuery("#ticketrez_email").css("border","1px solid black");
  jQuery("#ticketrez_phone").css("border","1px solid black");
  for (var i=0; i<numperformances; i++)
    document.getElementById("form_quantity["+i+"]").style.border = "1px solid black";
  jQuery("#form_id").css("border",null);
  jQuery("#form_quantities").css("border",null);
  
  // get name, email, phone, hasid for the ticketrez object
  var ticketrez = new Array(5);
  var showid = jQuery("#ticketrez_showid").attr("value");
  ticketrez[0] = showid;
  ticketrez[1] = jQuery("#ticketrez_name").attr("value");
  ticketrez[2] = jQuery("#ticketrez_email").attr("value");
  ticketrez[3] = jQuery("#ticketrez_phone").attr("value");
  ticketrez[4] = jQuery("#ticketrez_hasid_true").attr("checked");
  var rezlineitems = new Array();
  var j=0;
  for (var i=0; i<numperformances; i++) {
    // get qty and sectionid for rezlineitem
    if (document.getElementById("form_quantity["+i+"]").value) {
      // rezlineitem = performance|sectionid|quantity
      rezlineitems[j] = document.getElementById("form_performance["+i+"]").value+"|"+
        document.getElementById("form_section["+i+"]").value+"|"+
        document.getElementById("form_quantity["+i+"]").value;
      j++;
    }
  }
  
  // if reservation is valid, send it out! otherwise set the form
  if (validateReservation()) {
    jQuery.ajax({type: 'post', url: '/tickets/create', data: {backto: showid, ticketrez: ticketrez, rezlineitems: rezlineitems}, success: function(data, status, xhr){reserveSuccess(data)}, error: function(xhr, status, thrown){reserveError()}})
  }
  else {
    jQuery("#ticketrez_submit").attr("disabled",null);
  }
  return false;
}

function reserveSuccess(data) {
  // set the form
  jQuery("#ticketrez_submit").attr("disabled",null);
  
  // munge data
  var pattern = /<div id='response' class='article'>(.*)<\/div>/
  data = pattern.exec(data)[1];
  
  colorbox(data);
}

function reserveError(xhr) {
  // set the form
  jQuery("#ticketrez_submit").attr("disabled",null);
  
  
  colorbox("There was an error contacting the server. Try again later or contact the <a href='mailto:webmaster@snstheatre.org'>system administrator</a>.");
}

function validateReservation() {
  var errorborder = "1px solid #f90";
  r = true;
  message = "There was an error with your input";
  
  // check name
  if (!jQuery("#ticketrez_name")[0].value) {
    message += "<br />name doesn't exist";
    jQuery("#ticketrez_name").css("border",errorborder)
    r = false;
  }
  
  // if email, check format
  if (jQuery("#ticketrez_email")[0].value) {
    var emailformat = /[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    if (emailformat.exec(jQuery("#ticketrez_email")[0].value) == null) {
      message += "<br />email format invalid";
      jQuery("#ticketrez_email").css("border",errorborder)
      r = false;
    }
  }
    
  // check phone
  if (!jQuery("#ticketrez_phone")[0].value) {
    message += "<br />phone doesn't exist";
    jQuery("#ticketrez_phone").css("border",errorborder)
    r = false;
  }
  else {
    var phoneformat = /^(?:(1)?\s*[-\/\.]?)?(?:\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(?:(?:[xX]|[eE][xX][tT])\.?\s*(\d+))*$/;
    if (phoneformat.exec(jQuery("#ticketrez_phone")[0].value) == null) {
      jQuery("#ticketrez_phone").css("border",errorborder)
      message += "<br />phone format invalid";
      r = false;
    }
  }
  
  // check hasid
  if (!jQuery("#ticketrez_hasid_true")[0].checked && !jQuery("#ticketrez_hasid_false")[0].checked) {
    message += "<br />hasid doesn't exist";
    jQuery("#form_id").css("border",errorborder)
    r = false;
  }
  
  qty=0;
  for (var i=0; i<numperformances; i++) {
    var val = document.getElementById("form_quantity["+i+"]").value;
    if (val != "" && isNaN(parseInt(val))) {
      message += "<br />quantity "+(i+1)+" is invalid";
      document.getElementById("form_quantity["+i+"]").style.border = errorborder;
      r = false;
    }
    else if (val != "") {
      qty += parseInt(val);
      sectionid = document.getElementById("form_section["+i+"]").value
      for (var j=0; j<sections.length; j++)
        if (sections[j]["id"] == sectionid && val > tickets[j][i]) {
          message += "<br />quantity "+(i+1)+" is over the maximum";
          document.getElementById("form_quantity["+i+"]").style.border = errorborder;
          r=false;
        }
    }
  }
  if (qty == 0) {
    message += "<br />quantity doesn't exist";
    jQuery("#form_quantities").css("border",errorborder)
    r = false;
  }
  if (message) colorbox(message);
  return r;
}

function colorbox(t) {
  jQuery("#ajaxresp")[0].innerHTML=t;
  jQuery.fn.colorbox({inline:true,href:"#ajaxresp",initialWidth:"50%",initialHeight:"50%",width:"50%",height:"50%",transition:"none",opacity:"0.3"});
}
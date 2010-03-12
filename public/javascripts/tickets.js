function updateprice() {
  var hasid = document.getElementById("form_id_yes").checked;
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
  jQuery("#form_submit").attr("disabled","true");
  jQuery("#form_name").css("border","1px solid black");
  jQuery("#form_email").css("border","1px solid black");
  jQuery("#form_phone").css("border","1px solid black");
  for (var i=0; i<numperformances; i++)
    document.getElementById("form_quantity["+i+"]").style.border = "1px solid black";
  jQuery("#form_id").css("border",null);
  jQuery("#form_quantities").css("border",null);
  //TODO show LIGHTBOX with loading symbol
  // get name, email, phone, hasid for the ticketrez object
  var ticketrez = new Array(5);
  ticketrez[0] = jQuery("#form_showid").attr("value");
  ticketrez[1] = jQuery("#form_name").attr("value");
  ticketrez[2] = jQuery("#form_email").attr("value");
  ticketrez[3] = jQuery("#form_phone").attr("value");
  ticketrez[4] = jQuery("#form_id_yes").attr("checked");
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
  if (validateReservation()) {
    alert('starting ajax.');
    jQuery.ajax({type: 'post', url: '/tickets/create', data: {ticketrez: ticketrez, rezlineitems: rezlineitems}, success: function(data, status, xhr){reserveSuccess(data)}, error: function(xhr, status, thrown){reserveError()}})
  }
  else {
    jQuery("#form_submit").attr("disabled",null);
  }
}

function reserveSuccess(data) {
  jQuery("#form_submit").attr("disabled",null);
  var pattern = /<div id='response'>(.*)<\/div>/
  data = pattern.exec(data)[1];
  //TODO if saved update ticket counts, else highlight certain fields LIGHTBOX
  alert("ajax success. '"+data+"'");
}

function reserveError(xhr) {
  jQuery("#form_submit").attr("disabled",null);
  alert("ajax failure");
  //TODO error message LIGHTBOX
}

function validateReservation() {
  var errorborder = "1px solid #f90";
  r = true;
  message = "";
  // check name
  if (!jQuery("#form_name")[0].value) {
    message += "name doesn't exist";
    jQuery("#form_name").css("border",errorborder)
    r = false;
  }
  
  // if email, check format
  if (jQuery("#form_email")[0].value) {
    var emailformat = /[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    if (emailformat.exec(jQuery("#form_email")[0].value) == null) {
      message += ((message == null)? "":"\n")+"email format invalid";
      jQuery("#form_email").css("border",errorborder)
      r = false;
    }
  }
    
  // check phone
  if (!jQuery("#form_phone")[0].value) {
    message += ((message == null)? "":"\n")+"phone doesn't exist";
    jQuery("#form_phone").css("border",errorborder)
    r = false;
  }
  else {
    var phoneformat = /^(?:(1)?\s*[-\/\.]?)?(?:\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(?:(?:[xX]|[eE][xX][tT])\.?\s*(\d+))*$/;
    if (phoneformat.exec(jQuery("#form_phone")[0].value) == null) {
      jQuery("#form_phone").css("border",errorborder)
      message += ((message == null)? "":"\n")+"phone format invalid";
      r = false;
    }
  }
  
  // check hasid
  if (!jQuery("#form_id_yes")[0].checked && !jQuery("#form_id_no")[0].checked) {
    message += ((message == null)? "":"\n")+"hasid doesn't exist";
    jQuery("#form_id").css("border",errorborder)
    r = false;
  }
  
  qty=0;
  for (var i=0; i<numperformances; i++) {
    var val = document.getElementById("form_quantity["+i+"]").value;
    if (val != "" && isNaN(parseInt(val))) {
      message += ((message == null)? "":"\n")+"quantity "+(i+1)+" is invalid";
      document.getElementById("form_quantity["+i+"]").style.border = errorborder;
      r = false;
    }
    else if (val != "")
      qty += parseInt(val);
  }
  if (qty == 0) {
    message += ((message == null)? "":"\n")+"quantity doesn't exist";
    jQuery("#form_quantities").css("border",errorborder)
    r = false;
  }
  
  // check not over maxtickets
  //TODO
  
  //TODO hide loading symbol, put error message in LIGHTBOX
  
  if (message) alert(message);
  return r;
}
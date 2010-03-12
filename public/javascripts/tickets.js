function updateprice() {
  var hasid = document.getElementById("form_id_yes").checked;
  var pricesum = 0;
  var qtysum = 0;
  for (var i=0; i<numperformances; i++) {
    var tix = parseInt(document.getElementById("form_performance["+i+"]").value);
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
  // disable reserve button, show lightbox with loading symbol
  // get name, email, phone, hasid for the ticketrez object
  // for each performance
    // get qty and sectionid
  // for rezlineitem object
  if (validateReservation())
    ;// send postdata
    // jQuery.ajax({type: 'post', url: '/createticketrez/', data: {name: name, email: email, phone: phone, hasid: hasid}, success: function(){reserveSuccess()}, error: function(){reserveError()}, comlete: function(){reserveComplete()} })
  // else enable reserve button, hide loading symbol, put response in lightbox, highlight certain boxes
}

function validateReservation() {
  r = true;
  // check name
  if (!jQuery("#form_name")[0].value) {
    alert("name doesn't exist");
    //TODO name doesn't exist
    r = false;
  }
  
  // if email, check format
  if (jQuery("#form_email")[0].value) {
    var emailformat = /[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    if (emailformat.exec(jQuery("#form_email")[0].value) == null) {
      alert("email format invalid");
      //TODO email format invalid
      r = false;
    }
  }
    
  // check phone
  if (!jQuery("#form_phone")[0].value) {
    alert("phone doesn't exist");//TODO phone doesn't exist
    r = false;
  }
  else {
    var phoneformat = /^(1\s*[-\/\.]?)?(\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(([xX]|[eE][xX][tT])\.?\s*(\d+))*$/;
    if (phoneformat.exec(jQuery("#form_phone")[0].value) == null) {
      //TODO phone format invalid
      alert("phone format invalid");
      r = false;
    }
  }
  
  // check hasid
  if (!jQuery("#form_id_yes")[0].checked && !jQuery("#form_id_no")[0].checked) {
    alert("hasid doesn't exist")//TODO hasid doesn't exist
    r = false;
  }
  
  qty=0;
  for (var i=0; i<numperformances; i++) {
    var val = document.getElementById("form_performance["+i+"]").value;
    if (val != "" && isNaN(parseInt(val))) {
      alert("performance "+i+" is invalid");//TODO performance is invalid
      r = false;
    }
    else if (val != "")
      qty += parseInt(val);
  }
  if (qty == 0) {
    alert("performance doesn't exist");//TODO performance doesn't exist
    r = false;
  }
}

function reserveComplete() {
  // enable reserve button, hide loading symbol, put response in lightbox
}

function reserveSuccess() {
  
}

function reserveError() {
  // highlight certain boxes
}
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
  // validate
    // if valid send postdata
    // else enable reserve button, hide loading symbol, put response in lightbox, highlight certain boxes
}

function reservecomplete() {
  // enable reserve button, hide loading symbol, put response in lightbox
}

function reservesuccess() {
  
}

function reservefailure() {
  // highlight certain boxes
}
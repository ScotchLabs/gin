function updateprice() {
  var hasid = document.getElementById("ticketrez_hasid_true").checked
  var pricesum = 0
  var qtysum = 0
  for (var i=0; i<numperformances; i++) {
    var tix = parseInt(document.getElementById("form_quantity["+i+"]").value)
    if (isNaN(tix)) tix = 0
    
    qtysum=qtysum+tix
    var sectionid = parseInt(document.getElementById("form_section["+i+"]").value)
    var sectionprice
    for (var j=0; j<sections.length; j++) {
      if (sections[j]["id"] == sectionid) {
        if (hasid)
          sectionprice = sections[j]["pricewithid"]
        else
          sectionprice = sections[j]["pricewoutid"]
      }
    }
    pricesum=pricesum+tix*sectionprice
  }
  jQuery("#numtickets").html(""+qtysum)
  jQuery("#pricetickets").html(""+pricesum)
}

function updatecounts() {
  for (var i=0; i<numperformances; i++) {
    // get the section and quantity
    var selectedsectionid = document.getElementById("form_section["+i+"]").value
    var selectedsectionnum
    for (var j=0; j<sections.length; j++) {
      if (sections[j]["id"]==selectedsectionid) {
        selectedsectionnum = j
        break
      }
    }
    var selectedquantity = parseInt(document.getElementById("form_quantity["+i+"]").value)
    if (!isNaN(selectedquantity)) {
      // update section
      tickets[selectedsectionnum][i] = tickets[selectedsectionnum][i]-selectedquantity
      // update view
      var updateinfo = ""
      for (var j=0; j<sections.length; j++) {
        if (updateinfo != "")
          updateinfo += " | "
        if (sections.length > 1)
          updateinfo += sections[j]["name"]+": "
        updateinfo += tickets[j][i]+" left"
      }
      document.getElementById("form_availableinfo["+i+"]").innerHTML = updateinfo
    }
  }
}

function reservetickets() {
  showLoading()
  // set the form
  jQuery("#ticketrez_submit").attr("disabled","true")
  jQuery("#ticketrez_name").css("border","1px solid black")
  jQuery("#ticketrez_email").css("border","1px solid black")
  jQuery("#ticketrez_emailconfirm").css("border","1px solid black")
  for (var i=0; i<numperformances; i++)
    document.getElementById("form_quantity["+i+"]").style.border = "1px solid black"
  jQuery("#form_id").css("border",null)
  jQuery("#form_quantities").css("border",null)
  
  // get name, email, hasid for the ticketrez object
  var ticketrez = new Array(5)
  var showid = jQuery("#ticketrez_showid").attr("value")
  ticketrez[0] = showid
  ticketrez[1] = jQuery("#ticketrez_name").attr("value")
  ticketrez[2] = jQuery("#ticketrez_email").attr("value")
  ticketrez[3] = jQuery("#ticketrez_hasid_true").attr("checked")
  var rezlineitems = new Array()
  var j=0
  for (var i=0; i<numperformances; i++) {
    // get qty and sectionid for rezlineitem
    if (document.getElementById("form_quantity["+i+"]").value) {
      // rezlineitem = performance|sectionid|quantity
      rezlineitems[j] = document.getElementById("form_performance["+i+"]").value+"|"+
        document.getElementById("form_section["+i+"]").value+"|"+
        document.getElementById("form_quantity["+i+"]").value
      j++
    }
  }
  
  // if reservation is valid, send it out! otherwise set the form
  if (validateReservation()) {
    jQuery.ajax({type: 'post', url: '/tickets/create', data: {backto: showid, ticketrez: ticketrez, rezlineitems: rezlineitems}, success: function(data, status, xhr){reserveSuccess(data)}, error: function(xhr, status, thrown){reserveError()}})
  }
  else {
    jQuery("#ticketrez_submit").attr("disabled",null)
  }
  return false
}

function reserveSuccess(data) {
  // set the form
  jQuery("#ticketrez_submit").attr("disabled",null)
  lastData = data
  // munge data
  var pattern = /<div id='response' class='article'>(.*)<\/div>/
  data = pattern.exec(data)[1]
  pattern = /<div id='ticketrezid' style='display:none;'>(.*)<\/div>/
  ticketrezid = pattern.exec(data)[1]
  jQuery.ajax({type: 'post', url: '/tickets/sendemail', data: {ticketrezid: ticketrezid}})
  ajaxresp(data)
  updatecounts()
}

function reserveError(xhr) {
  // set the form
  jQuery("#ticketrez_submit").attr("disabled",null)
  
  ajaxresp("<h1>There was an error contacting the server.</h1>Try again later or contact the <a href='mailto:webmaster@snstheatre.org'>system administrator</a>.")
}

function validateReservation() {
  var errorborder = "1px solid #f90"
  r = true
  message = "<h1>Something's gone wrong!</h1>"
  
  // check name
  if (!jQuery("#ticketrez_name")[0].value) {
    message += "<br />Please enter a name."
    jQuery("#ticketrez_name").css("border",errorborder)
    r = false
  }
  
  // if email, check format and confirm
  if (jQuery("#ticketrez_email")[0].value) {
    var emailformat = /[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+(?:\.[a-z0-9\!\#\$\%\&\'\*\+\/\=\?\^\_\`\{\|\}\~\-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/
    if (emailformat.exec(jQuery("#ticketrez_email")[0].value) == null) {
      message += "<br />Please enter a valid email address."
      jQuery("#ticketrez_email").css("border",errorborder)
      r = false
    }
    if (jQuery("#ticketrez_email")[0].value!=jQuery("#ticketrez_emailconfirm")[0].value) {
      message += "<br />The retyped email does not match the email address."
      jQuery("#ticketrez_email").css("border",errorborder)
      jQuery("#ticketrez_emailconfirm").css("border",errorborder)
      r = false
    }
  }
  else {
    message += "<br />Please enter a valid email address."
    jQuery("#ticketrez_email").css("border",errorborder)
    r = false
  }
  
  // check hasid
  if (!jQuery("#ticketrez_hasid_true")[0].checked && !jQuery("#ticketrez_hasid_false")[0].checked) {
    message += "<br />Please indicate whether you have a CMU ID."
    jQuery("#form_id").css("border",errorborder)
    r = false
  }
  
  qty=0
  for (var i=0; i<numperformances; i++) {
    var val = document.getElementById("form_quantity["+i+"]").value
    if (val != "" && isNaN(parseInt(val))) {
      message += "<br />Please enter a valid ticket quantity."
      document.getElementById("form_quantity["+i+"]").style.border = errorborder
      r = false
    }
    else if (val != "") {
      if (val < 0) {
        message += "<br />Please enter a positive number of tickets."
        document.getElementById("form_quantity["+i+"]").style.border = errorborder
        r=false
      }
      qty += parseInt(val)
      sectionid = document.getElementById("form_section["+i+"]").value
      for (var j=0; j<sections.length; j++)
        if (sections[j]["id"] == sectionid && val > tickets[j][i]) {
          message += "<br />There aren't that many tickets available."
          document.getElementById("form_quantity["+i+"]").style.border = errorborder
          r=false
        }
    }
  }
  if (qty == 0) {
    message += "<br />Please select your tickets."
    jQuery("#form_quantities").css("border",errorborder)
    r = false
  }
  if (!r) {
    ajaxresp(message)
  }
  return r
}

function showLoading() {
  jQuery.fn.colorbox({inline:true,href:"#ajaxloading",width:"650px",height:"100px",transition:"none",opacity:"0.3"})
}
function ajaxresp(t) {
  jQuery("#ajaxresp")[0].innerHTML=t
  colorbox("ajaxresp")
}
function colorbox(t) {
  jQuery.fn.colorbox({inline:true,href:"#"+t,width:"650px",height:"220px",transition:"none",opacity:"0.3"})
}
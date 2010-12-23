function updateprice() {
  var hasid = $("#ticketrez_hasid_true").attr('checked')
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
  $("#numtickets").html(""+qtysum)
  $("#pricetickets").html(""+pricesum)
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
  $("#ticketrez_submit").attr("disabled","true")
  $("#ticketrez_name").css("border","1px solid black")
  $("#ticketrez_email").css("border","1px solid black")
  $("#ticketrez_emailconfirm").css("border","1px solid black")
  for (var i=0; i<numperformances; i++)
    document.getElementById("form_quantity["+i+"]").style.border = "1px solid black"
  $("#form_id").css("border",null)
  $("#form_quantities").css("border",null)
  
  // get name, email, hasid for the ticketrez object
  var ticketrez = {
    show_id: $("#ticketrez_show_id").attr("value"),
    name: $("#ticketrez_name").attr("value"),
    email: $("#ticketrez_email").attr("value"),
    emailconfirm: $("#ticketrez_emailconfirm").attr("value"),
    hasid: $("#ticketrez_hasid_true").attr("checked")
  }
  var section = {}
  var quantity = {}
  var performance = {}
  for (var i=0; i<numperformances; i++) {
    section[i] = document.getElementById("form_section["+i+"]").value
    quantity[i] = document.getElementById("form_quantity["+i+"]").value
    performance[i] = document.getElementById("form_performance["+i+"]").value
  }
  var form = {
    section: section,
    quantity: quantity,
    performance: performance
  }
  
  var data = {
    commit: $("#ticketrez_submit").attr('value'),
    authenticity_token: $("#new_ticketrez [name='authenticity_token']").attr('value'),
    utf8: $("#new_ticketrez [name='utf8']").attr('value'),
    form: form,
    ticketrez: ticketrez,
    ajax: true
  }
  
  $.ajax({
    type: 'post',
    url: '/tickets/create',
    data: data,
    success: function(data, status, xhr){reserveSuccess(data)}, 
    error: function(xhr, status, thrown){reserveError(xhr, status, thrown)}
  })
  
  return false
}

function reserveSuccess(data) {
  // set the form
  $("#ticketrez_submit").attr("disabled",null)
  lastData = data
  // munge data
  var pattern = /<div id='response' class='article'>(.*)<\/div>/
  data = pattern.exec(data)[1]
  pattern = /<div id='ticketrezid' style='display:none;'>(.*)<\/div>/
  ticketrezid = pattern.exec(data)[1]
  pattern = /<div id='highlight' style='display:none;'>(.*)<\/div>/
  highlight = pattern.exec(data)[1]
  // highlight errors
  highlight = highlight.split("|")
  for (i=0; i<highlight.length; i++) {
    error = highlight[i]
    // weird for quantity
    if (error == "quantity")
      for (var j=0; j<numperformances; j++)
        document.getElementById("form_quantity["+j+"]").style.border = "1px solid #f90"
    else if (error == "email") {
      $("#ticketrez_email").css("border","1px solid #f90")
      $("#ticketrez_emailconfirm").css("border","1px solid #f90")
    }
    else if (error == "hasid")
      $("#form_id").css("border","1px solid #f90")
    else
      $("#ticketrez_"+error).css("border","1px solid #f90")
  }
  ajaxresp(data)
  updatecounts()
}

function reserveError(xhr, status, thrown) {
  // set the form
  $("#ticketrez_submit").attr("disabled",null)
  ajaxresp("<h1>There was an error contacting the server.</h1>Try again later or contact the <a href='mailto:webmaster@snstheatre.org'>system administrator</a>.<!-- thrown:"+thrown+", status:"+status+", xhr:"+xhr+" -->")
}

function showLoading() {
  $.fn.colorbox({inline:true,href:"#ajaxloading",width:"650px",transition:"none",opacity:"0.3"})
}
function ajaxresp(t) {
  $("#ajaxresp")[0].innerHTML=t
  colorbox("ajaxresp")
}
function colorbox(t) {
  $.fn.colorbox({
    inline: true,
    href: "#"+t,
    width: "650px",
    transition: "none",
    opacity: "0.3"
  })
}

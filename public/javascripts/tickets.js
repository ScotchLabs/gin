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

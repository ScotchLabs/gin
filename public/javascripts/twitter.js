function loadTweets() {
  var url = "http://twitter.com/statuses/user_timeline/snstheatre.json?callback=twitterCallback&count=1";
  var script = document.createElement('script');
  script.setAttribute('src',url)
  document.getElementsByTagName('head')[0].appendChild(script);
}

function twitterCallback(twitters) {
  var statusHTML = [];
  for (var i=0; i<twitters.length; i++){
    var username = twitters[i].user.screen_name;
    var status = twitters[i].text.replace(/((https?|s?ftp|ssh)\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/g, function(url) {
      return '<a href="'+url+'" target="_blank">'+url+'</a>';
    }).replace(/\B@([_a-z0-9]+)/ig, function(reply) {
      return  reply.charAt(0)+'<a href="http://twitter.com/'+reply.substring(1)+'" target="_blank">'+reply.substring(1)+'</a>';
    });
    statusHTML.push('<span class="tweet" style="display:block;">'+status+' <a class="tweetdate" href="http://twitter.com/'+username+'/statuses/'+twitters[i].id+'" target="_blank">'+relative_time(twitters[i].created_at)+'</a></span>');
  }
  document.getElementById('twittertext').innerHTML = statusHTML.join('');
  checkWidth();
}

function relative_time(time_value) {
  var values = time_value.split(" ");
  time_value = values[1] + " " + values[2] + ", " + values[5] + " " + values[3];
  var parsed_date = Date.parse(time_value);
  var relative_to = (arguments.length > 1) ? arguments[1] : new Date();
  var delta = parseInt((relative_to.getTime() - parsed_date) / 1000);
  delta = delta + (relative_to.getTimezoneOffset() * 60);

  if (delta < 60) {
    return 'less than a minute ago';
  } else if(delta < 120) {
    return 'about a minute ago';
  } else if(delta < (60*60)) {
    return (parseInt(delta / 60)).toString() + ' minutes ago';
  } else if(delta < (120*60)) {
    return 'about an hour ago';
  } else if(delta < (24*60*60)) {
    return 'about ' + (parseInt(delta / 3600)).toString() + ' hours ago';
  } else if(delta < (48*60*60)) {
    return '1 day ago';
  } else {
    return (parseInt(delta / 86400)).toString() + ' days ago';
  }
}

function checkWidth() {
  if (document.body.offsetWidth < 1260)
    $("#twitter_update_list").hide('slow');
  else if (document.body.offsetWidth >= 1260)
    $("#twitter_update_list").show('fast');
}

function showClickme() {
  if ($("#twitter_update_list")[0].style.display == "none")
    $("#twitter_heyclickme").show("fast");
}

function hideClickme() {
  $("#twitter_heyclickme").hide("fast");
  if ($("#twitter_update_list")[0].style.display != "none")
    window.onclick=hideTwitter
}

function showTwitter() {
  $("#twitter_heyclickme").hide("fast");
  $("#twitter_update_list").show('fast');
}

function hideTwitter() {
  checkWidth();
  window.onclick=null;
}
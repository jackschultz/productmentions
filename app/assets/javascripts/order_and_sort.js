function getUrlVars()
{
  if (window.location.search) {
    var vars = {}, hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars[hash[0]] = hash[1];
    }
    return vars;
  } else {
    return {};
  }
}

function time_frame_update() {
  url_vars = getUrlVars();
  delete url_vars.page; //if page is in there, go to start
  var url = window.location.href.split('?')[0];
  value = $('#time-frame-select').val();
  url_vars.tf = value;
  query_string = $.param(url_vars);
  tf_url = url + '?' + query_string;
  window.location = tf_url;
}

function sort_update() {
  url_vars = getUrlVars();
  delete url_vars.page; //if page is in there, go to start
  var url = window.location.href.split('?')[0];
  value = $('#sort-select').val();
  url_vars.sort = value;
  query_string = $.param(url_vars);
  sort_url = url + '?' + query_string;
  window.location = sort_url;
}

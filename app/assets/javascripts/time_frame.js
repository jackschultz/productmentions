function time_frame_update() {
  var url = window.location.href.split('?')[0];
  value = $('#time-frame-select').val();
  query_string = "?tf=" + value;
  tf_url = url + query_string;
  window.location = tf_url;
}

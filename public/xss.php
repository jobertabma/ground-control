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
  var img = document.createElement("img");

  img.src = "<?= domain_with_scheme(); ?>/file.php?" +
    "secret=<?= SECRET; ?>&file=pixel.png&extra[headers][0][key]=" +
    "Content-Type&extra[headers][0][value]=image/png";

  document.body.appendChild(img);
})();

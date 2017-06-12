<?php

require_once('../config.php');

validate_secret();

$url = fetch_key($_REQUEST, PARAMETER_URL);

if(!is_string($url) || strlen($url) == 0) {
  halt_for_usage('/redirect.php?url=https://external-link.com/');
}

collect_additional_headers();

update_access_log();

header('Location: ' . $url);

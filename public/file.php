<?php

require_once('../config.php');

validate_secret();

$file = fetch_key($_REQUEST, PARAMETER_FILE);

if(!is_string($file) || strlen($file) == 0) {
  halt_for_usage('/file.php?file=pixel.png');
}

collect_additional_headers();

update_access_log();

echo static_file($file);

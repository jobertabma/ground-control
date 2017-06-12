<?php

require_once('config.php');

validate_secret();

$body = fetch_key($_REQUEST, 'body');

if(!is_string($body) || strlen($body) == 0) {
  halt_for_usage('/ping.php?body=Whatever%20the%20server%20needs%20to%20return');
}

collect_additional_headers();

echo $body;

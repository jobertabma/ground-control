<?php

define('PARAMETER_SECRET', 'secret');
define('PARAMETER_URL', 'url');
define('PARAMETER_HEADERS', 'headers');
define('PARAMETER_HEADERS_KEY', 'key');
define('PARAMETER_HEADERS_VALUE', 'value');
define('PARAMETER_EXTRA', 'extra');
define('PARAMETER_BODY', 'body');

DEFINE('SECRET_FILE', '../secret');

function halt_for_usage($message) {
  die('USAGE: ' . $message . '.');
}

if(!file_exists(SECRET_FILE)) {
  halt_for_usage('file with secret is missing');
}

define('SECRET', trim(file_get_contents(SECRET_FILE)));

function fetch_key($array, $key, $default = '') {
  if(!is_array($array)) {
    return $default;
  }

  if(!array_key_exists($key, $array)) {
    return $default;
  }

  return $array[$key];
}

function validate_secret() {
  $secret = fetch_key($_REQUEST, PARAMETER_SECRET);

  if(!hash_equals(SECRET, $secret)) {
    halt_for_usage('append secret variable in order for the script to work');
  }
}

function extra_parameters() {
  $extra = fetch_key($_REQUEST, PARAMETER_EXTRA, []);

  return is_array($extra) ? $extra : [];
}

function collect_additional_headers() {
  $extra = extra_parameters();

  $headers = fetch_key($extra, PARAMETER_HEADERS, []);

  if(!is_array($headers)) {
    halt_for_usage('extra[headers] expects an array');
  }

  foreach($headers as $header) {
    $header_key = fetch_key($header, PARAMETER_HEADERS_KEY);
    $header_value = fetch_key($header, PARAMETER_HEADERS_VALUE);

    if(strlen($header_key) > 0) {
      header($header_key . ': ' . $header_value);
    }
  }
}

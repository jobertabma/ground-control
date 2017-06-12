<?php

define('SECRET', 'mysecret');

function halt_for_usage($message) {
  die('USAGE: ' . $message . '.');
}

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
  $secret = fetch_key($_REQUEST, 'secret');

  if(!hash_equals(SECRET, $secret)) {
    halt_for_usage('append secret variable in order for the script to work');
  }
}

function extra_parameters() {
  $extra = fetch_key($_REQUEST, 'extra', []);

  return is_array($extra) ? $extra : [];
}

function collect_additional_headers() {
  $extra = extra_parameters();

  $headers = fetch_key($extra, 'headers', []);

  if(!is_array($headers)) {
    halt_for_usage('extra[headers] expects an array');
  }

  foreach($headers as $header) {
    $header_key = fetch_key($header, 'key');
    $header_value = fetch_key($header, 'value');

    if(strlen($header_key) > 0) {
      header($header_key . ': ' . $header_value);
    }
  }
}

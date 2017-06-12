<?php

define('SECRET', 'mysecret');

function halt_for_usage($message) {
  die('USAGE: ' . $message . '.');
}

function validate_secret() {
  $secret = array_key_exists('secret', $_REQUEST) ? $_REQUEST['secret'] : '';

  if(!hash_equals(SECRET, $secret)) {
    halt_for_usage('append secret variable in order for the script to work');
  }
}

function extra_parameters() {
  $extra = array_key_exists('extra', $_REQUEST) ? $_REQUEST['extra'] : [];

  return is_array($extra) ? $extra : [];
}

function collect_additional_headers() {
  $extra = extra_parameters();

  $headers = array_key_exists('headers', $extra) ? $extra['headers'] : [];

  if(!is_array($headers)) {
    halt_for_usage('extra[headers] expects an array');
  }

  foreach($headers as $header) {
    $header_key = array_key_exists('key', $header) ? $header['key'] : '';
    $header_value = array_key_exists('value', $header) ? $header['value'] : '';

    if(strlen($header_key) > 0) {
      header($header_key . ': ' . $header_value);
    }
  }
}

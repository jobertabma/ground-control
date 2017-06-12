<?php

define('SECRET', 'mysecret');

function validate_secret() {
  $secret = array_key_exists('secret', $_REQUEST) ? $_REQUEST['secret'] : '';

  if(!hash_equals(SECRET, $secret)) {
    echo 'USAGE: append secret variable in order for the script to work.';
    exit;
  }
}

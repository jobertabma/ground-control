# Ground control
This is a collection of all my scripts that I use to debug Server Side Request Forgery (SSRF), blind XSS, and insecure XXE processing vulnerabilities. This is still a work in progress, as I'm still collecting all the scripts that I have lingering around.

## Requirements
Running this script requires PHP 5.6, a valid SSL certificate for a domain you own, and a web server that allows to open port `80`, `443`, `8080`, and `8443`. The use of each port will be explained in this document.

## Setting up
Clone this repository and point the root of your web server to the `public` directory.

## Functions

### Redirects
The `redirect.php` script is used to redirect a request to another server or endpoint. This may assist you when you need an external server to redirect back to an internal system. See below for examples.

```
curl -vv "http://server/redirect.php?secret=mysecret&url=http://169.254.169.254/latest/meta-data/"
```

### Ping
Sometimes, you simply need a page that responds with a certain body and headers. The `ping.php` script does exactly that. Here's a few examples.

```
curl -vv "http://server/ping.php?secret=mysecret&body=%3ch1%3eHello%3c/h1%3e"
```

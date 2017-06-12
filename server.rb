require 'webrick'
require 'webrick/https'
require 'openssl'

require_relative 'endpoints/redirect'
require_relative 'endpoints/ping_pong'
require_relative 'endpoints/file'

def get_argument(key)
  return unless ARGV.index(key)

  ARGV[ARGV.index(key) + 1]
end

if get_argument('-cert')
  cert = OpenSSL::X509::Certificate.new File.read get_argument('-cert')
  pkey = OpenSSL::PKey::RSA.new File.read get_argument('-cert')

  server = WEBrick::HTTPServer.new \
    Port: get_argument('-p'),
    SSLEnable: true,
    SSLCertificate: cert,
    SSLPrivateKey: pkey
else
  server = WEBrick::HTTPServer.new \
    Port: get_argument('-p')
end

trap 'INT' do
  server.shutdown
end

{
  '/redirect' => Endpoints::Redirect,
  '/pingpong' => Endpoints::PingPong,
  '/file' => Endpoints::File,
}.each do |endpoint, klass|
  server.mount_proc endpoint do |req, res|
    klass.new(req, res).call
  end
end

server.start

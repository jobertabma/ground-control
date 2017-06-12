require 'webrick'
require 'webrick/https'
require 'openssl'
require 'erb'

require_relative 'controllers/redirect_controller'
require_relative 'controllers/ping_pong_controller'
require_relative 'controllers/file_controller'
require_relative 'controllers/collect_controller'

require_relative 'helpers/console_helper'
require_relative 'helpers/string_helper'

if ConsoleHelper.get_argument('-cert')
  cert = OpenSSL::X509::Certificate.new File.read ConsoleHelper.get_argument('-cert')
  pkey = OpenSSL::PKey::RSA.new File.read ConsoleHelper.get_argument('-cert')

  server = WEBrick::HTTPServer.new \
    Port: ConsoleHelper.get_argument('-p'),
    SSLEnable: true,
    SSLCertificate: cert,
    SSLPrivateKey: pkey
else
  server = WEBrick::HTTPServer.new \
    Port: ConsoleHelper.get_argument('-p')
end

trap 'INT' do
  server.shutdown
end

[
  RedirectController,
  PingPongController,
  FileController,
  CollectController,
].each do |klass|
  endpoint = format('/%s', klass.to_s.underscore.gsub(/_controller/, ''))

  server.mount_proc endpoint do |req, res|
    methods = %w(get post)

    if methods.include?(req.request_method.downcase)
      klass.new(req, res).send(req.request_method.downcase)
    else
      res.status = 501
    end
  end
end

server.start

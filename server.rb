require 'webrick'
require 'webrick/https'
require 'openssl'

require_relative 'controllers/redirect_controller'
require_relative 'controllers/ping_pong_controller'
require_relative 'controllers/file_controller'

def get_argument(key)
  return unless ARGV.index(key)

  ARGV[ARGV.index(key) + 1]
end

# simplified version of Rails' String#underscore method
def underscore(camel_cased_word)
  word = camel_cased_word.to_s.dup
  word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
  word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
  word.tr!("-", "_")
  word.downcase!
  word
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

[
  RedirectController,
  PingPongController,
  FileController,
].each do |klass|
  endpoint = format('/%s', underscore(klass).gsub(/_controller/, ''))

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

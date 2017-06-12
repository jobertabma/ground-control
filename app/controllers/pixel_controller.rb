require_relative '../controller'

require 'json'

class PixelController < Controller
  def get
    extra = CONFIG['callback_tokens'][params['callback_token']] || {}

    log_request \
      format('HTML injection callback captured', @url),
      vulnerability_data: extra

    res.content_type = 'image/png'
    res.body = IO.read('static/pixel.png')
  end
end

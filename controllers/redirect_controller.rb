require_relative '../controller'

class RedirectController < Controller
  def get
    res.set_redirect WEBrick::HTTPStatus::TemporaryRedirect, params['url']
  end
end

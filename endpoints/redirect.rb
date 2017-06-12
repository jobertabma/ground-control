require_relative '../endpoint'

module Endpoints
  class Redirect < Endpoint
    def call
      res.set_redirect WEBrick::HTTPStatus::TemporaryRedirect, params['url']
    end
  end
end

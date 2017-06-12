require_relative '../endpoint'

module Endpoints
  class PingPong < Endpoint
    def call
      res.content_type = params['content-type'] || 'text/plain'
      res.body = params['body']
    end
  end
end

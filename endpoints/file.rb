require_relative '../endpoint'

module Endpoints
  class File < Endpoint
    def call
      filename = {
        'pixel.png' => 'static/pixel.png',
      }[params['file']]

      res.body = IO.read(filename)
    end
  end
end

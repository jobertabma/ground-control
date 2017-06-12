require_relative '../controller'

class CollectController < Controller
  def get
    res.content_type = 'text/javascript'
    res.body = ERB.new(IO.read('app/views/collect.js.erb')).result
  end
end

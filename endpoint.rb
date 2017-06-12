class Endpoint
  attr_reader :req, :res

  def initialize(req, res)
    @req = req
    @res = res
  end

  def params
    req.query
  end
end

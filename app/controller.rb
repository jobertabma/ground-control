class Controller
  attr_reader :req, :res

  def initialize(req, res)
    @req = req
    @res = res
  end

  def params
    req.query
  end

  def get
    # 501 Not Implemented
    res.status = 501
  end

  def post
    # 501 Not Implemented
    res.status = 501
  end
end

class Controller
  attr_reader :req, :res, :logger

  def initialize(req, res, logger)
    @req = req
    @res = res
    @logger = logger
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

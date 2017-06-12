require_relative '../controller'

class FileController < Controller
  def get
    filename = {
      'pixel.png' => 'static/pixel.png',
    }[params['file']]

    res.body = IO.read(filename)
  end
end
